# Felo Onboarding v2 — Decision Log

Every non-trivial decision goes here with: date, options considered, decision,
rationale. New entries on top.

---

## 2026-04-26 · D-011 through D-028 · PRD lock (Stage 3)

The PRD at [`02-prd/prd-onboarding.md`](./02-prd/prd-onboarding.md) closes all
18 open questions from Stages 1+2 by locking 18 architectural decisions.
Summary here; full rationale per decision is in the PRD itself (§6).

| ID | Decision | Resolves |
|---|---|---|
| **D-011** | OTP TTL = 5 min · max attempts per challenge = 3 · max resends per signup = 3 · then force signup-method switch | (PRD-internal) |
| **D-012** | IP detection: MaxMind GeoLite2 self-hosted (prod) + ipinfo.io (dev) · failure UX = picker with hint, no block | Q3, Q10 |
| **D-013** | Secondary regions cap = 3 in v1 | (PRD-internal) |
| **D-014** | SMS permission copy includes "applies when bank sends SMS to this device" — diaspora users on foreign SIMs aren't pressured | Q14 |
| **D-015** | Multi-earning-type widget precedence: Salaried > Business owner > Freelancer > Investor > Finance pro > Student > Homemaker > Other | Q16, Q18 |
| **D-016** | Secondary-region banks hidden by default in Phase 4.2; "Show banks from my secondary regions" toggle reveals them | Q15 |
| **D-017** | "I'll add accounts later" footer link sets `accounts_deferred = true`; Phase 8 shows richer "Add your first account" CTA | Q7 |
| **D-018** | Investment platform/broker: never auto-prompted during onboarding; surfaced as "Add your broker" CTA per type on Phase 8 dashboard widget | Q5 |
| **D-019** | Budget pre-fill template matrix: `budget_templates` reference table seeded with (region × earning-type) presets; values are starting points, every field editable | (PRD-internal) |
| **D-020** | "Family contribution" budget category is bidirectional: students see "Family allowance received" (inflow), all others see "Family support" (outflow); stored as `budget_categories.semantic ∈ {'inflow','outflow'}` | Q17 |
| **D-021** | Multi-currency goal targets: each goal independently chooses currency from {primary, secondary regions, USD, EUR}; stored as `target_amount_minor + currency`; Phase 8 displays in goal's native currency with primary equivalent in parentheses | Q12 |
| **D-022** | Goal target date: min 30 days, no max; native picker for ≤1y horizons, custom month/year picker for >1y | Q4 |
| **D-023** | Phase 6.1 → 6.2 trigger truth table (8 cases enumerated in PRD §2.6.1); domestic-only "support" alone skips 6.2; any "send regularly" or "receive abroad" fires 6.2 | Q13 |
| **D-024** | Corridor pre-fill rules: diaspora primary regions (CA/UK/US/UAE/SA) default to "Send to" with secondary regions; South Asian primary regions default to "Receive from" with secondary regions; user can always override | (PRD-internal) |
| **D-025** | Phase 7 status messages reference user's actual inputs (no generic strings); 8 templates locked; messages skip if their condition doesn't apply; total Phase 7 = 3-5s | (per canonical narrative; PRD-internal) |
| **D-026** | Phase 7 timeout/error: per-message 6s skip → degraded dashboard; core profile/budget/goals build failure → retryable error (3 attempts) → support email + skip-to-degraded-dashboard option | Q6 |
| **D-027** | "Why we ask" microcopy: always-shown for sensitive Qs (earning type, accounts, budget total, family/remittance); tap-to-reveal for low-stakes (name, goal labels); never shown for signup method or permissions | Q1 |
| **D-028** | Premium-tier disclosure: exactly one place during onboarding — the inline note on the 3rd-goal-tap deselection at Phase 5.2 ("FELO Plus members can set unlimited goals"). No banner on Phase 8. | Q2 |

**Q8** (legacy-flow baseline measurement) and **Q9** (Phase 6.1 wording native-
speaker review) are tracked as Stage 5 sprint tasks, not architectural
decisions.

**Q11** (SMS vendor placeholders) is already covered by D-007.

---

## 2026-04-26 · D-010 · Stage 7 success criterion is "the dashboard reflects every input"

**Source** — `docs/00-discovery/user-journey-as-told.md` Phase 8 + final
"What implementation must remember" rule:

> "The dashboard handoff is the success criterion. Every onboarding input
> must visibly show up on the dashboard for this build to count as done."

**Options considered**
- A) Stage 7 done = "all 8 phases complete + funnel queryable" (the brief's
  default acceptance criterion)
- B) Stage 7 done = A + "every onboarding input demonstrably wired into a
  dashboard widget on the handoff screen"

**Decision** — B.

