# Felo Onboarding v2 — Functional Requirements Document

> **Companion to:** [PRD](../02-prd/prd-onboarding.md) · [Personas](../01-personas/personas.md) · [Discovery](../00-discovery/discovery.md) · [Canonical Narrative](../00-discovery/user-journey-as-told.md)
>
> **Date:** 2026-04-26 · **Status:** Awaiting Review Gate 4 approval.
>
> Decomposes the PRD into ~80 testable functional requirements. Each FR has
> the schema below. Every FR forward-references its analytics events
> (Stage 6) — D-001's traceability rule is absolute.

## FR schema

```
ID:           FR-{phase}.{step}.{n}
Title:        <imperative>
Trigger:      <user action or system event>
Pre:          <required state>
Behavior:     <ordered steps>
Post:         <resulting state>
Errors:       <validation + system errors>
Acceptance:   <Gherkin or list>
PRD:          §<section>
Decisions:    <D-NNN tags>
Events:       <fired analytics events>
```

---

## E1 — Identity (Phase 1)

### FR-1.1.1 — Render welcome screen

- **Trigger:** App cold-start with no auth session
- **Pre:** none
- **Behavior:** Render hero+subtitle+CTA from `journey_strings` keys `welcome.hero` / `welcome.subtitle` / `welcome.cta` / `welcome.signin_link`
- **Post:** User on welcome route
- **Errors:** none
- **Acceptance:** Hero copy = "Your money, simply seen." (DB-driven; D-029); CTA tap navigates to FR-1.2.1
- **PRD:** §2.1.1
- **Decisions:** D-029
- **Events:** `welcome_viewed`

### FR-1.2.1 — Render sign-up method picker

- **Trigger:** Welcome CTA tap
- **Pre:** Welcome viewed
- **Behavior:** Render 5 method buttons in DB-defined order; each row from `signup_methods` with `is_visible_on_platform` flag
- **Post:** User on method-picker route
- **Errors:** none
- **Acceptance:** Apple button hidden on Android; all 5 visible on iOS; ordering matches DB
- **PRD:** §2.1.2
- **Decisions:** D-029
- **Events:** `signup_method_picker_viewed`

### FR-1.2.2 — Handle OAuth (Google)

- **Trigger:** Tap "Continue with Google"
- **Pre:** Method picker viewed
- **Behavior:** Invoke Supabase Auth Google OAuth; on success → create/link auth user; jump to FR-2.1.1 (skip OTP)
- **Post:** Authenticated session; `users.id` exists
- **Errors:** OAuth cancel → return to picker; provider failure → inline error "Couldn't sign in — try again"
- **Acceptance:** Google sign-in success → Phase 2 in 1 tap (H11)
- **PRD:** §2.1.2
- **Events:** `signup_method_selected{method:'google'}`, `signup_completed{method:'google'}`

### FR-1.2.3 — Handle OAuth (Apple)

- Same as FR-1.2.2 but Apple. iOS-only. Pre-check platform.
- **Events:** `signup_method_selected{method:'apple'}`, `signup_completed{method:'apple'}`

### FR-1.2.4 — Handle OAuth (Facebook)

- Same as FR-1.2.2 but Facebook.
- **Events:** `signup_method_selected{method:'facebook'}`, `signup_completed{method:'facebook'}`

### FR-1.2.5 — Handle Email signup

- **Trigger:** Tap "Continue with Email"
- **Pre:** Method picker viewed
- **Behavior:** Show email input → on submit, Supabase Auth sends OTP → navigate to FR-1.3.1
- **Post:** OTP challenge created; awaiting verification
- **Errors:** Invalid email format → inline error
- **Acceptance:** Valid email → OTP screen within 2s
- **PRD:** §2.1.2
- **Events:** `signup_method_selected{method:'email'}`, `email_otp_requested`

### FR-1.2.6 — Handle Mobile signup

- **Trigger:** Tap "Continue with Mobile"
- **Pre:** Method picker viewed; IP-detected country known (FR-2.1.1 may or may not have run yet — check `journey_state.ip_country`)
- **Behavior:** Show E.164 phone input with country prefix from IP-detected country (or PK as default fallback); on submit, NestJS `POST /v1/sms/otp/send` with `{phoneE164, locale, ipDetectedCountry}` → navigate to FR-1.3.1
- **Post:** `phone_otp_challenges` row created; SMS routed via D-006 routing key
- **Errors:** Invalid E.164 → inline; SMS provider failure → fall back per D-007 chain; country has no provider → Twilio fallback or fail loudly
- **Acceptance:** SMS arrives within 30s; provider name logged in challenge record
- **PRD:** §2.1.2, §2.1.3
- **Decisions:** D-005, D-006, D-007, D-014
- **Events:** `signup_method_selected{method:'mobile'}`, `sms_otp_sent{provider, country}`

### FR-1.3.1 — Render OTP input

