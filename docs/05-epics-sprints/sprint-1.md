# Onboarding v2 — Sprint 1

> **Companion to:** [`epics.md`](./epics.md) · [FRD](../03-frd/frd-onboarding.md)
> **Date:** 2026-04-26 · **Status:** Awaiting Review Gate 5 approval.
>
> **Sprint goal:** A user can complete all 8 phases, all data persists in
> Supabase via NestJS, full analytics funnel is queryable.
>
> Single sprint by design — the journey only delivers value end-to-end.
> ~88 stories. Fibonacci-pointed. Total estimate: **~243 points** (~6-8
> engineering weeks for one engineer; ~3-4 weeks with parallelization).

---

## Story format

```
ID:    US-{epic}.{n}
As:    <persona>
I want <action>
So that <outcome>
FR:    <FR-IDs covered>
AC:    <acceptance criteria>
Pts:   <Fibonacci 1/2/3/5/8/13>
Order: <sequencing hint>
```

---

## E0 — Foundation (pre-journey scaffolding)

These ship FIRST, before any phase work. Nothing else can land without them.

| ID | Story | FR | Pts |
|---|---|---|---|
| US-0.1 | Apply migration `006_onboarding_v2.sql` to live Supabase via `apply-006.ts` runner | (schema) | 2 |
| US-0.2 | NestJS `OnboardingModule` skeleton + module wiring + module manifest | — | 2 |
| US-0.3 | NestJS `AnalyticsModule` skeleton with `AnalyticsDispatcher` + Postgres sink | FR-10.0.2, FR-10.0.3 | 5 |
| US-0.4 | Procure MaxMind GeoLite2 license; set up weekly DB-pull cron in CI | — | 3 |
| US-0.5 | Procure Meta CAPI access token + pixel ID; wire env vars | — | 1 |
| US-0.6 | Procure GTM container; set up dataLayer hooks in Flutter (JS bridge for web, native plugin for mobile) | — | 5 |
| US-0.7 | Flutter `lib/features/onboarding_v2/` route shell with feature flag `useOnboardingV2` | — | 2 |
| US-0.8 | Flutter `OnboardingState` Riverpod controller + `flutter_secure_storage` persistence layer | FR-11.0.1 | 5 |
| US-0.9 | Flutter `OnboardingAnalyticsMixin` — auto-fires viewed/completed/back/skipped/validation_error with FR-ID via route metadata | FR-10.0.1 | 5 |
| US-0.10 | Flutter shared widgets: ProgressBar, BackButton, OptionCard (pill chip), CTAButton, OTPInput | — | 5 |

**E0 subtotal: 35 points**

---

## E9 — Journey Config Service (cross-cutting; ship before E1+)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-9.1 | NestJS `OnboardingConfigController` GET `/v1/onboarding/journey-config` returning full payload | FR-9.0.1 | 5 |
| US-9.2 | `journey_config_versions` trigger function — bumps version on any reference table mutation | FR-9.0.3 | 3 |
| US-9.3 | Cloudflare CDN cache rule keyed by `version_hash` | FR-9.0.1 | 2 |
| US-9.4 | Flutter `OnboardingConfigProvider` — caches payload locally with 24h TTL + foreground refresh | FR-9.0.1, FR-9.0.2 | 5 |
| US-9.5 | Bundled fallback config for offline first-launch | FR-9.0.1 | 2 |

**E9 subtotal: 17 points**

---

## E11 — State Persistence (ship before E1+)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-11.1 | NestJS `OnboardingStateController` PATCH `/v1/onboarding/state` (delta merge) | FR-11.0.2 | 3 |
| US-11.2 | Flutter `OnboardingController.continueToNext()` — sync local persist + fire-and-forget remote sync | FR-11.0.1, FR-11.0.2 | 3 |
| US-11.3 | Resume-from-last-completed-step on cold start | FR-11.0.3 | 3 |
| US-11.4 | Edit-earlier-answer invalidation cascade (e.g., region change → invalidate Phase 4.2 banks) | FR-11.0.4 | 5 |

**E11 subtotal: 14 points**

---

## E10 — Analytics dispatcher (server side completes after E0.3)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-10.1 | `analytics-meta-capi.sink.ts` — server-side Meta CAPI adapter with PII hashing | FR-10.0.4 | 5 |
| US-10.2 | `analytics-gtm.sink.ts` — server formats canonical payload to GTM dataLayer shape; Flutter pushes client-side | FR-10.0.5 | 3 |
| US-10.3 | `funnel_sessions` lifecycle: insert on first event, update on each event, abandon detection | FR-10.0.6 | 3 |
| US-10.4 | Integration test: synthetic event hits all 3 sinks (Postgres, GTM payload returned, Meta CAPI mocked) | (test) | 3 |

