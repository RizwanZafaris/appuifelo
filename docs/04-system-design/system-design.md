# Felo Onboarding v2 — System Design

> **Companion to:** [FRD](../03-frd/frd-onboarding.md) · [PRD](../02-prd/prd-onboarding.md)
> **Date:** 2026-04-26 · **Status:** Awaiting Review Gate 4 approval.
>
> Architecture, data flow, schema, RLS, NestJS endpoints, IP resolver lock,
> SMS DI tokens, multi-sink analytics dispatcher, and journey config service.

---

## 1. Architecture

```mermaid
flowchart TB
    subgraph Phone[Flutter App]
        AppShell[App shell + go_router]
        OnboardingV2[onboarding_v2 feature]
        Riverpod[Riverpod controllers + AnalyticsMixin]
        SecureStorage[(flutter_secure_storage)]
        AppShell --> OnboardingV2
        OnboardingV2 --> Riverpod
        Riverpod --> SecureStorage
    end

    subgraph NestJS["NestJS @ /v1"]
        ConfigCtrl[OnboardingConfigController]
        StateCtrl[OnboardingStateController]
        RegionCtrl[RegionResolveController]
        OtpCtrl[SmsOtpController]
        AnalyticsCtrl[AnalyticsController]
        CompleteCtrl[OnboardingCompleteController]
        Disp[AnalyticsDispatcher]
        SmsReg[SmsProviderRegistry]
        Geo[GeoResolver]
    end

    subgraph Supabase[Supabase]
        AuthSb[(auth.users)]
        Pg[(Postgres / RLS)]
        Storage[(Storage — icons)]
    end

    subgraph External[External]
        Maxmind[(MaxMind GeoLite2 — self-hosted)]
        Ipinfo[(ipinfo.io — dev only)]
        Meta[Meta CAPI]
        GTM[GTM dataLayer / container]
        SmsVendors[SMS vendors:<br/>Twilio · MSG91 · Veevotech ·<br/>Karix · Msegat · etc.]
    end

    Riverpod -- HTTPS + JWT --> ConfigCtrl
    Riverpod -- HTTPS + JWT --> StateCtrl
    Riverpod -- HTTPS + JWT --> RegionCtrl
    Riverpod -- HTTPS + JWT --> OtpCtrl
    Riverpod -- HTTPS + JWT --> AnalyticsCtrl
    Riverpod -- HTTPS + JWT --> CompleteCtrl

    ConfigCtrl --> Pg
    StateCtrl --> Pg
    CompleteCtrl --> Pg
    AnalyticsCtrl --> Disp
    Disp --> Pg
    Disp --> Meta
    Disp -. payload .-> Riverpod
    Riverpod -. dataLayer.push .-> GTM

    RegionCtrl --> Geo
    Geo --> Maxmind
    Geo -. dev .-> Ipinfo

    OtpCtrl --> SmsReg
    SmsReg --> SmsVendors

    NestJS -- Supabase admin client --> AuthSb
```

---

## 2. Data flow per phase

| Phase | Read | Write |
|---|---|---|
| Welcome | `journey_config` (cached) | none |
| Phase 1 (signup) | `journey_config` | `auth.users`, `phone_otp_challenges` (Mobile path), `funnel_sessions.started_at` |
| Phase 2 (region/name) | `regions` (via journey_config), IP resolver | `onboarding_state` |
| Phase 3 (permissions) | `permission_cards` | `permissions` |
| Phase 4.1 earning | `earning_types_master` | `earning_types` |
| Phase 4.2 accounts | `banks`, `wallets` filtered by region | `user_accounts` |
| Phase 4.3-4 invest | `investment_types_master` | `user_investments` |
| Phase 5.1 budget | `budget_templates` matched by (region × earning_type) | `budgets`, `budget_categories` |
| Phase 5.2 goals | `goal_templates` | `goals` (slot 1 + slot 2) |
| Phase 6 corridor | `regions`, `family_remittance_options` | `remittance_preferences` |
| Phase 7 loading | `phase7_status_templates` filtered by user state | `dashboard_configs`, `funnel_sessions.completed_at`, `profiles.onboarding_completed_at`, optional FX/market caches |
| Phase 8 dashboard | `dashboard_configs` | none (handoff stub renders, no writes) |
| Cross-cutting | journey_config (cached) | `events` (every screen), `funnel_sessions.last_step_reached` |