- **Trigger:** Email/Mobile method completed (FR-1.2.5/6)
- **Pre:** OTP challenge issued
- **Behavior:** 6-digit numeric input, auto-advance per digit, auto-submit when all 6 filled; resend disabled until 30s; resend counter shown after first resend
- **Post:** OTP submission attempt sent to backend
- **Errors:** Wrong code → "Code didn't match" inline; expired → "Code expired — Resend" inline; max attempts → "Too many attempts — try a different signup method" inline + redirect to FR-1.2.1
- **Acceptance:** TTL 5min, 3 attempts/challenge, 3 resends max per D-011
- **PRD:** §2.1.3
- **Decisions:** D-011
- **Events:** `otp_screen_viewed`, `otp_submitted`, `otp_verified`, `otp_failed{reason}`, `otp_resend_tapped`

### FR-1.3.2 — Verify OTP server-side

- **Trigger:** OTP submitted
- **Pre:** Challenge row exists; not expired; attempts < 3
- **Behavior:** Compare submitted code to `phone_otp_challenges.code_hash` (PBKDF2); on success: mark challenge `used_at`, issue `signupToken`, return success; on fail: increment `attempts`
- **Post:** auth.users row created (or linked); session token issued
- **Errors:** see FR-1.3.1; max-fail → destroy challenge
- **Acceptance:** Successful verify within 2s
- **PRD:** §2.1.3
- **Decisions:** D-011

---

## E2 — Region & Profile Context (Phase 2)

### FR-2.1.0 — Resolve region from IP (background)

- **Trigger:** App cold-start (parallel with FR-1.1.1)
- **Pre:** Network available
- **Behavior:** NestJS `POST /v1/onboarding/region/resolve` reads request IP → MaxMind GeoLite2 (prod) or ipinfo (dev) → returns `{country, currency, dial_code, confidence}`
- **Post:** `journey_state.ip_country` set (or null on failure)
- **Errors:** Resolver timeout (3s) → return null; rate-limited → return null
- **Acceptance:** Resolves within 1s p95; H1 valid (≥95% accurate vs reverse-IP)
- **PRD:** §2.2.1
- **Decisions:** D-006, D-012
- **Events:** `ip_region_resolved{country, confidence}`, `ip_region_resolve_failed`

### FR-2.1.1 — Render region confirmation

- **Trigger:** OTP/OAuth completed
- **Pre:** Auth session active
- **Behavior:** If `ip_country` known → show "You're in {country}?" card with primary CTA "Yes, that's me"; else fall back to picker per D-012; show "+ Add another region" affordance
- **Post:** User views region screen
- **Errors:** none
- **Acceptance:** Pre-filled country = IP-detected; user can override via picker
- **PRD:** §2.2.1
- **Decisions:** D-012
- **Events:** `phase2_step1_viewed{ip_country, prefilled}`

### FR-2.1.2 — Confirm primary region

- **Trigger:** Tap "Yes, that's me" or pick from picker
- **Pre:** FR-2.1.1 viewed
- **Behavior:** Persist `onboarding_state.primary_region` via `PATCH /v1/onboarding/state`; advance to FR-2.1.3 (add secondary) or FR-2.2.1 (name) on Continue
- **Post:** Primary region set in DB
- **Errors:** Network failure → optimistic local persist; retry next Continue
- **Acceptance:** Primary region persists across cold start
- **PRD:** §2.2.1, §3.1
- **Decisions:** D-009, D-029
- **Events:** `phase2_step1_completed{primary_region, prefilled}`

### FR-2.1.3 — Add secondary region (optional)

- **Trigger:** Tap "+ Add another region"
- **Pre:** Primary region set
- **Behavior:** Show bottom-sheet country picker; multi-select up to 3 (D-013); persist on close to `onboarding_state.secondary_regions[]`
- **Post:** Secondary regions stored
- **Errors:** Trying to add 4th → inline note "Maximum 3 regions"
- **Acceptance:** P3 Daniyal adds Pakistan; P2 Faisal adds USA
- **PRD:** §2.2.1
- **Decisions:** D-013
- **Events:** `secondary_region_added{country}`, `secondary_region_removed{country}`

### FR-2.2.1 — Render name input

- **Trigger:** Phase 2.1 Continue
- **Pre:** Primary region set
- **Behavior:** Single text field pre-filled from OAuth-provided name (or empty if Email/Mobile signup)
- **Post:** User on name screen
- **Errors:** none
- **Acceptance:** OAuth name pre-fills; user can edit
- **PRD:** §2.2.2
- **Events:** `phase2_step2_viewed{prefilled}`

### FR-2.2.2 — Persist name

- **Trigger:** Phase 2.2 Continue
- **Pre:** Name field non-empty after trim
- **Behavior:** Validate 1-60 chars; persist via state PATCH; advance to Phase 3
- **Post:** `onboarding_state.name` set
- **Errors:** Empty/whitespace → "Please enter your name"; >60 chars → truncate inline
- **Acceptance:** Saadia → "Saadia K." persists
- **PRD:** §2.2.2
- **Decisions:** D-009
- **Events:** `phase2_step2_completed`

---

## E3 — Permissions Layer (Phase 3)

### FR-3.0.1 — Render permission cards

- **Trigger:** Phase 2 complete
- **Pre:** Auth + name set
- **Behavior:** Render 4 permission cards from `permission_cards` table (filtered by platform; iOS hides SMS card); each card has Allow/Skip buttons
- **Post:** User on permissions screen
- **Errors:** none
- **Acceptance:** Android shows 4 cards; iOS shows 3 (no SMS)
- **PRD:** §2.3
- **Decisions:** D-014, D-029
- **Events:** `phase3_viewed`

