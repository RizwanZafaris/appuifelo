# Felo Onboarding v2 — Decision Log

Every non-trivial decision goes here with: date, options considered, decision,
rationale. New entries on top.

---

## 2026-04-26 · D-007 · SMS-vendor list is illustrative, not procured

**Context** — User has active vendor discussions but no signed contracts yet.

**Decision** — The vendor list in D-005 (Veevotech / MSG91 / Karix / Msegat /
AlphaNet / Sparrow / Mobitel / Twilio) is treated as **placeholder**, not
locked. The Strategy pattern + corridor-keyed registry are the real architectural
commitments; specific provider names get plugged in when procurement closes.

**Implementation impact** — Stage 7 ships:
- The `SmsProvider` interface
- The `SmsProviderRegistry` with env-driven provider activation
- A `ConsoleLogger` provider for dev (always works, prints OTP to logs)
- A `Twilio` adapter as the universal fallback (requires only one signed
  contract to unblock all corridors at production launch)

Concrete corridor adapters get added one-by-one as contracts close. **No
hard-coded vendor names in the code path** — providers self-register via
DI tokens, so adding a new vendor is a new file + module manifest entry.

---

## 2026-04-26 · D-006 · SMS routing key: IP-detected location, not E.164 prefix

**Context** — User pointed out that the IP-to-region resolver (D-003) already
runs at signup, so we know where the user *physically is* before they enter
their phone number. This avoids the diaspora edge case raised at Review Gate 0.

**Decision** — SMS provider selection uses **two-key routing** with priority:

1. **Primary key — IP-detected country** at signup time
   (resolved via `POST /v1/onboarding/region/resolve` in Phase 2 of the journey,
   cached in the onboarding session)
2. **Secondary key — E.164 destination prefix** (used when IP is unavailable
   or the IP-detected country has no provider registered)
3. **Final fallback** — universal Twilio (or `ConsoleLogger` in dev)

**Rationale** — IP-based routing handles the actual common cases better:

- **Resident user** (IP=PK, phone=PK) → Veevotech (local cheap)
- **Diaspora signing up at home** (IP=CA, phone=CA) → Twilio (local cheap)
- **Diaspora using PK SIM in CA** (IP=CA, phone=PK) → **Twilio CA route**
  delivers internationally to PK number; this matches diaspora user
  expectations (the SMS arrives wherever the SIM is, not via a "weird local
  PK provider sending to a Canadian-resident user")
- **VPN user pretending to be in PK** (IP=PK via VPN, phone=CA) → Veevotech
  attempts international delivery; failure mode is acceptable (signup fails
  loudly, user retries without VPN)

Cost trade-off — the diaspora-with-foreign-SIM case is now slightly more
expensive than pure E.164 routing would be. But:

- Volume is low (most users sign up with a SIM that matches where they live)
- UX consistency wins over per-corridor cost optimization for v1
- The cheap routing kicks in for ≥85% of users (residents)

**IP detection failure handling** — if the resolver returns no country (rare;
e.g., corporate proxy, satellite ISP), fall through to E.164. If both fail,
use Twilio.

**Privacy note** — IP→country lookup uses a server-side resolver in NestJS
(not client-side, which would leak the IP to a third-party API). Implementation
options for Stage 4: ip-api.com, ipinfo.io, MaxMind GeoLite2 (self-hosted).
Final pick deferred to Stage 4 with cost + privacy review.

---

## 2026-04-26 · D-005 · SMS verification: pluggable corridor-keyed adapter

**Options considered**
- A) Twilio Verify everywhere — works in 100+ countries, cleanest single-vendor story
- B) Supabase Auth phone OTP — already integrated, no extra vendor cost
- C) Pluggable adapter with corridor-keyed local providers — choose best vendor per market

**Decision** — C.

**Rationale** — South Asian + Gulf + diaspora corridors have wildly different
deliverability, cost, and compliance profiles:

- Pakistan: regulated by PTA; Veevotech / Branded SMS Pakistan / Eocean give
  the best deliverability and lowest per-SMS cost
- India: TRAI's DLT registration is mandatory; MSG91 / Gupshup / Kaleyra are
  pre-registered for OTP templates
- UAE: TRA requires sender-ID whitelisting; Karix / Sinch UAE are local
- Saudi: CITC compliance; Resalat / Msegat handle local routing
- Diaspora corridors (CA/UK/US): Twilio is simplest; sometimes mandatory
  (carrier filter requirements)

**Implementation** — Strategy pattern in NestJS:
- `SmsProvider` interface with `sendOtp(phone, code, locale)`,
  `verifyOtp(phone, code)`
- `SmsService` selects the provider based on E.164 country code prefix
- Each provider is its own NestJS sub-module (Twilio, MSG91, Veevotech,
  Karix, etc.) loaded via env-driven registration
- Defaults: dev mode logs OTP to console; prod mode requires at minimum
  one provider per supported corridor

---

## 2026-04-26 · D-004 · i18n on new onboarding: English-only v1

**Options considered**
- A) EN-only — fastest, deviates from the rest of the app's pattern
- B) EN + UR (matches existing 432-key ARB) — slower, consistent

**Decision** — A. Per brief.

**Tracked debt** — Once the v2 flow proves out, port strings to ARB so the
wider app's i18n machinery (RTL layout, font swap to Noto Nastaliq Urdu) works
end-to-end. Estimated effort: ~200 keys × 2 locales, ~half a day.

---

## 2026-04-26 · D-003 · Backend layer: NestJS controllers (not direct Supabase)

**Options considered**
- A) Flutter writes directly to Supabase via `supabase_flutter` client (brief's literal interpretation)
- B) Flutter writes go through NestJS at `localhost:3000` (consistent with the 9 already-wired domains)

**Decision** — B.

**Rationale** — The existing 9 wired domains (Budgets, Goals, Transactions,
Accounts, Bills, Splits, Profile, Notifications, Coach) all route through
NestJS at `/v1/*`. Direct Supabase from Flutter for onboarding alone would
create a two-backend architecture: harder to audit, two RLS surfaces to keep
in sync, two sets of input validation, two sets of analytics emission points.

Trade-off — slightly slower per request (extra hop), but worth it for
architectural coherence. Edge Function workloads (resolve_region, OTP send)
become NestJS controllers that call the Supabase admin client server-side.

**Subtleties** — Onboarding *reads* (e.g., region/bank/wallet reference data)
can still be fetched via the Supabase REST API directly with the anon key,
since they're public tables. Writes always go through NestJS.

---

## 2026-04-26 · D-002 · Repo strategy: side-by-side `onboarding_v2/`

**Options considered**
- A) Greenfield — initialize a brand-new repo, treat existing as legacy
- B) Extend in place — modify `lib/features/onboarding/` directly
- C) Side-by-side — `lib/features/onboarding_v2/` + feature flag, old flow stays alive

**Decision** — C.

**Rationale** — Yesterday's session shipped 5,500 LOC of wire-through across
9 domains. A greenfield repo would shelf that work. Extending in place would
break the existing onboarding before v2 is proven. Side-by-side allows:
- Preserve all wire-through investment
- A/B old vs new on real users via the feature flag
- Delete the old folder cleanly after v2 ships
- Migration is additive (`006_onboarding_v2.sql`) — zero risk to live data

---

## 2026-04-26 · D-001 · Stage execution model: stop at every review gate

**Options considered**
- A) Sprint through all 7 stages, present at the end
- B) Stop at every gate, summarize, wait for explicit "approved, continue"

**Decision** — B. Per brief, absolute rule.

**Rationale** — Onboarding journey complexity (8 phases, conditional logic,
60-80 FRs, full event traceability) is too high for a single review pass.
Each stage's output materially shapes the next. Reviewing in flight catches
spec drift early.