**E10 subtotal: 14 points**

---

## E12 — SMS Verification (ship in parallel with E1)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-12.1 | `SmsVerificationModule` skeleton + `SmsProvider` interface + `SmsProviderRegistry` | FR-12.0.1 | 3 |
| US-12.2 | `TwilioProvider` adapter (universal fallback) | FR-12.0.3 | 3 |
| US-12.3 | `ConsoleLoggerProvider` (dev mode — logs OTP, never sends) | FR-12.0.3 | 1 |
| US-12.4 | `SmsService.sendOtp()` — IP-based primary routing, E.164 fallback, ConsoleLogger final fallback | FR-12.0.2 | 5 |
| US-12.5 | `POST /v1/sms/otp/send` controller | FR-12.0.3 | 2 |
| US-12.6 | `POST /v1/sms/otp/verify` controller — PBKDF2 verify, attempt counting, used-code destruction | FR-12.0.4 | 3 |
| US-12.7 | Stub adapter scaffold for PK/IN/UAE/SA vendors (no real impl; just env-gated registration patterns) | (D-007) | 3 |

**E12 subtotal: 20 points**

---

## E1 — Identity (Phase 1)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-1.1 | Welcome screen — hero + subtitle + Get-started CTA + sign-in link from journey_strings | FR-1.1.1 | 2 |
| US-1.2 | Sign-up method picker — DB-ordered button list with platform visibility (Apple iOS-only) | FR-1.2.1 | 3 |
| US-1.3 | Google OAuth integration via Supabase Auth | FR-1.2.2 | 3 |
| US-1.4 | Apple OAuth (iOS) | FR-1.2.3 | 3 |
| US-1.5 | Facebook OAuth | FR-1.2.4 | 3 |
| US-1.6 | Email signup → email OTP via Supabase | FR-1.2.5 | 3 |
| US-1.7 | Mobile signup → SMS OTP via E12 SMS service | FR-1.2.6 | 3 |
| US-1.8 | OTP input screen — 6-digit auto-advance + auto-submit + resend timer | FR-1.3.1 | 5 |
| US-1.9 | OTP server-side verification + signupToken issuance | FR-1.3.2 | 3 |
| US-1.10 | E1 widget tests + integration test (Saadia path with Google) | (test) | 3 |

**E1 subtotal: 31 points**

---

## E2 — Region & Profile (Phase 2)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-2.1 | NestJS GeoResolver service + MaxMind binding + ipinfo fallback | FR-2.1.0 | 5 |
| US-2.2 | `POST /v1/onboarding/region/resolve` endpoint | FR-2.1.0 | 2 |
| US-2.3 | Region confirmation screen with IP-pre-filled card | FR-2.1.1 | 3 |
| US-2.4 | Country picker bottom sheet + persist primary region | FR-2.1.2 | 3 |
| US-2.5 | "+ Add another region" multi-select sheet (max 3 per D-013) | FR-2.1.3 | 3 |
| US-2.6 | Name input screen + OAuth name pre-fill | FR-2.2.1, FR-2.2.2 | 2 |
| US-2.7 | E2 widget tests + integration test (Daniyal path with CA + PK secondary) | (test) | 2 |

**E2 subtotal: 20 points**

---

## E3 — Permissions (Phase 3)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-3.1 | Permission cards screen rendered from `permission_cards` table | FR-3.0.1 | 3 |
| US-3.2 | SMS permission via `flutter_sms_inbox` (Android-only) | FR-3.1.1 | 3 |
| US-3.3 | Notifications permission | FR-3.2.1 | 1 |
| US-3.4 | Location permission (optional) | FR-3.3.1 | 1 |
| US-3.5 | Contacts card "coming soon" (deferred) | FR-3.4.1 | 1 |
| US-3.6 | Persist all 4 permission states + Continue | FR-3.0.2 | 2 |
| US-3.7 | E3 widget test (iOS hides SMS card; copy from journey_strings) | (test) | 2 |

**E3 subtotal: 13 points**

---

## E4 — Financial Profile (Phase 4)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-4.1 | Earning type screen (multi-select pill chips from `earning_types_master`) | FR-4.1.1, FR-4.1.2 | 3 |
| US-4.2 | "Other" → text input expansion + custom_value persistence | FR-4.1.2 | 1 |
| US-4.3 | Persist earning types | FR-4.1.3 | 1 |
| US-4.4 | Accounts screen — region-filtered banks + wallets list with search | FR-4.2.1 | 5 |
| US-4.5 | "Show banks from my secondary regions" toggle | FR-4.2.2 | 2 |
| US-4.6 | "I'll add accounts later" footer link → `accounts_deferred = true` | FR-4.2.3 | 2 |
| US-4.7 | Persist accounts selections | FR-4.2.4 | 1 |
| US-4.8 | Investment gate Yes/No screen | FR-4.3.1, FR-4.3.2 | 2 |
| US-4.9 | Investment types screen (multi-select) | FR-4.4.1, FR-4.4.2 | 2 |
| US-4.10 | E4 widget tests + integration test (Faisal path with multi-currency accounts) | (test) | 3 |