### FR-3.1.1 — Request SMS permission

- **Trigger:** Tap Allow on SMS card
- **Pre:** Android only
- **Behavior:** Invoke OS permission flow via `flutter_sms_inbox`; persist outcome to `permissions.sms`
- **Post:** Permission state recorded
- **Errors:** OS denial → record `false`, no error UI
- **Acceptance:** Grant rate target ≥75% (H3)
- **PRD:** §2.3.1
- **Decisions:** D-014
- **Events:** `phase3_sms_grant`, `phase3_sms_skip`

### FR-3.2.1 — Request notification permission

- **Trigger:** Tap Allow on Notifications card
- **Pre:** none
- **Behavior:** Invoke OS notification permission; persist to `permissions.notifications`
- **Post:** Permission state recorded
- **Errors:** OS denial → record `false`
- **Acceptance:** Grant rate target ≥80%
- **PRD:** §2.3.2
- **Events:** `phase3_notif_grant`, `phase3_notif_skip`

### FR-3.3.1 — Request location (optional)

- Same pattern as FR-3.2.1; "Skip" is the friendly default visually
- **Events:** `phase3_location_grant`, `phase3_location_skip`

### FR-3.4.1 — Acknowledge contacts (deferred)

- **Trigger:** Tap Allow or Skip
- **Pre:** none
- **Behavior:** Card body says "coming soon"; tap either button persists state and continues; no actual permission requested
- **Post:** State recorded
- **Errors:** none
- **Acceptance:** No OS permission prompt fires
- **PRD:** §2.3.4
- **Events:** `phase3_contacts_skip` (always)

### FR-3.0.2 — Continue from permissions

- **Trigger:** Tap "Continue" at bottom of Phase 3 screen
- **Pre:** All cards interacted with (or implicitly skipped after a timeout — but v1 requires user action)
- **Behavior:** Persist all 4 permission states via `PATCH /v1/onboarding/permissions`; advance to FR-4.1.1
- **Post:** `permissions` row finalized for user
- **Errors:** none
- **Acceptance:** ≥95% reach Phase 4 from Phase 3 (per discovery §1.4)
- **PRD:** §2.3
- **Events:** `phase3_completed`

---

## E4 — Financial Profile Capture (Phase 4)

### FR-4.1.1 — Render earning type picker

- **Trigger:** Phase 3 complete
- **Pre:** Auth + permissions persisted
- **Behavior:** Render multi-select pill grid from `earning_types_master` (DB-driven per D-029)
- **Post:** User on earning screen
- **Errors:** none
- **Acceptance:** Saadia sees Salaried/…/Other; copy from `journey_strings`
- **PRD:** §2.4.1
- **Decisions:** D-027, D-029
- **Events:** `phase4_step1_viewed`

### FR-4.1.2 — Toggle earning type selection

- **Trigger:** Tap a pill
- **Pre:** Earning screen viewed
- **Behavior:** Toggle selection; if "Other" tapped → expand inline text input (max 60 chars)
- **Post:** Selection state in component
- **Errors:** none
- **Acceptance:** Multi-select works; Faisal can pick Freelancer + Investor
- **PRD:** §2.4.1
- **Events:** `earning_type_toggled{type}`

### FR-4.1.3 — Persist earning type

- **Trigger:** Tap Continue
- **Pre:** ≥1 selection
- **Behavior:** Persist `earning_types[]` + optional `custom_value` via state PATCH
- **Post:** `earning_types` rows inserted
- **Errors:** Continue disabled if 0 selected
- **Acceptance:** Drop-off ≤8% (H4 / D-027)
- **PRD:** §2.4.1
- **Events:** `phase4_step1_completed{types[], custom_value?}`

### FR-4.2.1 — Render accounts picker

- **Trigger:** Phase 4.1 complete
- **Pre:** Primary region known
- **Behavior:** Query `banks WHERE region_iso2 = primary_region UNION wallets WHERE region_iso2 = primary_region` (DB-driven per D-029); render multi-select pill grid; show search field if list >10 items
- **Post:** User on accounts screen
- **Errors:** none
- **Acceptance:** PK user sees PK banks; CA user sees CA banks
- **PRD:** §2.4.2
- **Decisions:** D-016, D-029
- **Events:** `phase4_step2_viewed{region, list_size}`

### FR-4.2.2 — Toggle secondary-region banks

- **Trigger:** Tap toggle "Show banks from my secondary regions"
- **Pre:** User has ≥1 secondary region
- **Behavior:** Re-query banks/wallets for secondary regions; merge into list
- **Post:** Expanded list visible
- **Errors:** none
- **Acceptance:** Bushra (PK + UAE secondary) sees Mashreq after tap
- **PRD:** §2.4.2
- **Decisions:** D-016
- **Events:** `phase4_step2_secondary_toggle`

### FR-4.2.3 — Defer accounts

- **Trigger:** Tap "I'll add accounts later →"
- **Pre:** Accounts screen viewed
- **Behavior:** Set `accounts_deferred = true`; clear any selections; advance
- **Post:** Phase 4.2 marked deferred
- **Errors:** none
- **Acceptance:** Phase 8 shows "Add your first account" CTA per D-017
- **PRD:** §2.4.2
- **Decisions:** D-017
- **Events:** `phase4_step2_deferred`