---

## 3. Postgres schema (`db/supabase/006_onboarding_v2.sql`)

Additive — extends the existing 5-migration chain. All RLS-scoped to
`auth.uid()` for user-owned tables. Reference tables are publicly readable.

### 3.1 Reference tables (DB-driven content per D-029)

```sql
-- regions: country master list
CREATE TABLE IF NOT EXISTS public.regions (
  iso2          CHAR(2) PRIMARY KEY,
  name          TEXT NOT NULL,
  currency_iso  CHAR(3) NOT NULL,
  dial_code     TEXT NOT NULL,           -- e.g. '+92'
  default_locale TEXT NOT NULL DEFAULT 'en',
  display_order INT NOT NULL DEFAULT 100,
  is_primary_market BOOLEAN NOT NULL DEFAULT FALSE,  -- PK/IN/BD/NP/LK true
  is_diaspora_corridor BOOLEAN NOT NULL DEFAULT FALSE -- CA/UK/US/UAE/SA true
);

-- banks: per-region bank list
CREATE TABLE IF NOT EXISTS public.banks (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  region_iso2 CHAR(2) NOT NULL REFERENCES public.regions(iso2),
  slug        TEXT NOT NULL,
  name        TEXT NOT NULL,
  logo_url    TEXT,
  display_order INT NOT NULL DEFAULT 100,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE (region_iso2, slug)
);
CREATE INDEX idx_banks_region ON public.banks(region_iso2) WHERE is_active;

-- wallets: per-region wallet list (JazzCash, Easypaisa, Wise, etc.)
CREATE TABLE IF NOT EXISTS public.wallets (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  region_iso2 CHAR(2) NOT NULL REFERENCES public.regions(iso2),
  slug        TEXT NOT NULL,
  name        TEXT NOT NULL,
  logo_url    TEXT,
  is_international BOOLEAN NOT NULL DEFAULT FALSE,  -- Wise/PayPal show in PK list for diaspora
  display_order INT NOT NULL DEFAULT 100,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE (region_iso2, slug)
);

-- earning_types_master: Phase 4.1 options
CREATE TABLE IF NOT EXISTS public.earning_types_master (
  slug TEXT PRIMARY KEY,
  display_order INT NOT NULL DEFAULT 100,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);
INSERT INTO public.earning_types_master(slug, display_order) VALUES
  ('salaried', 10), ('freelancer', 20), ('business_owner', 30),
  ('investor', 40), ('finance_professional', 50), ('student', 60),
  ('homemaker', 70), ('other', 80) ON CONFLICT DO NOTHING;

-- investment_types_master: Phase 4.4 options
CREATE TABLE IF NOT EXISTS public.investment_types_master (
  slug TEXT PRIMARY KEY,
  display_order INT NOT NULL DEFAULT 100,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);
INSERT INTO public.investment_types_master(slug, display_order) VALUES
  ('stocks', 10), ('mutual_funds', 20), ('crypto', 30),
  ('gold', 40), ('real_estate', 50), ('bonds_sukuk', 60),
  ('other', 70) ON CONFLICT DO NOTHING;

-- family_remittance_options: Phase 6.1 options
CREATE TABLE IF NOT EXISTS public.family_remittance_options (
  slug TEXT PRIMARY KEY,
  display_order INT NOT NULL DEFAULT 100,
  triggers_step2 BOOLEAN NOT NULL,    -- D-023 truth table
  is_mutually_exclusive BOOLEAN NOT NULL DEFAULT FALSE
);
INSERT INTO public.family_remittance_options VALUES
  ('send_regularly', 10, TRUE, FALSE),
  ('receive_abroad', 20, TRUE, FALSE),
  ('support_financially', 30, FALSE, FALSE),  -- D-023: triggers only if cross-border secondary
  ('manage_household', 40, FALSE, FALSE),
  ('none', 99, FALSE, TRUE) ON CONFLICT DO NOTHING;

-- goal_templates: Phase 5.2 card grid
CREATE TABLE IF NOT EXISTS public.goal_templates (
  slug TEXT PRIMARY KEY,
  default_label TEXT NOT NULL,
  icon_key TEXT NOT NULL,                  -- icon name from app's icon set
  display_order INT NOT NULL DEFAULT 100,
  is_custom BOOLEAN NOT NULL DEFAULT FALSE,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);
INSERT INTO public.goal_templates(slug, default_label, icon_key, display_order, is_custom) VALUES
  ('home', 'Buy a home', 'home', 10, FALSE),
  ('vehicle', 'Buy a vehicle', 'car', 20, FALSE),
  ('education_fund', 'Education fund', 'graduation_cap', 30, FALSE),
  ('travel', 'Travel', 'plane', 40, FALSE),
  ('wedding', 'Wedding', 'rings', 50, FALSE),
  ('family_planning', 'Family planning', 'family', 60, FALSE),
  ('retirement', 'Retirement', 'sun', 70, FALSE),
  ('build_wealth', 'Build wealth', 'trending_up', 80, FALSE),
  ('emergency_fund', 'Emergency fund', 'shield', 90, FALSE),
  ('hajj_umrah', 'Hajj/Umrah', 'kaaba', 100, FALSE),
  ('custom', 'Custom', 'pencil', 999, TRUE)
  ON CONFLICT DO NOTHING;

-- budget_templates: Phase 5.1 pre-fill matrix per D-019
CREATE TABLE IF NOT EXISTS public.budget_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  region_iso2 CHAR(2) NOT NULL REFERENCES public.regions(iso2),
  earning_type TEXT NOT NULL REFERENCES public.earning_types_master(slug),
  category_slug TEXT NOT NULL,
  default_pct INT NOT NULL CHECK (default_pct BETWEEN 0 AND 100),
  default_currency CHAR(3) NOT NULL,
  display_order INT NOT NULL DEFAULT 100,
  semantic TEXT NOT NULL CHECK (semantic IN ('inflow', 'outflow')),  -- D-020
  UNIQUE (region_iso2, earning_type, category_slug)
);

-- permission_cards: Phase 3 card content (D-014)
CREATE TABLE IF NOT EXISTS public.permission_cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,           -- 'sms', 'notifications', 'location', 'contacts'
  title_key TEXT NOT NULL,             -- references journey_strings
  body_key TEXT NOT NULL,
  visible_on_platforms TEXT[] NOT NULL DEFAULT '{ios,android}',  -- SMS = '{android}'
  is_optional BOOLEAN NOT NULL DEFAULT FALSE,
  display_order INT NOT NULL DEFAULT 100
);

-- phase7_status_templates: D-025 status messages
CREATE TABLE IF NOT EXISTS public.phase7_status_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_key TEXT NOT NULL UNIQUE,
  template_string_key TEXT NOT NULL,        -- references journey_strings
  display_order INT NOT NULL,
  trigger_condition_sql TEXT NOT NULL       -- e.g. "user_accounts.length > 0"
);

-- journey_strings: i18n-ready string catalog
CREATE TABLE IF NOT EXISTS public.journey_strings (
  key TEXT NOT NULL,
  locale TEXT NOT NULL DEFAULT 'en',
  value TEXT NOT NULL,
  PRIMARY KEY (key, locale)
);

-- journey_config_versions: cache invalidation key
CREATE TABLE IF NOT EXISTS public.journey_config_versions (
  id INT PRIMARY KEY DEFAULT 1 CHECK (id = 1),  -- singleton row
  current_version TEXT NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
INSERT INTO public.journey_config_versions VALUES (1, '1', now()) ON CONFLICT DO NOTHING;
```