**Rationale** — The brief originally scoped Phase 8 (Dashboard) as
out-of-scope with only a handoff contract. The user-journey doc tightens
that: Phase 8 isn't just a contract, it's the *test*. If the dashboard
shows generic placeholders, the entire onboarding journey failed
regardless of the funnel completion number.

**Implementation impact for Stage 7**:

- Stage 7 ships a **dashboard handoff stub** (not the full dashboard) that
  renders a configurable widget grid driven by `OnboardingState`:
  - Greeting card → user's `name`
  - Currency badge → primary region's currency
  - Account tiles → one tile per selected bank/wallet (placeholder
    "Connect" CTA — real linking is post-onboarding)
  - Budget ring → total monthly budget from Phase 5.1
  - 2 goal hero cards → with progress rings at 0%, target amount/date
    visible
  - Investment section → present iff Phase 4.4 had selections
  - Remittance tile → present iff Phase 6 had send/receive selections
  - Earning-type widget → tailored row (e.g., "Days until next salary"
    for Salaried; "This week's invoices" for Freelancer)
- A reviewer can run the journey and immediately see "the dashboard
  matches what I told it" — the integration test exercises this assertion
  by snapshotting the handoff screen state for each persona path.

**Tracked debt** — The actual rich dashboard (transactions ledger, charts,
deeper widgets) remains a separate downstream deliverable. The handoff stub
proves the data flowed; v1.1+ will replace its widgets with the real ones
without changing the contract.

---

## 2026-04-26 · D-009 · State persistence: write on every Continue, resume from last step

**Source** — `docs/00-discovery/user-journey-as-told.md` "What implementation
must remember":

> "Every screen must persist state immediately on Continue. Closing the app
> and reopening should resume at the last completed step."

**Options considered**
- A) Persist on field-blur (every keystroke debounced into local + remote state)
- B) Persist on Continue tap only (one write per phase step; resume from last
  completed step)
- C) Persist on app-background (every input held in-memory; flush when user
  backgrounds)

**Decision** — B.

**Rationale** — The user-journey doc explicitly mandates "Continue" as the
write trigger and "last completed step" as the resume anchor. This is the
right UX call:

- A would create write amplification (~50× more writes for the typical
  Phase 5 budget step's 8 categories) and surface partial state on resume
  ("you were typing '23,5'…")
- C is fragile — mobile OSes kill backgrounded apps unpredictably; we'd
  lose data on cold-kill
- B is the natural fit for the "I'll come back to it" mental model: users
  trust that what they confirmed is saved, what they were drafting is not

**Implementation impact**:

- `OnboardingController.continueToNext()` is the only method that writes
  state remotely. Every screen's Continue button calls it.
- Local persistence (`flutter_secure_storage`) is updated synchronously
  inside `continueToNext` *before* the network call so a crash mid-write
  still resumes correctly.
- `OnboardingState.lastCompletedStep` is the resume anchor on cold start.
- Edit-earlier-answer flow: if a user navigates back and changes an answer
  that invalidates a later step (e.g., region change after bank selection),
  the controller marks invalidated steps as `requiresRePrompt`, the
  progress bar reflects this, and Continue from the changed step pushes
  through to the first invalidated step rather than jumping back to where
  they were.

---

## 2026-04-26 · D-008 · 2-goal limit is a hard product constraint

**Source** — `docs/00-discovery/user-journey-as-told.md` Phase 5.2 +
"What implementation must remember" rule #1:

> "The 2-goal limit is a hard product constraint, not a soft suggestion."

**Options considered**
- A) "Up to 2" — soft cap, allow 0/1/2
- B) "At least 1" — soft floor, no upper cap
- C) **Exactly 2** — hard constraint enforced by UI + backend

**Decision** — C.

**Rationale** — Three reasons documented in the journey doc itself:

1. **Decision focus** — research shows users with 2 goals achieve them at
   higher rates than users with 5
2. **Dashboard real estate** — two goals fit beautifully as hero cards;
   five become a cluttered list
3. **Product strategy** — unlimited goals will be a premium feature later;
   "exactly 2" now sets up the upsell organically

**Implementation impact**:

- Goals screen (Phase 5.2) UI: Continue button is disabled until exactly
  2 goal cards are selected. Selecting a 3rd deselects the first (FIFO),
  with a brief inline note "FELO Plus members can set unlimited goals"
  to plant the upsell seed.
- Backend (`POST /v1/onboarding/goals`) validates `goals.length === 2`
  and rejects with `400` otherwise. Don't trust the client.
- DB constraint: the `goals` table for onboarded users has a `slot` column
  (1 or 2) with a partial unique index `(user_id, slot)` so the 2-row
  invariant survives application bugs.
- Tracked: when premium-tier scaffolding lands (post-v1), the slot column
  migrates to allow `slot = 3..N` for Plus users; v1 users stay at 2.

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