### FR-4.2.4 — Persist accounts selection

- **Trigger:** Tap Continue
- **Pre:** ≥1 selection or deferred
- **Behavior:** Persist `user_accounts[]` rows
- **Post:** Account selections saved
- **Errors:** none
- **Acceptance:** Drop-off ≤10% (H8); Faisal's 4 selections persist
- **PRD:** §2.4.2
- **Events:** `phase4_step2_completed{count, deferred:bool}`

### FR-4.3.1 — Render investment gate

- **Trigger:** Phase 4.2 complete
- **Behavior:** Render two big cards Yes/No
- **Acceptance:** Tapping No skips FR-4.4 entirely
- **Events:** `phase4_step3_viewed`

### FR-4.3.2 — Persist investment gate answer

- **Trigger:** Tap Yes/No
- **Behavior:** Persist `invests = bool`; if Yes → FR-4.4.1; if No → FR-5.1.1
- **PRD:** §2.4.3
- **Events:** `phase4_step3_completed{invests}`

### FR-4.4.1 — Render investment types picker

- **Trigger:** Phase 4.3 = Yes
- **Behavior:** Multi-select pills from `investment_types_master`
- **Decisions:** D-018 (no broker capture here), D-029
- **Events:** `phase4_step4_viewed`

### FR-4.4.2 — Persist investment types

- **Trigger:** Tap Continue
- **Pre:** ≥1 selection
- **Behavior:** Persist `user_investments[]`
- **PRD:** §2.4.4
- **Events:** `phase4_step4_completed{types[]}`

---

## E5 — Intent: Budget & Goals (Phase 5)

### FR-5.1.1 — Render budget screen

- **Trigger:** Phase 4 complete
- **Pre:** Primary region + earning_types known
- **Behavior:** Query `budget_templates WHERE region_iso2 = primary_region AND earning_type = top_priority(earning_types)` per D-015 precedence; render total + categories with template percentages applied to default income (or last-known income)
- **Post:** User on budget screen with pre-fills
- **Errors:** No template match → use default Salaried template for region
- **Acceptance:** Saadia sees PK Salaried template; Faisal sees PK Freelancer
- **PRD:** §2.5.1
- **Decisions:** D-019, D-029
- **Events:** `phase5_step1_viewed{template_used}`

### FR-5.1.2 — Edit budget total

- **Trigger:** Edit total field
- **Behavior:** Recompute pre-filled categories to maintain percentages (until user manually edits a category, which "locks" it)
- **Acceptance:** Live total matches sum of categories
- **Events:** `budget_total_edited`

### FR-5.1.3 — Edit category amount

- **Trigger:** Edit category field
- **Behavior:** Update component state; show yellow over/blue under inline note if total mismatch
- **Acceptance:** Saadia zeroing Rent removes it from Phase 8
- **Events:** `budget_category_edited{category, semantic}`

### FR-5.1.4 — Bidirectional family-contribution category

- **Trigger:** Render Phase 5.1 categories
- **Pre:** earning_types known
- **Behavior:** If "Student" in earning_types → render "Family allowance received" with `semantic = 'inflow'`; else → "Family support" with `semantic = 'outflow'`
- **Post:** Correct semantic stored when persisted
- **Acceptance:** Sana sees "allowance received"; Saadia sees "Family support"
- **PRD:** §2.5.1
- **Decisions:** D-020
- **Events:** none (rendering FR)

### FR-5.1.5 — Persist budget

- **Trigger:** Tap Continue
- **Pre:** Total > 0
- **Behavior:** Insert `budgets` row + `budget_categories` rows (categories with `amount = 0` still inserted but flagged hidden); advance
- **Post:** Budget persisted
- **Errors:** Total = 0 → "Please set a budget"
- **Acceptance:** Categories with amount=0 are hidden on Phase 8
- **PRD:** §2.5.1
- **Decisions:** D-019, D-020
- **Events:** `phase5_step1_completed{total, categories_count, semantic_inflow_count, semantic_outflow_count}`

### FR-5.2.1 — Render goals card grid

- **Trigger:** Phase 5.1 complete
- **Behavior:** Render goal cards from `goal_templates` (DB-driven); each card has icon, label, helper text
- **Post:** User on goals screen
- **PRD:** §2.5.2
- **Decisions:** D-008, D-029
- **Events:** `phase5_step2_viewed`

### FR-5.2.2 — Toggle goal selection (FIFO at 3rd tap)

- **Trigger:** Tap a goal card
- **Behavior:**
  - 0 selected → tap selects (1)
  - 1 selected → tap selects (2); Continue button enables
  - 2 selected, tap a 3rd → deselect first selected (FIFO); show inline note "FELO Plus members can set unlimited goals"
- **Post:** Exactly 0/1/2 selected at any time
- **Errors:** none
- **Acceptance:** Continue disabled at 0 or 1; enabled at exactly 2; tapping a 3rd is non-destructive (FIFO replaces)
- **PRD:** §2.5.2
- **Decisions:** D-008, D-028
- **Events:** `goal_selected{slug}`, `goal_deselected{slug}`, `goal_third_tap_seen` (fires when FIFO note shows — premium upsell exposure metric)