### 3.2 Per-user state tables

```sql
-- onboarding_sessions: lifecycle of an onboarding attempt
CREATE TABLE IF NOT EXISTS public.onboarding_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,  -- NULL for anonymous pre-Phase-1
  device_id TEXT,                    -- for anonymous resume
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at TIMESTAMPTZ,
  current_phase INT NOT NULL DEFAULT 1,
  current_step TEXT NOT NULL DEFAULT 'welcome',
  last_activity_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  abandoned_at TIMESTAMPTZ,
  abandoned_step TEXT,
  payload JSONB NOT NULL DEFAULT '{}'::jsonb  -- partial state for resume
);
CREATE INDEX idx_onboarding_sessions_user ON public.onboarding_sessions(user_id);

-- onboarding_state: consolidated user state during the journey
CREATE TABLE IF NOT EXISTS public.onboarding_state (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  session_id UUID REFERENCES public.onboarding_sessions(id),
  primary_region CHAR(2) REFERENCES public.regions(iso2),
  secondary_regions TEXT[] NOT NULL DEFAULT '{}',  -- max 3 per D-013
  name TEXT,
  ip_country CHAR(2),                                -- IP-detected at signup
  accounts_deferred BOOLEAN NOT NULL DEFAULT FALSE,
  invests BOOLEAN,
  last_completed_step TEXT,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- permissions: Phase 3
CREATE TABLE IF NOT EXISTS public.permissions (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  sms BOOLEAN,
  notifications BOOLEAN,
  location BOOLEAN,
  contacts BOOLEAN,
  granted_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- earning_types: per-user (Phase 4.1)
CREATE TABLE IF NOT EXISTS public.user_earning_types (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type TEXT NOT NULL REFERENCES public.earning_types_master(slug),
  custom_value TEXT,                                  -- only for 'other'
  PRIMARY KEY (user_id, type)
);

-- user_accounts: Phase 4.2
CREATE TABLE IF NOT EXISTS public.onb_user_accounts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  account_kind TEXT NOT NULL CHECK (account_kind IN ('bank','wallet')),
  provider_slug TEXT NOT NULL,
  region_iso2 CHAR(2) NOT NULL REFERENCES public.regions(iso2),
  added_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (user_id, account_kind, provider_slug, region_iso2)
);

-- user_investments: Phase 4.4
CREATE TABLE IF NOT EXISTS public.user_investments (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  investment_type TEXT NOT NULL REFERENCES public.investment_types_master(slug),
  custom_value TEXT,
  PRIMARY KEY (user_id, investment_type)
);

-- remittance_preferences: Phase 6
CREATE TABLE IF NOT EXISTS public.remittance_preferences (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  options TEXT[] NOT NULL DEFAULT '{}',           -- slugs from family_remittance_options
  sends_to TEXT[] NOT NULL DEFAULT '{}',          -- ISO-2 country codes
  receives_from TEXT[] NOT NULL DEFAULT '{}',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- onboarding goals: extends existing goals table with onboarding-specific
-- columns. Per D-008 the slot column enforces the 2-row invariant.
ALTER TABLE public.goals
  ADD COLUMN IF NOT EXISTS slot SMALLINT CHECK (slot IN (1,2)),
  ADD COLUMN IF NOT EXISTS template_slug TEXT REFERENCES public.goal_templates(slug),
  ADD COLUMN IF NOT EXISTS custom_label TEXT;
CREATE UNIQUE INDEX IF NOT EXISTS uq_goals_slot
  ON public.goals(user_id, slot) WHERE slot IS NOT NULL;

-- Extend budget_categories with semantic flag (D-020)
ALTER TABLE public.budget_categories
  ADD COLUMN IF NOT EXISTS semantic TEXT
    NOT NULL DEFAULT 'outflow'
    CHECK (semantic IN ('inflow','outflow'));

-- phone_otp_challenges (D-005..D-014, D-011)
CREATE TABLE IF NOT EXISTS public.phone_otp_challenges (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  phone_e164 TEXT NOT NULL,
  code_hash TEXT NOT NULL,                           -- PBKDF2-SHA256
  expires_at TIMESTAMPTZ NOT NULL,
  attempts INT NOT NULL DEFAULT 0,
  used_at TIMESTAMPTZ,
  provider_name TEXT NOT NULL,
  ip_detected_country CHAR(2),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_phone_otp_phone_active ON public.phone_otp_challenges(phone_e164)
  WHERE used_at IS NULL;
```