**E4 subtotal: 22 points**

---

## E5 — Intent: Budget & Goals (Phase 5)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-5.1 | Budget screen — total + categories rendered from `budget_templates` matched by (region × earning_type) | FR-5.1.1 | 5 |
| US-5.2 | Live total reconciliation + over/under inline notes | FR-5.1.2, FR-5.1.3 | 3 |
| US-5.3 | Bidirectional family-contribution category (Student=inflow, others=outflow per D-020) | FR-5.1.4 | 2 |
| US-5.4 | Persist budget + budget_categories | FR-5.1.5 | 2 |
| US-5.5 | Goals card grid rendered from `goal_templates` | FR-5.2.1 | 3 |
| US-5.6 | Goals selection logic with FIFO at 3rd tap + premium upsell seed (D-008, D-028) | FR-5.2.2 | 5 |
| US-5.7 | Per-goal detail screen (target amount + currency picker per D-021) | FR-5.2.3, FR-5.2.4 | 5 |
| US-5.8 | Date picker switching: native ≤1y / custom MM-YYYY >1y (D-022) | FR-5.2.4 | 3 |
| US-5.9 | Auto-calc required monthly contribution + soft over-ambitious warning | FR-5.2.5 | 3 |
| US-5.10 | Persist goals with `slot ∈ {1,2}`; backend validates count = 2 (D-008) | FR-5.2.6 | 3 |
| US-5.11 | E5 widget tests + integration test (P5 Sana with allowance-received inflow) | (test) | 3 |

**E5 subtotal: 37 points** *(largest epic)*

---

## E6 — Remittance (Phase 6, conditional)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-6.1 | Family/remittance multi-select screen (with "None" mutually exclusive) | FR-6.1.1, FR-6.1.2 | 3 |
| US-6.2 | D-023 truth table evaluator → fire 6.2 or skip | FR-6.1.3 | 5 |
| US-6.3 | Corridor pickers (Send to / Receive from) with D-024 pre-fills | FR-6.2.1, FR-6.2.2, FR-6.2.3 | 5 |
| US-6.4 | E6 widget tests + integration test (Daniyal sees CA→PK pre-filled; Sana skips entirely) | (test) | 2 |

**E6 subtotal: 15 points**

---

## E7 — Personalization (Phase 7)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-7.1 | `POST /v1/onboarding/complete` orchestrates parallel build (profile, dashboard config, FX, market, push token, completion mark) | FR-7.0.1, FR-7.0.2, FR-7.0.6, FR-7.0.7, FR-7.0.8 | 8 |
| US-7.2 | Dashboard widget config builder (FR-7.0.3) — output cached in `dashboard_configs` | FR-7.0.3 | 5 |
| US-7.3 | FX rates pre-fetch service (placeholder static rates OK for v1) | FR-7.0.4 | 2 |
| US-7.4 | Market data pre-fetch service (placeholder OK) | FR-7.0.5 | 2 |
| US-7.5 | Loading screen Flutter — status messages cycle from `phase7_status_templates` filtered by user state | FR-7.1.1 | 5 |
| US-7.6 | Per-message timeout (6s) → degrade; core failure → retryable error (3 attempts) → support escape | FR-7.1.2 | 5 |
| US-7.7 | Continue to Phase 8 navigation | FR-7.1.3 | 1 |
| US-7.8 | E7 widget tests + integration test (status messages reference actual inputs) | (test) | 3 |

**E7 subtotal: 31 points**

---

## E8 — Dashboard Handoff (Phase 8)

| ID | Story | FR | Pts |
|---|---|---|---|
| US-8.1 | Greeting card (locale-aware salutation) | FR-8.1.1 | 1 |
| US-8.2 | Currency badge with secondary-region toggle | FR-8.1.2 | 2 |
| US-8.3 | Account tiles (one per Phase 4.2 selection with "Connect" CTA) | FR-8.1.3 | 3 |
| US-8.4 | "Add your first account" CTA when accounts deferred | FR-8.1.4 | 2 |
| US-8.5 | Budget ring + top 4 category mini-cards (only `amount > 0`) | FR-8.1.5 | 3 |
| US-8.6 | 2 goal hero cards with progress rings + multi-currency display | FR-8.1.6 | 3 |
| US-8.7 | Conditional investment section | FR-8.1.7 | 2 |
| US-8.8 | Conditional remittance tile | FR-8.1.8 | 2 |
| US-8.9 | Earning-type widget per D-015 precedence | FR-8.1.9 | 3 |
| US-8.10 | First-tap tooltip + dismissal | FR-8.2.1 | 1 |
| US-8.11 | **5 integration tests, one per persona, asserting exact dashboard contract** | (test, D-010) | 8 |