### FR-5.2.3 — Render per-goal detail

- **Trigger:** Phase 5.2 grid Continue
- **Pre:** Exactly 2 goals selected
- **Behavior:** Two-step flow (one screen per goal), each with target amount + currency picker + target date picker; auto-calc shows monthly contribution
- **Post:** Goal targets captured in component state
- **Errors:** see FR-5.2.4
- **PRD:** §2.5.2 (5.2b)
- **Decisions:** D-021, D-022
- **Events:** `phase5_step2_detail_viewed{slot, slug}`

### FR-5.2.4 — Validate goal target

- **Trigger:** Tap Continue on per-goal detail
- **Pre:** Amount + date entered
- **Behavior:** Validate target_amount_minor > 0; date ≥ today + 30 days; date ≤ no max; currency in {primary, secondaries, USD, EUR}
- **Post:** Validated or error shown inline
- **Errors:**
  - Amount = 0 → "Set a target amount"
  - Date < today + 30 days → "Pick a date at least a month from today"
  - Date in past → blocked at picker level
- **Acceptance:** Min 30 days enforced
- **PRD:** §2.5.2
- **Decisions:** D-022

### FR-5.2.5 — Soft over-ambitious-goal warning

- **Trigger:** Both goals' details captured
- **Pre:** Auto-calc has produced required monthly contribution sum
- **Behavior:** If sum > available budget surplus (total budget - sum of categories) → show amber inline banner "You'd need {required}/month — your budget allows {available}. Adjust?" with link back to Phase 5.1
- **Post:** Banner shown; non-blocking
- **Errors:** none
- **Acceptance:** Banner shown; Continue still works
- **PRD:** §2.5.2
- **Events:** `goal_warning_shown{required, available}`, `goal_warning_dismissed_via_continue`, `goal_warning_jumped_to_budget`

### FR-5.2.6 — Persist goals

- **Trigger:** Tap Continue past warning (or no warning)
- **Pre:** Both goals validated
- **Behavior:** Insert 2 `goals` rows with `slot ∈ {1,2}` (D-008 invariant); advance
- **Post:** Goals persisted
- **Errors:** Backend rejects if !== 2 (D-008 server-side check)
- **Acceptance:** P1-P5 all hit Phase 6 trigger logic with goals captured
- **PRD:** §2.5.2
- **Decisions:** D-008, D-021, D-022
- **Events:** `phase5_step2_completed{slots:[{slug, currency, target_minor, target_date, monthly_contrib_minor}]}`

---

## E6 — Remittance Corridor (Phase 6, conditional)

### FR-6.1.1 — Render family/remittance multi-select

- **Trigger:** Phase 5 complete
- **Behavior:** Render 5 options from `family_remittance_options`; option 5 ("None of the above") is mutually exclusive (selecting deselects 1-4)
- **PRD:** §2.6.1
- **Decisions:** D-029
- **Events:** `phase6_step1_viewed`

### FR-6.1.2 — Toggle option

- **Trigger:** Tap an option
- **Behavior:** Toggle; if "None" → clear 1-4; if any of 1-4 → clear "None"
- **Events:** `family_remittance_option_toggled{slug}`

### FR-6.1.3 — Persist 6.1 + decide on 6.2

- **Trigger:** Tap Continue
- **Pre:** ≥1 selection
- **Behavior:** Persist `remittance_preferences.options[]`; evaluate D-023 truth table:
  - "Send regularly" anywhere → 6.2 fires
  - "Receive abroad" only → 6.2 fires
  - "Support" only + cross-border secondary regions → 6.2 fires (defensive)
  - "Support" only + no secondary → skip 6.2
  - "Manage household" only → skip 6.2
  - "None of the above" → skip 6.2
- **Post:** Either FR-6.2.1 viewed or FR-7.1.1 viewed
- **Errors:** none
- **Acceptance:** P1 Saadia ("Support" only, PK only) → skips 6.2; P2 Faisal ("Receive" + "Support", PK+US) → 6.2 fires
- **PRD:** §2.6.1
- **Decisions:** D-023
- **Events:** `phase6_step1_completed{options[], step2_will_fire:bool}`

### FR-6.2.1 — Render corridor pickers

- **Trigger:** D-023 truth table → 6.2 fires
- **Pre:** Phase 6.1 persisted
- **Behavior:** Render two pill groups (Send to / Receive from); pre-fill per D-024:
  - Diaspora primary (CA/UK/US/UAE/SA) → "Send to" defaults with secondary regions
  - South Asian primary (PK/IN/BD/NP/LK) → "Receive from" defaults with secondary regions
- **Post:** User on corridor screen with pre-fills
- **Acceptance:** Daniyal (CA, secondary PK) sees "Send to: Pakistan" pre-filled
- **PRD:** §2.6.2
- **Decisions:** D-024, D-029
- **Events:** `phase6_step2_viewed{prefilled_send_to[], prefilled_receive_from[]}`

### FR-6.2.2 — Edit corridor selections

- **Trigger:** Tap pill
- **Behavior:** Toggle multi-select
- **Events:** `corridor_country_toggled{direction, country}`

### FR-6.2.3 — Persist corridors