### 3.3 Analytics tables (D-030)

```sql
-- events: every analytics event lands here (sink 1)
CREATE TABLE IF NOT EXISTS public.events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,  -- null for anonymous
  session_id UUID NOT NULL,
  event_name TEXT NOT NULL,
  frd_id TEXT,                                       -- D-001 traceability
  step_id TEXT,
  phase INT,
  properties JSONB NOT NULL DEFAULT '{}'::jsonb,
  ip_country CHAR(2),                                -- redacted from raw IP
  user_agent TEXT,
  locale TEXT,
  occurred_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_events_user ON public.events(user_id, occurred_at);
CREATE INDEX idx_events_session ON public.events(session_id);
CREATE INDEX idx_events_name ON public.events(event_name, occurred_at);

-- funnel_sessions: end-to-end journey tracking
CREATE TABLE IF NOT EXISTS public.funnel_sessions (
  session_id UUID PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  device_id TEXT,
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at TIMESTAMPTZ,
  last_step_reached TEXT,
  abandoned_at TIMESTAMPTZ,
  abandoned_step TEXT,
  signup_method TEXT,                                -- google/apple/facebook/email/mobile
  primary_region CHAR(2),
  install_source TEXT                                -- attribution for marketing analytics
);
CREATE INDEX idx_funnel_user ON public.funnel_sessions(user_id);
```

