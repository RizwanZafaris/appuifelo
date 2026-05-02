# Felo Onboarding v2 — Product Requirements Document

> **Companion to:** [`../00-discovery/user-journey-as-told.md`](../00-discovery/user-journey-as-told.md) (canonical narrative) · [`../00-discovery/discovery.md`](../00-discovery/discovery.md) (Stage 1) · [`../01-personas/personas.md`](../01-personas/personas.md) (Stage 2)
>
> **Date:** 2026-04-26 · **Status:** Awaiting Review Gate 3 approval.
>
> This is the **product spec**. It commits to every product decision the
> downstream stages (FRD, system design, code) need. Stage 3 closes all 18
> open questions from Stages 1 + 2 and produces 18 new architectural
> decisions (D-011 through D-028). Anything contradicted by the canonical
> narrative is a bug — the narrative wins.

---

## Table of contents

1. [Overview](#1-overview)
2. [User journey — 8 phases](#2-user-journey--8-phases)
3. [Global journey rules](#3-global-journey-rules)
4. [Out-of-scope for this sprint](#4-out-of-scope-for-this-sprint)
5. [Acceptance criteria](#5-acceptance-criteria)
6. [Resolved open questions → decisions](#6-resolved-open-questions--decisions)

---

## 1. Overview

### 1.1 Product

A re-architected onboarding journey for the FELO Flutter app — an 8-phase,
~5-7 minute flow that takes a new user from "first launch" to "personalized
dashboard." Lives in `lib/features/onboarding_v2/` side-by-side with the
legacy single-screen flow per [D-002](../decision-log.md).

### 1.2 Scope

| In scope | Out of scope |
|---|---|
| All 8 phases of the journey | Bank API integration |
| Backend writes via NestJS at `/v1/onboarding/*` | Real money movement |
| Pluggable corridor-keyed SMS verification | Crypto trading |
| IP-detected region resolution | Investment advice |
| State persistence (write-on-Continue) | Multi-language UI (EN-only v1) |
| Phase 8 dashboard handoff stub | Premium-tier paywall during onboarding |
| Full event traceability with FR-IDs | Phase 8 rich dashboard (handoff stub only) |

### 1.3 Target users

Per [`../01-personas/personas.md`](../01-personas/personas.md):

- **P1 Saadia** — modal salaried Pakistani (validates baseline market fit)
- **P2 Faisal** — power user with multi-currency / investments
- **P3 Daniyal** — diaspora remitter (validates corridor pre-fill)
- **P4 Bushra** — business owner (validates personal-vs-business framing)
- **P5 Sana** — student / first-time user (validates lowest-friction path)

If any persona breaks during the journey, the PRD is wrong.

### 1.4 Success metrics (link to discovery)

- **North star:** ≥53% of installs reach Phase 8 (Dashboard Reveal)
- Per-step funnel targets per `discovery.md §1.4`
- Per-persona path-length / time targets per `personas.md` summary table
- All 12 hypotheses (H1-H12) measurable via Stage 6 analytics

---

## 2. User journey — 8 phases

The narrative voice in [`user-journey-as-told.md`](../00-discovery/user-journey-as-told.md)
is the experiential spec. This section is the **functional spec** —
mechanism, validation, edge cases, conditional logic.

Each phase is decomposed into steps. Each step has FR forward-references
that Stage 4 will detail.

---

### 2.1 PHASE 1 — Identity (FR-1.x)

#### 2.1.1 Welcome screen (FR-1.1.*)

- Single full-screen splash with hero copy + subtitle + primary CTA
- Hero copy (locked): **"Your money, simply seen."**
  - Tested against alternatives ("Your money, all in one place" / "Personal
    finance for South Asia" / "Track every rupee automatically") and
    selected for: short, evocative, not category-claiming
- Subtitle: **"Track every rupee, every wallet, every bank — in one app."**
- Primary CTA: "Get started"
- Secondary link below CTA: "I already have an account → Sign in"
- Brand wordmark + 2-3 micro-illustrations rotating (no specific spec
  here — Stage 4 / design system handles)
- No permission requests, no auth, no analytics opt-in popups

#### 2.1.2 Signup method picker (FR-1.2.*)

- 5 options as full-width buttons stacked vertically:
  1. Continue with **Google** (OAuth)
  2. Continue with **Apple** (OAuth)
  3. Continue with **Facebook** (OAuth)
  4. Continue with **Email** (→ OTP)
  5. Continue with **Mobile** (→ OTP)
- "Sign in" link below for returning users
- Order matters — OAuth first because of H11 (≥95% completion vs ≥70% for
  email/mobile)

**Conditional behavior:**
- Google/Apple/Facebook → Phase 1 done in 1 tap (skip step 1.3)
- Email/Mobile → step 1.3 (OTP) fires

**Apple-on-Android handling:** Apple sign-in is iOS-only. On Android the
Apple button is hidden. PRD doesn't enumerate this further; Stage 4 FR-1.2.2
specifies the platform check.

#### 2.1.3 OTP verification (FR-1.3.*)

- 6-digit numeric input. Auto-advance per digit. Auto-submit when complete.
- Resend button enabled after 30s. Hard-cap 3 resends per phone/email.
- Input via SMS provider chain (D-005, D-006, D-007). For email, Supabase
  Auth's built-in OTP delivery.
- Error states inline (not modals): "Code didn't match" / "Code expired" /
  "Too many attempts — try a different signup method."

**Conditional behavior:**
- Mobile signup → SMS provider routes by IP-detected country (D-006), with
  E.164 prefix as fallback
- Email signup → Supabase Auth OTP

**Locked decision (D-011):** OTP TTL = 5 minutes. Max attempts per challenge
= 3. After 3 failed attempts, the challenge is destroyed and user must
restart with "Resend code" (counts toward the 3-resend limit). After 3
resends without success, the user is asked to switch signup method.

---

### 2.2 PHASE 2 — Context (FR-2.x)

#### 2.2.1 Confirm region (FR-2.1.*)

- Full-screen with one big card: **"You're in Pakistan?"** (dynamic; example
  shown for Saadia)
- Below the card: **"Yes, that's me"** (primary CTA) + **"Pick a different
  country"** (secondary tap)
- Sub-line: **"+ Add another region"** for users with cross-border ties

**IP detection (locked D-012):**
- Resolver = NestJS endpoint `POST /v1/onboarding/region/resolve` calling
  **MaxMind GeoLite2 self-hosted** (prod) / **ipinfo.io** (dev)
- Falls back gracefully (Q3 default A → C below) if no country detected:
  - Show country picker with the hint: "We couldn't detect your country
    automatically — please pick from the list below."
  - Search field at top of picker. Most-likely countries shown first based
    on app store locale.

**"+ Add another region" flow (locked D-013):**
- Opens a bottom sheet with multi-select country picker
- Adds entries to `onboarding_state.secondary_regions[]`
- Phase 6.2 pre-selections derive from this list
- Maximum 3 secondary regions in v1 (covers all 5 personas with headroom)

**Edit-earlier-answer logic:** If a user changes primary region after
selecting banks in Phase 4.2, mark Phase 4.2 as `requiresRePrompt` (per D-009)
and force re-selection on Continue.

#### 2.2.2 Name input (FR-2.2.*)

- Single text field: **"What should we call you?"**
- Placeholder shows OAuth-provided name if any (`Saadia K.`)
- Validation: 1-60 chars, must not be empty after trim
- No surname split (some markets use single names; some prefer just first)
- Auto-focus on screen mount

---

### 2.3 PHASE 3 — Permissions (FR-3.x)

Single screen with stacked permission cards. Each card has:
- Icon + title + WHY copy + "Allow" / "Skip" buttons
- Each permission independently skippable. Skipping does not block onboarding.

#### 2.3.1 SMS permission (FR-3.1.*) — the wedge

**Locked D-014 — copy:**
- Title: **"Auto-track every transaction"**
- Body: **"If your bank sends transaction SMS to this device, FELO will
  categorize them automatically. You'll never type a number."**
- The phrase **"to this device"** is mandatory (per Q14 from P3 Daniyal —
  diaspora users on foreign SIMs shouldn't feel pressured to grant SMS for
  PK numbers their phone never receives)

**Behavior:**
- Tap Allow → request OS permission (`flutter_sms_inbox` on Android;
  documented as Android-only)
- iOS: card is hidden (iOS doesn't expose SMS read API)
- Tap Skip → record `permissions.sms = false` and continue

#### 2.3.2 Notifications (FR-3.2.*)

- Title: **"Stay on top of your money"**
- Body: **"Bill reminders, budget alerts, and goal updates."**
- Standard OS notification permission flow

#### 2.3.3 Location (FR-3.3.*) — optional

- Title: **"Smart category suggestions"**
- Body: **"We can suggest categories based on where you spent (optional)."**
- Opt-in only; skip is the friendly default

#### 2.3.4 Contacts (FR-3.4.*) — optional

- Title: **"Send money to family faster"** *(deferred feature; mention only)*
- Body: **"For when you want to split bills or send money — coming soon."**
- v1: explicitly says "coming soon" so users know skipping doesn't block anything

---

### 2.4 PHASE 4 — Financial profile (FR-4.x)

#### 2.4.1 Earning type (FR-4.1.*)

- Multi-select pill chips, single screen
- Options: **Salaried · Freelancer · Business owner · Investor · Finance
  professional · Student · Homemaker · Other**
- "Other" → text input (max 60 chars), stored in
  `earning_types.custom_value` for product research
- Continue enabled when ≥1 selected
- "Why we ask" microcopy per D-016 (always-shown for sensitive Qs)

**Locked D-015 (resolves Q16) — Multi-earning-type widget precedence:**

When user picks multiple earning types, Phase 8's earning-type widget uses
this precedence:

1. **Salaried** → "Days until next salary"
2. **Business owner** → "Cash flow this month" (placeholder copy; v1 stub)
3. **Freelancer** → "This week's invoices" (placeholder copy; v1 stub)
4. **Investor** → "Portfolio movement today" (placeholder copy; v1 stub)
5. **Finance professional** → defaults to whatever else they picked, else "Salaried"
6. **Student** → "Days until next allowance"
7. **Homemaker** → "Days remaining in budget cycle"
8. **Other** → "Days remaining in budget cycle"

For Bushra (P4) who picks **Business owner + Salaried + Investor**, the
Salaried widget wins → "Days until next salary." Reasoning: salary is the
most predictable cadence even when other income exists.

#### 2.4.2 Accounts (FR-4.2.*)

- Multi-select pill chips. Title: **"Where do you keep money?"**
- Subtitle: **"Pick all that apply. You can connect them later."**
- List driven by `regions` and `banks`/`wallets` reference tables, filtered
  to user's primary region
- Search field at top (helpful for long lists)

**Locked D-016 (resolves Q15) — Secondary-region banks:**

By default, only primary-region banks/wallets show. A toggle below the search
field reads: **"Show banks from my secondary regions"** (only visible if
secondary regions exist).

For Bushra (PK primary + UAE secondary), Mashreq is hidden until she taps
the toggle. Reasoning: most users want their primary-country accounts; the
toggle satisfies the diaspora-with-cross-border edge case without cluttering
the modal default.

**Locked D-017 (resolves Q7) — "I'll add later":**

A footer link at the bottom: **"I'll add accounts later →"**. Tapping it sets
`onboarding_state.accounts_deferred = true`, advances Phase 4.2 with empty
selection, and Phase 8 shows a richer "Add your first account" CTA in the
account-tile section.

#### 2.4.3 Investment gate (FR-4.3.*)

- Single yes/no question: **"Do you invest?"**
- Two large cards: **Yes / No**
- Tap No → skip Phase 4.4 entirely

#### 2.4.4 Investment types (FR-4.4.*)

Only shown if Phase 4.3 = Yes.

- Multi-select pill chips: **Stocks · Mutual Funds · Crypto · Gold · Real
  Estate · Bonds/Sukuk · Other**
- Continue enabled when ≥1 selected
- "Other" → text input

**Locked D-018 (resolves Q5) — Investment platform/broker capture:**

Phase 4 v1 captures investment **types only**. The Phase 8 dashboard
investment widget shows an **"Add your broker"** CTA per type. Tapping it
opens a bottom sheet (post-Phase-8 flow) where the user picks from
region-filtered broker list. **Never auto-prompted during onboarding.**

---

### 2.5 PHASE 5 — Intent (FR-5.x)

#### 2.5.1 Set monthly budget (FR-5.1.*)

- Total budget at top: large text input with currency prefix (matches
  primary region)
- Below total: stacked category rows (icon + label + amount input)
- Live total reconciliation: as category amounts change, the difference vs
  total is shown ("$300 unallocated" or "$50 over")

**Pre-fill template (locked D-019) — region × earning type matrix:**

A `budget_templates` reference table seeded with templates per (region,
primary-earning-type) combination. v1 ships these templates:

| Region | Earning type | Categories pre-filled (pct of stated typical income) |
|---|---|---|
| PK | Salaried | Food 17% / Transport 8% / Rent 25% / Family support 18% / Shopping 10% / Health 5% / Savings 17% |
| PK | Freelancer | Food 13% / Transport 5% / Rent 25% / Family support 15% / Shopping 8% / Buffer 12% / Savings 22% |
| PK | Student | Food 28% / Transport 8% / Education 10% / Entertainment 16% / Shopping 16% / Family contribution 12% / Savings 10% |
| PK | Business owner | Food 10% / Transport 7% / Rent 18% / Family support 32% / Education 22% / Health 4% / Savings 7% |
| CA | Salaried | Food 18% / Transport 5% / Rent/mortgage 38% / Family support 14% / Daycare 18% / Savings 7% |
| BD | Student | (similar to PK Student, with adjusted denominations) |

Templates that don't exist for a (region, earning) combination fall back to
the closest match (same earning type in nearest region; same region with
"Salaried" as default earning). Template defaults are starting points,
**not prescriptions** — every value is editable.

**Categories with amount = 0 are hidden on Phase 8 dashboard.** This is how
Saadia's "Rent = 0" zero-out cleanly removes the rent ring from her dashboard.

**Locked D-020 (resolves Q17) — "Family contribution" semantic:**

The category label is **bidirectional based on earning type**:

- For "Student" earning type, the row is renamed **"Family allowance received"**
  (positive — what family gives the user) and amount is interpreted as
  monthly inflow, not outflow
- For all other earning types, the row is **"Family support"** (outflow — what
  the user sends to family)
- Stored in `budget_categories.semantic ∈ {'inflow','outflow'}` to disambiguate

**Soft validation:**
- If sum of categories > total: yellow inline note "$X over budget — reduce
  somewhere"
- If sum of categories < total: blue inline note "$X unallocated"
- Neither blocks Continue. The narrative is clear: budget is editable on the
  dashboard later.

#### 2.5.2 Set goals (FR-5.2.*)

- **Exactly 2 goals** required (D-008). Continue disabled until 2 selected.
- Card grid of goal templates: **Buy a home · Buy a vehicle · Education fund ·
  Travel · Wedding · Family planning · Retirement · Build wealth · Emergency
  fund · Hajj/Umrah · Custom**
- Each card has icon + label. Tapping toggles selection (filled vs outlined
  border).
- "Custom" opens a bottom sheet for label entry.
- Tapping a 3rd card deselects the first selected (FIFO) with inline note:
  **"FELO Plus members can set unlimited goals"** (the upsell seed per
  D-008).

After 2 selected → Continue → second screen for goal details:

**Per-goal detail screen (FR-5.2.2):**
- Target amount input with currency picker (D-021)
- Target date picker (D-022)
- Auto-calculated required monthly contribution shown live below

**Locked D-021 (resolves Q12) — Multi-currency goal target:**

Each goal independently allows currency choice. Default = primary region's
currency. Currency picker shows: primary, secondary regions' currencies,
USD/EUR (always available regardless of region). Goal target stored in
`goals.target_amount_minor + goals.currency`. Phase 8 dashboard displays
each goal in its native currency with primary-currency equivalent in
parentheses.

**Locked D-022 (resolves Q4) — Goal target-date validation:**

- Minimum: 30 days from today
- Maximum: no cap (Hajj at age 65 is valid; retirement at 2070 is valid)
- Date picker UI:
  - For target ≤1 year out: native date picker (day-precision)
  - For target >1 year out: custom month/year picker (day-precision is
    meaningless for long-horizon goals)
- Past dates not allowed; users with past targets must update on the
  dashboard later

**Soft warning for over-ambitious goals:**
- If sum of monthly contributions > available budget surplus: amber inline
  banner: **"You'd need ₨X/month — your budget allows ₨Y. Adjust?"** with
  "Adjust budget" link back to Phase 5.1
- Non-blocking. User can acknowledge and continue.

---

### 2.6 PHASE 6 — Remittance (conditional) (FR-6.x)

#### 2.6.1 Family & remittances (FR-6.1.*)

- Multi-select pill list:
  1. I send money to family regularly
  2. I receive money from abroad
  3. I support family members financially
  4. I manage shared household expenses
  5. None of the above

- "None of the above" is mutually exclusive (selecting it deselects 1-4)

**Locked D-023 (resolves Q13) — Phase 6.2 trigger truth table:**

| 6.1 selection | Has secondary region? | Phase 6.2 fires? |
|---|---|---|
| "Send regularly" anywhere | yes | ✅ Yes |
| "Send regularly" anywhere | no | ✅ Yes (defensive — ask anyway) |
| "Receive from abroad" only | any | ✅ Yes |
| "Support financially" only (no Send) | yes (cross-border) | ✅ Yes — defensive (assume cross-border support) |
| "Support financially" only (no Send) | no (domestic only) | ❌ Skip |
| "Manage household" only | any | ❌ Skip (domestic) |
| "None of the above" | any | ❌ Skip |
| Mixed (any cross-border + any domestic) | any | ✅ Yes |

For Faisal (P2) who picks "Receive abroad" + "Support financially" with PK
primary + US secondary → ✅ fires (Receive triggers).

For Saadia (P1) who picks "Support financially" only with PK primary + no
secondary → ❌ skip (domestic-only support).

For Sana (P5) who picks "None of the above" → ❌ skip.

#### 2.6.2 Corridor (FR-6.2.*)

Two pill groups:

- **"Send to" countries** — pre-filled based on D-024 below
- **"Receive from" countries** — pre-filled based on D-024 below

Multi-select. User can override pre-fills.

**Locked D-024 — Corridor pre-fill rules:**

| Primary region | Secondary regions | "Send to" pre-fill | "Receive from" pre-fill |
|---|---|---|---|
| PK | (none) | (none) | (none) |
| PK | UAE | (none) | UAE |
| PK | Saudi | (none) | Saudi |
| PK | UAE + Saudi | (none) | UAE + Saudi |
| CA | PK | PK | (none) |
| CA | PK + UK | PK | UK |
| US | PK | PK | (none) |
| UK | PK | PK | (none) |
| AE | PK | PK | (none) |

General rule: **Diaspora regions (CA / UK / US / UAE / SA as primary) →
"Send to" pre-fills with their secondary regions. South Asian primary
regions (PK / IN / BD / NP / LK) → "Receive from" pre-fills with their
secondary regions.** Users can always override.

---

### 2.7 PHASE 7 — Personalization (FR-7.x)

Full-screen loading state. Background work + status messages.

#### 2.7.1 Status messages (FR-7.1.*)

Messages cycle one at a time, each with a green check when complete. **Every
message references the user's actual inputs.** Generic strings like "Setting
up your account..." are forbidden.

**Locked message templates (D-025):**

| Trigger condition | Status message template |
|---|---|
| always | `"Setting up your {primary_currency} account..."` |
| has accounts | `"Linking {comma_separated_account_list}..."` |
| has accounts (deferred) | `"Setting up your account dashboard..."` |
| always | `"Building your budget for {currency_symbol}{total_budget}..."` |
| has goals | `"Tracking your {goal_1_label} and {goal_2_label}..."` |
| has corridor | `"Connecting your {primary_country} → {top_corridor_country} corridor..."` (or "←" for inbound) |
| has investments | `"Loading your {comma_separated_investment_types}..."` |
| always (last) | `"Personalizing your dashboard, {first_name}..."` |

Each message holds for 400-700ms (varies based on actual backend work
completion). Messages skip if their condition doesn't apply.

**Total Phase 7 duration: 3-5 seconds** (per H7 target). Messages are
front-loaded so the personalized "Tracking your Hajj fund and home down
payment..." line happens early — not at the very end.

#### 2.7.2 Background work (FR-7.2.*)

What's actually happening behind the loading screen (not theater):

1. **Build user_profile object** — POST `/v1/onboarding/complete` consolidates
   all phase data into a single profile/settings/budget/goals/accounts write
2. **Compute dashboard widget configuration** — based on Phase 4-6 inputs
3. **Pre-fetch FX rates** if user has secondary regions or remittance corridor
4. **Pre-fetch market data** if user has investments
5. **Insert initial budget categories + goals** into DB
6. **Initialize push notification token** (if Phase 3 granted) — quietly,
   no user-visible UI
7. **Mark onboarding session as completed** with timestamp

**Locked D-026 (resolves Q6) — Timeout / error handling:**

- **Per-message timeout**: 6 seconds. If any single message's underlying
  work hasn't completed in 6s, skip it and move on to the next. The
  dashboard renders in degraded mode (no FX, no market data) and the
  next-app-launch fetches fix it.
- **Core profile/budget/goals build failure** (steps 1, 5 above): retryable
  error screen. **"We had trouble building your dashboard. Retry?"** with
  state preserved. After 3 failed retries: support email link + skip-to-
  dashboard option (which lands user on a degraded dashboard they can fix
  manually).
- **Background work runs in parallel**, not sequence — this minimizes
  total Phase 7 time. Status messages display in a fixed order regardless
  of completion order.

---

### 2.8 PHASE 8 — Dashboard handoff (FR-8.x)

Out of scope for the rich dashboard. **In scope: a configurable widget grid
that proves data flowed.** Per [D-010](../decision-log.md), this is the
success criterion for Stage 7.

#### 2.8.1 Widget grid (FR-8.1.*)

The dashboard handoff stub renders a configurable widget grid driven by
`OnboardingState`:

| Widget | Renders iff | Driven by |
|---|---|---|
| Greeting card | always | `name`, locale-aware salutation |
| Currency badge | always | `primary_region.currency`; toggle to secondary if any |
| Net position card | always | sum of account balances (Phase 4.2 selections — placeholder $0 for v1) |
| Account tiles | `accounts.length > 0` | one tile per Phase 4.2 selection |
| Account "Add first" CTA | `accounts.length == 0 && accounts_deferred` | per D-017 |
| Budget ring | always | Phase 5.1 total |
| Budget category mini-cards | top 4 categories | Phase 5.1 with `amount > 0` |
| Goal hero card 1 | always (D-008 enforces 2) | Phase 5.2 first selection |
| Goal hero card 2 | always | Phase 5.2 second selection |
| Investment section | `investments.length > 0` | Phase 4.4 selections |
| Remittance tile | Phase 6.2 had ≥1 corridor | Phase 6.2 selections |
| Earning-type widget | always | per D-015 precedence |

#### 2.8.2 First-tap tooltip (FR-8.2.*)

A small one-time tooltip near the first account tile (or the "Add account"
CTA if accounts deferred): **"Connect your first account to start tracking."**
Dismissed permanently once tapped or X'd.

---

## 3. Global journey rules

### 3.1 State persistence (D-009)

Every screen's Continue tap triggers:

1. **Local write** (synchronous): `flutter_secure_storage` updates
   `OnboardingState.lastCompletedStep` and the phase delta
2. **Remote write** (fire-and-forget with retry): NestJS
   `PATCH /v1/onboarding/state`

If the local write fails (rare), the screen blocks Continue with an inline
error and offers "Retry." If the remote write fails, the local state is
authoritative and the next successful Continue includes the missed delta.

### 3.2 Resume behavior

On cold start of an unfinished session:

1. Read `OnboardingState.lastCompletedStep` from local storage
2. If completed within last 7 days, resume at next step
3. If older than 7 days, ask: "Pick up where you left off?" — Continue or
   Start over

### 3.3 Edit-earlier-answer flow

If a user taps Back and changes an answer that invalidates a later step:

| Edit | Invalidates |
|---|---|
| Primary region | Phase 4.2 (banks list) → re-prompt with new region's list |
| Secondary regions | Phase 6.2 (corridor pre-fills) → re-prompt with new pre-fills |
| Earning type | Phase 5.1 (budget pre-fill) → don't auto-overwrite (user may have customized); offer "Use updated template" affordance |
| Phase 4.3 = No (was Yes) | Phase 4.4 selections → cleared |
| Phase 6.1 (no longer cross-border) | Phase 6.2 → cleared |

Invalidated steps marked `requiresRePrompt` in state. Continue from the
edited step pushes through these gates rather than jumping past them.

### 3.4 Progress bar

Dynamic, recalculates when conditional branches resolve.

- Domestic-only Pakistani (P1 Saadia): 14 steps total → progress = step/14
- Diaspora investor (P2 Faisal): 17 steps total → progress = step/17

Progress bar shown on every screen except Welcome (1.1) and Loading (Phase 7).

### 3.5 Validation

Inline errors only. No modal popups for validation. Error copy is specific
("Code didn't match" not "Invalid input"). Errors clear on next interaction
with the field.

### 3.6 Back navigation

Hardware/system back button always allowed. No "Are you sure you want to
leave?" prompts during onboarding. State is persisted, so cancellation is
recoverable.

### 3.7 "Why we ask" microcopy (D-027)

**Locked D-027 (resolves Q1) — microcopy strategy:**

Always-shown for sensitive questions:
- Phase 4.1 earning type: "We use this to suggest budget categories."
- Phase 4.2 accounts: "We use this to organize your dashboard. We don't
  access your bank yet."
- Phase 5.1 budget total: "This stays private and is only used on your
  dashboard."
- Phase 6.1 family/remittance: "This helps us show the right corridor for you."

**Tap-to-reveal** for low-stakes questions: name (Phase 2.2), goal labels
(Phase 5.2). Tap a "?" icon next to the field for a 1-line explanation.

**Never shown** for: signup method (1.2), permissions (Phase 3 — each
permission is itself an explanation).

### 3.8 Premium-tier disclosure (D-028)

**Locked D-028 (resolves Q2):**

Premium-tier disclosure happens in **exactly one place during onboarding**:
the inline note when a user taps a 3rd goal at Phase 5.2 ("FELO Plus members
can set unlimited goals"). No banner on Phase 8. No bottom-sheet upsell.
The dashboard handoff is for emotional payoff, not for selling.

Premium tier messaging on the post-Phase-8 dashboard is out of scope for
this PRD; that's a separate workstream.

---

## 4. Out-of-scope for this sprint

Per [`discovery.md §1.5`](../00-discovery/discovery.md):

- Bank API integration (account selection ships; transaction-feed wiring is
  post-onboarding)
- Real money movement (FELO is read-only in v1)
- Crypto trading
- Investment advice / robo-advisory
- Multi-language UI (EN-only per D-004)
- Premium tier purchase flow
- Phase 8 rich dashboard (handoff stub only per D-010)
- Auto-roundup engine (yesterday's polish-cycle item)
- Live FX rates in the dashboard remittance tile (static reference rates OK)
- SMS parsing engine (permission grant ships; parser is post-onboarding)

---

## 5. Acceptance criteria

The onboarding journey is **done** when:

1. **All 5 personas** can complete the full journey without hitting a
   dead-end or unrecoverable error
2. **Per-persona Phase 8 dashboard rendering** matches the contract in
   [`personas.md`](../01-personas/personas.md) (5 integration tests)
3. **State persistence** — closing the app mid-flow and reopening lands at
   the last completed step
4. **All FR-IDs** (Stage 4 deliverable) are implemented and tested
5. **All analytics events** fire with their FR-IDs attached
6. **Funnel queries** (Stage 6 deliverable) return sensible numbers when
   run against synthetic test users
7. **`flutter analyze`** = 0 errors, 0 warnings
8. **`flutter test`** = all journey-related tests pass
9. **iOS + Android simulator** runs cleanly
10. **README updated** with run instructions for the v2 flow

If any of (1)-(6) fails, the journey ships with a known regression and
must be fixed before launch.

---

## 6. Resolved open questions → decisions

This PRD closes Q1-Q18 from Stages 1 + 2 by locking 18 architectural
decisions (D-011 through D-028). The Decision Log gets each entry with
full rationale.

Summary table:

| Q | Resolved as | Decision |
|---|---|---|
| Q1 | Microcopy: always-shown for sensitive Qs, tap-to-reveal for low-stakes | D-027 |
| Q2 | Premium-tier disclosure: Phase 5.2 only; no banner | D-028 |
| Q3 | Region detection failure: picker with hint, no block | D-012 (combined with vendor pick) |
| Q4 | Goal target date: min 30 days, no max, custom MM/YYYY for >1y | D-022 |
| Q5 | Investment platform: never auto-prompt; dashboard CTA per type | D-018 |
| Q6 | Phase 7 timeout: per-message 6s, retry on core failure (3 attempts) | D-026 |
| Q7 | "I'll add later" link sets `accounts_deferred = true` | D-017 |
| Q8 | Legacy baseline via flag-gated A/B post-Stage-7 | (Stage 5 sprint detail) |
| Q9 | Phase 6.1 wording: validated by 2-3 native speakers per market | (Stage 5 task — not architectural) |
| Q10 | IP detection: MaxMind self-hosted (prod) + ipinfo (dev) | D-012 |
| Q11 | SMS vendors: pluggable architecture, providers self-register on procurement | (already D-007) |
| Q12 | Multi-currency goal target | D-021 |
| Q13 | Phase 6.1 → 6.2 trigger truth table | D-023 |
| Q14 | SMS permission copy includes "to this device" | D-014 |
| Q15 | Secondary-region banks: hidden by default, toggle to show | D-016 |
| Q16 | Multi-earning-type widget precedence | D-015 |
| Q17 | "Family contribution" semantic: bidirectional based on earning type | D-020 |
| Q18 | Earning-type widget for Student | D-015 (table includes Student) |

Plus three new decisions on related items:
- **D-011** OTP TTL + max attempts
- **D-013** Secondary regions max = 3
- **D-019** Budget pre-fill template matrix
- **D-024** Corridor pre-fill rules
- **D-025** Phase 7 status message templates

(So we end up with **18 new decisions D-011 through D-028**, covering 18
open questions and 5 implementation specifics surfaced by the PRD itself.)

All decisions go into [`../decision-log.md`](../decision-log.md) with full
rationale.

---

## 7. Sign-off checklist for Review Gate 3

- [ ] All 8 phases match the canonical narrative
- [ ] All 5 personas can be walked through this PRD without dead-ends
- [ ] All 18 open questions (Q1-Q18) are closed
- [ ] All 18 new decisions (D-011-D-028) are accepted
- [ ] Out-of-scope list is complete
- [ ] Acceptance criteria are testable

When all checked, reply **"approved, continue"** and Stage 4 (FRD + System
Design) starts.