- **Trigger:** Tap Continue
- **Behavior:** Persist `remittance_preferences.sends_to[]` + `receives_from[]`; advance to FR-7.1.1
- **PRD:** §2.6.2
- **Events:** `phase6_step2_completed{sends_to[], receives_from[]}`

---

## E7 — Personalization Engine (Phase 7)

### FR-7.0.1 — Initiate personalization

- **Trigger:** Phase 6 complete (or skipped)
- **Pre:** All prior phase state persisted
- **Behavior:** POST `/v1/onboarding/complete` with full state snapshot; backend kicks off parallel work (FR-7.0.2 through FR-7.0.6); UI navigates to FR-7.1.1
- **Post:** Onboarding session marked `is_completing`
- **PRD:** §2.7.2
- **Events:** `phase7_started`

### FR-7.0.2 — Build user_profile object

- **Trigger:** Internal call from FR-7.0.1
- **Behavior:** Consolidate `onboarding_state` into `profiles` row (extend existing); insert `permissions`, `earning_types`, `user_accounts`, `user_investments`, `remittance_preferences` rows
- **Errors:** DB write failure → retryable per D-026
- **PRD:** §2.7.2

### FR-7.0.3 — Compute dashboard widget config

- **Trigger:** After 7.0.2 succeeds
- **Behavior:** Build Phase 8 widget grid based on user state per D-010 contract; cache in `dashboard_configs` table
- **PRD:** §2.7.2

### FR-7.0.4 — Pre-fetch FX rates (conditional)

- **Trigger:** After 7.0.2 if `secondary_regions[]` non-empty or remittance corridors set
- **Behavior:** Call internal FX service or static reference rates; cache 24h
- **Errors:** Timeout 6s → degrade per D-026
- **PRD:** §2.7.2

### FR-7.0.5 — Pre-fetch market data (conditional)

- **Trigger:** After 7.0.2 if `user_investments[]` non-empty
- **Behavior:** Pull rough index data (KSE100 for PK, NIFTY for IN, S&P500 for diaspora); cache
- **Errors:** Same as FR-7.0.4
- **PRD:** §2.7.2

### FR-7.0.6 — Insert initial budget categories + goals

- **Trigger:** After 7.0.2
- **Behavior:** Persist `budgets`, `budget_categories`, `goals` rows (already done in earlier FRs but consolidated here for atomicity)
- **PRD:** §2.7.2

### FR-7.0.7 — Initialize push token (conditional)

- **Trigger:** After 7.0.2 if `permissions.notifications = true`
- **Behavior:** Register device token with `/v1/devices`; idempotent (existing module)
- **Errors:** Silent failure (non-blocking)
- **PRD:** §2.7.2

### FR-7.0.8 — Mark onboarding complete

- **Trigger:** After all parallel work succeeds (or per-step timeout)
- **Behavior:** Set `onboarding_sessions.completed_at = NOW()`; set `profiles.onboarding_completed_at`
- **PRD:** §2.7.2

### FR-7.1.1 — Render loading screen

- **Trigger:** FR-7.0.1
- **Behavior:** Full-screen with cycling status messages; messages from `phase7_status_templates` filtered by user state per D-025; each holds 400-700ms then resolves to ✓
- **Post:** User views all applicable messages
- **Acceptance:** All status strings reference user's actual inputs (no generics)
- **PRD:** §2.7.1
- **Decisions:** D-025, D-029
- **Events:** `phase7_message_shown{template_key}`, `phase7_message_completed{template_key, duration_ms}`

### FR-7.1.2 — Handle Phase 7 timeout/error

- **Trigger:** Per-message timeout (6s) or core build failure
- **Behavior:** Per D-026 — message timeout = skip + degrade; core failure = retryable error screen with state preserved (3 attempts then support escape hatch)
- **PRD:** §2.7.1
- **Decisions:** D-026
- **Events:** `phase7_timeout{template_key}`, `phase7_core_error{attempt}`, `phase7_support_escape`

### FR-7.1.3 — Continue to Phase 8

- **Trigger:** All status messages completed (or timed out gracefully)
- **Behavior:** Navigate to dashboard handoff stub
- **Post:** Phase 7 done; user on Phase 8
- **Acceptance:** Total Phase 7 ≤5s; backgrounding ≤5% (H7)
- **Events:** `phase7_completed{duration_ms, degraded:bool}`

---

## E8 — Dashboard Handoff (Phase 8)

### FR-8.1.1 — Render greeting card

- **Trigger:** Phase 7 complete
- **Behavior:** Locale-aware salutation ("Salaam" for PK/IN/BD/UAE/SA primary; "Hello" for CA/UK/US) + first name
- **PRD:** §2.8.1
- **Events:** `phase8_dashboard_viewed`

### FR-8.1.2 — Render currency badge

- **Trigger:** Always
- **Behavior:** Primary currency; toggle switch if `secondary_regions.length > 0`
- **PRD:** §2.8.1

### FR-8.1.3 — Render account tiles

- **Trigger:** `user_accounts.length > 0`
- **Behavior:** One tile per selected account from Phase 4.2; each tile shows provider name + "Connect" CTA
- **PRD:** §2.8.1

### FR-8.1.4 — Render account-deferred CTA

- **Trigger:** `accounts_deferred = true`
- **Behavior:** Big "Add your first account" CTA in place of tiles
- **PRD:** §2.8.1
- **Decisions:** D-017