### 3.4 RLS policies

```sql
-- Reference tables: public read, no public write
ALTER TABLE public.regions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.banks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wallets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.earning_types_master ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.investment_types_master ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.family_remittance_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.goal_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.budget_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.permission_cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.phase7_status_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.journey_strings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.journey_config_versions ENABLE ROW LEVEL SECURITY;

CREATE POLICY ref_public_read ON public.regions FOR SELECT USING (TRUE);
CREATE POLICY ref_public_read ON public.banks FOR SELECT USING (TRUE);
-- (repeat for each reference table; admin writes via service-role key only)

-- Per-user tables: scoped to auth.uid()
ALTER TABLE public.onboarding_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_owned ON public.onboarding_sessions
  FOR ALL USING (user_id = auth.uid());

ALTER TABLE public.onboarding_state ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_owned ON public.onboarding_state
  FOR ALL USING (user_id = auth.uid());

ALTER TABLE public.permissions ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_owned ON public.permissions FOR ALL USING (user_id = auth.uid());

-- (repeat for user_earning_types, onb_user_accounts, user_investments,
--  remittance_preferences)

-- Analytics: insert allowed by auth.uid(), select admin-only
ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;
CREATE POLICY events_self_insert ON public.events
  FOR INSERT WITH CHECK (user_id = auth.uid() OR user_id IS NULL);
-- Select policy is intentionally absent for non-admin; service-role bypasses RLS

ALTER TABLE public.funnel_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY funnel_self ON public.funnel_sessions
  FOR ALL USING (user_id = auth.uid() OR user_id IS NULL);

-- phone_otp_challenges: admin-only (challenge content is sensitive)
ALTER TABLE public.phone_otp_challenges ENABLE ROW LEVEL SECURITY;
-- No user-facing policy. Service role bypasses RLS.
```

### 3.5 Seed data (illustrative)

The migration ships with seed for:
- 10 regions (PK, IN, BD, NP, LK, CA, UK, US, AE, SA)
- ~14 PK banks (HBL, Meezan, UBL, MCB, Allied, Faysal, Bank Alfalah, SCB,
  Bank Al Habib, Askari, NBP, Habib Metro, Soneri, Silk Bank)