**E8 subtotal: 30 points**

---

## Sprint 1 totals

| Epic | Pts | Notes |
|---|---|---|
| E0 Foundation | 35 | Ships first |
| E9 Journey Config | 17 | Ships before E1+ |
| E11 State Persistence | 14 | Ships before E1+ |
| E10 Analytics | 14 | Ships parallel with E1 |
| E12 SMS Verification | 20 | Ships parallel with E1 |
| E1 Identity | 31 | |
| E2 Region | 20 | |
| E3 Permissions | 13 | |
| E4 Financial | 22 | |
| E5 Intent | 37 | Largest epic |
| E6 Remittance | 15 | |
| E7 Personalization | 31 | |
| E8 Dashboard | 30 | |
| **Total** | **299 points** | |

**Velocity assumptions:**
- One Flutter engineer @ 8 pts/week → ~37 weeks (single-threaded, unrealistic)
- One Flutter + one backend engineer @ 16 pts/week combined → ~19 weeks
- 2 Flutter + 1 backend + 1 designer assist @ 30 pts/week → ~10 weeks

**Realistic ship date for v1 (with 2-3 engineers):** ~10-12 weeks from
Stage 7 kickoff.

---

## Definition of Done (Sprint 1)

A user can run the full journey end-to-end and:

1. **All 78 FRs are implemented and have at least one test asserting acceptance criteria**
2. **All 5 personas pass their integration test** asserting per-persona Phase 8 dashboard contract (D-010)
3. **All analytics events fire** with their FR-IDs attached (D-001 traceability rule)
4. **All 3 analytics sinks receive events** for a synthetic onboarding session (Postgres + GTM payload returned + Meta CAPI mocked or live)
5. **RLS policies tested** — auth.uid() != row.user_id rejected
6. **Funnel queries return sensible numbers** when run against synthetic test users (Stage 6 deliverable; tested in this sprint)
7. **Cold-kill mid-flow → resume** at last completed step
8. **`flutter analyze` = 0 errors, 0 warnings**
9. **`flutter test` passes** all journey tests
10. **iOS + Android simulators run cleanly**
11. **README updated** with run instructions for the v2 flow + feature flag

If any of (1)-(6) fails, the journey ships with a documented regression
that must be fixed before launch.

---

## Critical-path implementation order

```
Week 1:  E0 (foundation) ───────────────────────────────────────► E0 done
Week 2:  ───► E9 + E11 in parallel ────────────────────────────► critical scaffolds
Week 3:  ───► E10 + E12 in parallel ────────────────────────────►
Week 4-5: ─► E1 + E2 in journey order ──────────────────────────►
Week 6:   ─► E3 + E4 ───────────────────────────────────────────►
Week 7-8: ─► E5 (largest) ──────────────────────────────────────►
Week 9:   ─► E6 + E7 ────────────────────────────────────────────►
Week 10:  ─► E8 + 5 persona integration tests ──────────────────► v1 candidate
Week 11-12: regression / polish / launch readiness
```

---

## Sprint 1 stretch goals (not part of v1 success)

- Goal **shrink** flow — letting user adjust over-ambitious goals from
  Phase 8 directly (currently link goes back to Phase 5.1)
- A/B test infrastructure — feature-flagged copy variants for H4 microcopy
  validation
- Push notification token register on Phase 7 (currently silent)
- Onboarding analytics dashboard — admin view of funnel queries (Stage 6
  ships the queries; this is the UI on top of them)

---

## Stage 5 surfaced no new architectural decisions

By design. Sprint planning is sequencing + estimation, not product calls.
Decision log remains at 30 entries (D-001 through D-030).

---

## Sign-off checklist for Review Gate 5

- [ ] All 78 FRs covered by at least one story
- [ ] Story point estimates feel realistic given Stage 7 implementation scope
- [ ] Critical-path ordering is correct (E0/E9/E11 first; E1-E8 in journey order)
- [ ] Definition of Done is testable
- [ ] Procurement stories (US-0.4, 0.5, 0.6) flagged for parallel kickoff
- [ ] Q8 (legacy baseline) and Q9 (Phase 6.1 wording) tracked separately

When all checked, reply **"approved, continue"** and Stage 6 (Analytics)
starts.