### FR-8.1.5 — Render budget ring + category cards

- **Trigger:** Always
- **Behavior:** Ring from Phase 5.1 total; top 4 category mini-cards (only with `amount > 0`)
- **PRD:** §2.8.1

### FR-8.1.6 — Render goal hero cards

- **Trigger:** Always (D-008 enforces 2)
- **Behavior:** Two cards with progress ring at 0%; show target amount + date + monthly contrib needed; goal currency in native + primary equivalent
- **PRD:** §2.8.1
- **Decisions:** D-008, D-021

### FR-8.1.7 — Render investment section

- **Trigger:** `user_investments.length > 0`
- **Behavior:** Section header + one card per investment type with "Add your broker" CTA
- **PRD:** §2.8.1
- **Decisions:** D-018

### FR-8.1.8 — Render remittance tile

- **Trigger:** `remittance_preferences.sends_to.length > 0 OR receives_from.length > 0`
- **Behavior:** Tile with corridor visualization (e.g., 🇨🇦 → 🇵🇰); show static reference FX rate (live rates out of scope per discovery §1.5)
- **PRD:** §2.8.1

### FR-8.1.9 — Render earning-type widget

- **Trigger:** Always
- **Behavior:** Per D-015 precedence; copy depends on top earning_type:
  - Salaried → "Days until next salary"
  - Business owner → "Cash flow this month"
  - Freelancer → "This week's invoices"
  - Investor → "Portfolio movement today"
  - Student → "Days until next allowance"
  - Homemaker/Other → "Days remaining in budget cycle"
- **PRD:** §2.8.1
- **Decisions:** D-015

### FR-8.2.1 — One-time first-tap tooltip

- **Trigger:** First Phase 8 view per device
- **Behavior:** Show small tooltip near first account tile (or "Add account" CTA): "Connect your first account to start tracking"; dismiss on tap or X
- **Post:** Tooltip never re-shown
- **PRD:** §2.8.2
- **Events:** `tooltip_first_account_shown`, `tooltip_first_account_dismissed`

---

## E9 — Cross-cutting: Journey Config (D-029)

### FR-9.0.1 — Fetch journey config at app launch

- **Trigger:** App cold-start
- **Behavior:** GET `/v1/onboarding/journey-config` with optional `?region={iso2}&earning_types={csv}` (latter known mid-flow); response contains all DB-driven content (banks, wallets, templates, strings); cache locally with `version_hash`
- **Post:** Config available for all subsequent screen renders
- **Errors:** Network failure → use bundled fallback config
- **Decisions:** D-029
- **Events:** `journey_config_fetched{version_hash, source: 'network'|'cache'|'fallback'}`

### FR-9.0.2 — Refresh config on foreground (TTL 24h)

- **Trigger:** App foreground after >24h
- **Behavior:** Re-fetch; if `version_hash` changed → invalidate cache and merge fresh content
- **Decisions:** D-029
- **Events:** `journey_config_refreshed{old_version, new_version}`

### FR-9.0.3 — Admin updates content via DB write

- **Trigger:** SQL update on any reference table (`banks`, `wallets`, `journey_strings`, etc.)
- **Behavior:** Trigger function bumps `journey_config_versions.current_version`
- **Post:** Next FR-9.0.2 fetch picks up new content
- **Decisions:** D-029

---

## E10 — Cross-cutting: Multi-sink Analytics (D-030)

### FR-10.0.1 — Wrap every screen in `OnboardingAnalyticsMixin`

- **Trigger:** Compile-time mixin enforcement on every Phase 1-8 screen widget
- **Behavior:** Mixin auto-fires `{phase}_{step}_viewed` on `initState`, `_completed` on Continue, `_back` on back, `_skipped` on skip, `_validation_error` on validation failure; FR-ID baked in via route metadata
- **Post:** Developer cannot ship a screen without instrumentation
- **Decisions:** D-001, D-030
- **Events:** All — this FR is the emission engine

### FR-10.0.2 — Multi-sink dispatch in NestJS

- **Trigger:** `POST /v1/analytics/event` (called by Flutter `analytics.fire()`)
- **Behavior:**
  1. Validate canonical payload (Zod or class-validator)
  2. Insert into Postgres `events` table (sink 1)
  3. Async dispatch to Meta CAPI (sink 2) with hashed user PII
  4. Return `dataLayer` payload to client (sink 3 — client pushes to GTM)
  5. Async dispatch to additional sinks (TikTok/Snap when added)
- **Post:** Event recorded in N sinks
- **Errors:** Sink failures don't block each other; logged to error sink
- **Decisions:** D-030
- **Events:** `analytics_dispatch_failed{sink, reason}` (meta-event)

### FR-10.0.3 — Postgres events sink

- **Behavior:** Insert into `events` table with redacted IP (country only); RLS allows insert from auth.uid(), select admin-only
- **Decisions:** D-030

### FR-10.0.4 — Meta Conversions API sink

- **Behavior:** Map canonical payload to Meta CAPI shape; hash email/phone with SHA-256; include `event_id` for dedup with client-side pixel; POST to Meta Graph API
- **Errors:** 4xx → log + drop; 5xx → retry with backoff (3 attempts)
- **Decisions:** D-030