- 5 PK wallets (JazzCash, Easypaisa, SadaPay, NayaPay, Zindigi) + 3
  international (Wise, Payoneer, PayPal — flagged `is_international = true`)
- ~9 IN banks (HDFC, ICICI, SBI, Axis, Kotak, PNB, BoB, Canara, IDFC)
- 4 IN wallets (Paytm, PhonePe, Google Pay, Amazon Pay)
- ~8 UAE banks (ENBD, ADCB, FAB, Mashreq, Wio, ADIB, DIB, RAK Bank)
- 2 UAE wallets (Careem Pay, e&money)
- 6 budget templates (PK × {Salaried, Freelancer, Student, Business owner},
  CA × Salaried, BD × Student) per D-019
- 11 goal templates (10 + custom) per Phase 5.2
- 8 phase 7 status templates per D-025
- ~30 journey_strings keys × `en` locale (welcome copy, microcopy, etc.)

Full seed lives in `006_onboarding_v2.sql`.

---

## 4. NestJS endpoints

```
POST   /v1/onboarding/region/resolve            → IP→country/currency/dial_code
GET    /v1/onboarding/journey-config            → DB-driven content payload (D-029)
GET    /v1/onboarding/sessions/me               → resume in-flight session
POST   /v1/onboarding/sessions                  → start session (anonymous OK)
PATCH  /v1/onboarding/state                     → write OnboardingState delta
PATCH  /v1/onboarding/permissions               → finalize Phase 3 grants
POST   /v1/onboarding/complete                  → Phase 7 background work
GET    /v1/onboarding/funnel/dropoff            → admin-only funnel query
POST   /v1/sms/otp/send                         → resolve provider + send OTP
POST   /v1/sms/otp/verify                       → verify OTP + issue signupToken
POST   /v1/analytics/event                      → multi-sink dispatch (D-030)
```

All authenticated endpoints accept Supabase JWT in `Authorization: Bearer`.
Reference data reads (banks, wallets, etc.) inside `journey-config` are
public — no auth required, served via Cloudflare CDN with cache key
`{region_iso2}|{version_hash}`.

---

## 5. Journey config service (D-029)

**`OnboardingConfigController`** returns a single payload with everything
the Flutter app needs to render every screen:

```typescript
interface JourneyConfigPayload {
  version: string;                          // version_hash for cache invalidation
  regions: Region[];
  banks_by_region: Record<string, Bank[]>;
  wallets_by_region: Record<string, Wallet[]>;
  earning_types: EarningType[];
  investment_types: InvestmentType[];
  family_remittance_options: FamilyRemittanceOption[];
  goal_templates: GoalTemplate[];
  budget_templates_by_region_earning: Record<string, BudgetTemplate[]>;
  permission_cards: PermissionCard[];
  phase7_status_templates: StatusTemplate[];
  strings: Record<string, string>;          // {locale: en} flat key→value
  signup_methods: SignupMethod[];
}
```

Cached on:
- **CDN edge** (Cloudflare) — keyed by version_hash; non-PII; long TTL
- **Flutter app** — keyed by version_hash; 24h TTL with foreground refresh
- **NestJS in-memory** — 5-min LRU on the controller

Updating reference content is a SQL `UPDATE` on the relevant table + a
trigger that bumps `journey_config_versions.current_version`. CDN purge
on version bump. Next app foreground re-fetches.

---

## 6. Multi-sink analytics dispatcher (D-030)

```typescript
// src/modules/analytics/analytics-dispatcher.service.ts (Stage 7 implementation)

@Injectable()
export class AnalyticsDispatcher {
  constructor(
    @Inject(SINKS) private readonly sinks: AnalyticsSink[],
  ) {}

  async dispatch(event: CanonicalEvent): Promise<DispatchResult> {
    // Always-on: Postgres sink (sync, blocking)
    const postgresResult = await this.findSink('postgres')!.send(event);

    // Async, non-blocking: Meta CAPI + future TikTok/Snap
    const asyncSinks = this.sinks.filter(s => s.async);
    asyncSinks.forEach(s => {
      s.send(event).catch(err => this.logSinkError(s.name, err));
    });

    // Return GTM payload synchronously so Flutter can dataLayer.push
    const gtmPayload = this.findSink('gtm')!.format(event);
    return { ok: postgresResult.ok, gtmPayload };
  }
}

interface AnalyticsSink {
  name: 'postgres' | 'meta_capi' | 'gtm' | 'tiktok' | 'snap';
  async: boolean;
  send(event: CanonicalEvent): Promise<{ok: boolean}>;
  format?(event: CanonicalEvent): unknown;  // for client-side sinks
}
```

**Postgres sink** — sync insert into `events` table. RLS guarantees
tenant scoping for non-admin reads.

**Meta CAPI sink** — POST to Meta Graph API `/v18.0/{pixel_id}/events`
with payload:
```json
{
  "data": [{
    "event_name": "Onboarding_Phase5_Goals_Completed",  // FB-friendly name
    "event_time": 1714092345,
    "event_id": "evt_<uuid>",                            // dedup with client pixel
    "user_data": {
      "em": "<sha256 hash>",                             // hashed email
      "ph": "<sha256 hash>",                             // hashed phone E.164
      "fbp": "<browser cookie>",
      "client_ip_address": "<IP>",
      "client_user_agent": "<UA>"
    },
    "custom_data": { /* canonical event properties */ },
    "action_source": "app"
  }],
  "access_token": "<META_CAPI_ACCESS_TOKEN>"
}
```

Failure modes: 4xx → log + drop (bad payload, our bug); 5xx → exponential
backoff with 3 retries.

**GTM dataLayer sink** — server returns the formatted payload to Flutter
in the `/v1/analytics/event` response. Flutter pushes to `dataLayer` via
JS bridge or native plugin. GTM container resolves to whatever tags
marketing has configured (Google Ads, LinkedIn Insight, etc.).

**Future sinks** — adding TikTok or Snap is a new file implementing
`AnalyticsSink` + adding the env-driven token. No change to dispatcher.

---

## 7. IP resolver vendor lock (D-012)

**Production:** **MaxMind GeoLite2** self-hosted (downloaded weekly via
their feed; `~70MB` binary; no third-party API calls per resolve)

```yaml
# docker-compose snippet for backend
services:
  api:
    volumes:
      - ./geoip:/var/lib/geoip:ro
    environment:
      - GEOIP_DB_PATH=/var/lib/geoip/GeoLite2-Country.mmdb
```

Weekly cron job pulls the latest DB file from MaxMind via license key.

**Development:** **ipinfo.io** with free tier (50k requests/month). Easier
local dev — no DB file to mount.

**Switching is env-driven:**
```typescript
// src/modules/onboarding/geo-resolver.service.ts
const provider = process.env.GEOIP_PROVIDER === 'maxmind'
  ? new MaxmindResolver(process.env.GEOIP_DB_PATH)
  : new IpinfoResolver(process.env.IPINFO_TOKEN);
```

---

## 8. SMS provider DI tokens (D-005, D-006, D-007)

```typescript
// src/modules/sms-verification/sms-providers.module.ts (Stage 7)

export const SMS_PROVIDERS = Symbol('SMS_PROVIDERS');

@Module({
  providers: [
    SmsProviderRegistry,
    SmsService,
    {
      provide: SMS_PROVIDERS,
      useFactory: (cfg: ConfigService): SmsProvider[] => {
        const providers: SmsProvider[] = [];
        if (cfg.get('SMS_TWILIO_ACCOUNT_SID')) {
          providers.push(new TwilioProvider(cfg));
        }
        if (cfg.get('SMS_PK_VENDOR_API_KEY')) {
          providers.push(new PkVendorProvider(cfg));     // placeholder per D-007
        }
        if (cfg.get('SMS_IN_VENDOR_API_KEY')) {
          providers.push(new InVendorProvider(cfg));
        }
        // ... other corridors
        if (cfg.get('SMS_DEV_LOGGER') === 'true') {
          providers.push(new ConsoleLoggerProvider());
        }
        return providers;
      },
      inject: [ConfigService],
    },
  ],
  exports: [SmsService],
})
export class SmsVerificationModule {}
```