### FR-10.0.5 — GTM dataLayer sink

- **Behavior:** Server returns canonical payload + GTM-formatted variables (camelCase); Flutter on success calls `dataLayer.push(payload)` via JS bridge (web) or native bridge (mobile WebView shell)
- **Decisions:** D-030

### FR-10.0.6 — Funnel session lifecycle

- **Trigger:** First `welcome_viewed` for unauthenticated user
- **Behavior:** Create `funnel_sessions` row; update `last_step_reached` on every event; set `abandoned_at` if no event for 30 min; set `completed_at` on `phase8_dashboard_viewed`
- **Post:** Funnel queryable end-to-end
- **Decisions:** D-030

---

## E11 — Cross-cutting: State Persistence (D-009)

### FR-11.0.1 — Local persist on Continue

- **Trigger:** Any Continue tap
- **Behavior:** Synchronously write delta to `flutter_secure_storage` keyed by `onboarding_state.user_id` (or anonymous `device_id` pre-Phase-1)
- **Post:** Local state authoritative
- **Decisions:** D-009
- **Events:** `state_persist_local_success`

### FR-11.0.2 — Remote sync on Continue

- **Trigger:** Right after FR-11.0.1
- **Behavior:** Fire-and-forget `PATCH /v1/onboarding/state` with delta; retry on next Continue if previous sync failed (state ledger held locally)
- **Post:** Remote state matches local within 1 sync cycle
- **Decisions:** D-009
- **Events:** `state_persist_remote_success`, `state_persist_remote_failed`

### FR-11.0.3 — Resume from last completed step

- **Trigger:** App cold-start with auth session active
- **Behavior:** Read `onboarding_state.lastCompletedStep`; if set within last 7 days → navigate to next step; if older → show "Pick up where you left off?" prompt
- **Post:** User resumes mid-flow
- **Decisions:** D-009
- **Events:** `onboarding_resumed{from_step, days_since_last}`

### FR-11.0.4 — Edit-earlier-answer cascade

- **Trigger:** User navigates back and changes an answer that invalidates a later step
- **Behavior:** Mark invalidated steps as `requiresRePrompt` in state; Continue from changed step pushes through invalidated gates rather than skipping back to where they were
- **Post:** Stale data overwritten with fresh
- **Decisions:** D-009
- **Events:** `state_invalidation_cascade{trigger_step, invalidated_steps[]}`

---

## E12 — Cross-cutting: SMS Verification (D-005..D-007, D-014)

### FR-12.0.1 — Provider registry initialization

- **Trigger:** NestJS module bootstrap
- **Behavior:** Read env vars (`SMS_TWILIO_ACCOUNT_SID`, `SMS_<VENDOR>_API_KEY`, etc.); for each present credential, register the corresponding `SmsProvider` adapter against the countries it serves; `ConsoleLogger` registered if `SMS_DEV_LOGGER=true`
- **Post:** `SmsProviderRegistry.byCountry` populated
- **Decisions:** D-005, D-007

### FR-12.0.2 — Resolve provider for OTP send

- **Trigger:** `POST /v1/sms/otp/send`
- **Pre:** payload has `phoneE164`, `locale`, optional `ipDetectedCountry`
- **Behavior:**
  1. If `ipDetectedCountry` present → registry lookup
  2. Else parse country from E.164 prefix → registry lookup
  3. Else → universal fallback (Twilio if registered, else `ConsoleLogger`)
- **Post:** Concrete `SmsProvider` instance returned
- **Errors:** No provider available + prod env → 500 with alert; dev → log + use ConsoleLogger
- **Decisions:** D-006

### FR-12.0.3 — Send OTP via resolved provider

- **Trigger:** Provider resolved (FR-12.0.2)
- **Behavior:** Generate 6-digit code; PBKDF2-hash; insert `phone_otp_challenges` row with TTL 5min; call `provider.send({phone, code, locale, senderId})`; return challenge_id + masked phone + provider name
- **Post:** SMS dispatched
- **Decisions:** D-005, D-006, D-014
- **Events:** `sms_otp_sent{provider, country, masked_phone}`

### FR-12.0.4 — Verify OTP

- **Trigger:** `POST /v1/sms/otp/verify` with `{challengeId, code}`
- **Behavior:** Look up challenge; check not-expired + attempts < 3; PBKDF2-verify hash match; on success: mark `used_at`, issue Supabase Auth signupToken; on fail: increment attempts; on max-fail: destroy challenge
- **Decisions:** D-011

---

## Summary

**Total FRs: 78** across 12 epics:
- E1 Identity: 9 FRs
- E2 Region/Profile: 7 FRs
- E3 Permissions: 6 FRs
- E4 Financial Profile: 11 FRs
- E5 Intent (Budget+Goals): 12 FRs
- E6 Remittance: 6 FRs
- E7 Personalization: 11 FRs
- E8 Dashboard Handoff: 9 FRs
- E9 Journey Config: 3 FRs
- E10 Multi-sink Analytics: 6 FRs
- E11 State Persistence: 4 FRs
- E12 SMS Verification: 4 FRs

Every FR carries forward-references to PRD section + decision log entries + analytics events. Stage 5 will story-point each. Stage 6 will materialize the analytics event taxonomy. Stage 7 will implement against this contract.