The `<PkVendorProvider>` etc. names are placeholders. As contracts close,
add the concrete adapter file + env var, no other code changes needed
(`SmsProviderRegistry` self-registers from DI tokens at boot per
FR-12.0.1).

---

## 9. State persistence flow (D-009)

### Local (Flutter)

```
On Continue tap:
  state.lastCompletedStep = currentStep
  state.<phase_delta> = collected_inputs
  flutter_secure_storage.write(JSON(state))         // sync
  fire_and_forget(api.patchOnboardingState(state))  // async; retry next Continue if failed
  navigate(next_step)
```

### Resume

```
On cold start:
  if auth_session active:
    state = flutter_secure_storage.read() ?? api.getResumeState()
    if state.lastCompletedStep != null:
      if (now - state.updated_at) < 7 days:
        navigate(next_step_after(state.lastCompletedStep))
      else:
        prompt("Pick up where you left off?")
    else:
      navigate(welcome)
```

### Edit-earlier-answer cascade

```
On user navigating Back + changing primary_region (Phase 2.1):
  affectedSteps = stepsThatDependOn('primary_region')   // = ['phase4_step2', 'phase6_step2']
  for step in affectedSteps:
    state[step].requiresRePrompt = true
  on_continue_from_changed_step:
    if next_step.requiresRePrompt:
      navigate(next_step) and clear its prior payload
```

---

## 10. Stage 7 implementation contract

When Stage 7 starts, every Stage 4 artifact becomes a check-against:

| Artifact | Used by Stage 7 to |
|---|---|
| FRD (78 entries) | One implementation task per FR; one test per acceptance criterion |
| `006_onboarding_v2.sql` | Apply to live Supabase via `apply-006.ts` runner |
| RLS policies | Verify each via integration test that auth.uid() != row.user_id is rejected |
| NestJS endpoints | Each becomes a controller; e2e tests cover happy + error paths |
| Journey config payload | Flutter reads at app launch; per-screen widget tests assert config-driven rendering |
| Multi-sink dispatcher | Integration test that one event lands in all configured sinks |
| IP resolver | Mocked in tests; live via env at runtime |
| SMS provider | `ConsoleLoggerProvider` for dev; real adapters guarded by env |

Stage 7 ships when the journey runs end-to-end on iOS + Android simulators,
all 5 persona integration tests assert correct Phase 8 dashboard rendering,
and the funnel queries (Stage 6 deliverable) return sensible numbers from
synthetic test users.

---

## 11. Open at Review Gate 4

This document **introduced zero new product decisions**. Two implementation
specifics worth flagging for explicit confirmation:

1. **MaxMind GeoLite2 license** — self-hosting requires a free MaxMind
   account and weekly DB pulls via their license key. Should be procured
   before Stage 7. Cost: $0 (GeoLite2 is free tier).
2. **Meta CAPI access token** — required env var `META_CAPI_ACCESS_TOKEN`
   + `META_PIXEL_ID`. Must be procured from Meta Business Manager before
   Stage 7. Cost: $0 for the API itself (ad spend is separate).

If either of these isn't in motion, flag at this gate so they can run in
parallel with Stage 5-6.

---

## 12. Sign-off checklist for Review Gate 4

- [ ] Architecture diagram is accurate
- [ ] All 78 FRs are addressable (no FR has "TBD" behavior)
- [ ] `006_onboarding_v2.sql` is complete and idempotent
- [ ] RLS policies cover every per-user table
- [ ] Endpoint list is exhaustive
- [ ] Multi-sink dispatcher contract (D-030) is implementable as specified
- [ ] Journey config contract (D-029) supports all DB-driven content
- [ ] No new product decisions surfaced

When all checked, reply **"approved, continue"** and Stage 5 (Sprint Plan)
starts.
