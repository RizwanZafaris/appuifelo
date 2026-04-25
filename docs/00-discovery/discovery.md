# Stage 1 — Discovery

> **Companion to:** [`user-journey-as-told.md`](./user-journey-as-told.md) (canonical narrative).
> **Date:** 2026-04-26
> **Status:** Awaiting Review Gate 1 approval.
>
> The canonical narrative says **what** the user experiences. This document covers the
> **why behind the why** — market reality, testable hypotheses, success metrics, what
> we're not building, and what's still unresolved. Anything here that contradicts the
> narrative is a bug — the narrative wins.

---

## 1.1 Problem statement

### What FELO is solving

A South Asian household manages money through a fragmented stack:

- **Multiple bank apps** — most users hold accounts at 2-4 institutions; each app
  shows only its own balance and transactions
- **Multiple wallet apps** — JazzCash, Easypaisa, NayaPay, SadaPay in Pakistan;
  Paytm, PhonePe, Google Pay, Amazon Pay in India; e&money, Careem Pay in UAE
- **SMS-based mental ledger** — banks send transaction SMS; users keep an informal
  running tally in their head, paper, or a notes app
- **Informal remittance** — diaspora users send via Wise / Remitly / Western Union
  to family who often manually deposit into another bank or wallet
- **Investments scattered** — broker app for stocks, exchange app for crypto, gold
  in a deposit box, real-estate paperwork in a folder
- **Budgeting absent** — most users don't budget; those who try use spreadsheets
  that go stale within weeks

The cost of the status quo is invisible because it's distributed: 30 minutes a
month spent reconciling, untracked subscription leakage, missed family-support
deadlines, no clear sense of net worth, surprise overdrafts.

### Who feels the pain most acutely

Per [`user-journey-as-told.md`](./user-journey-as-told.md), four user shapes:

| Shape | Pain peak |
|---|---|
| Salaried mid-career professional | "Where did my money go this month?" — knows income, doesn't know spend |
| Freelancer with irregular income | "Am I solvent?" — multiple wallets, foreign clients, no consolidated view |
| Diaspora remitter | "How much did I actually send home this year?" — corridor + FX volatility |
| Student / first-time earner | "Am I doing this right?" — no model for what good budgeting looks like |

Stage 2 (Personas) details these as P1-P5 with full journey walkthroughs.

### Why this hasn't been solved already

Three factors have kept Western personal-finance apps from working in South Asia:

1. **No bank API access** — Plaid / Yodlee don't operate at scale across PK / IN /
   BD / NP / LK. SBP and RBI have limited Open Banking pilots; production-ready
   aggregation infrastructure is 2-3 years away.
2. **Cash + wallet-heavy economies** — Mint-style apps assume credit-card-centric
   spending. South Asian users transact via wallets, IBFT, raast (PK), UPI (IN),
   IBAN transfers, and cash. The data sources are different.
3. **Cross-border-by-default** — most apps treat international as an edge case.
   For diaspora users, cross-border IS the use case. Apps that bury remittance
   3 menus deep miss the point.

### FELO's unique unlock

**SMS parsing.** Every bank in PK / IN / BD / NP / LK sends transaction SMS by
regulatory mandate. With OS-level SMS read permission, FELO can auto-categorize
transactions across every bank and wallet without a single API integration.

This is FELO's wedge. The canonical narrative hangs Phase 3 (Permissions) on this:
"You'll never type a number again." If users grant SMS permission, FELO outclasses
every Western competitor on the central job (transaction tracking) on day one.

---

## 1.2 Market context

### Primary markets — the South Asian core

| Country | Population | Smartphone penetration | Banking penetration | Wallet penetration |
|---|---|---|---|---|
| Pakistan | 240M | ~57% | ~21% (account ownership) | ~30% (Easypaisa + JazzCash combined) |
| India | 1.4B | ~74% | ~78% (PMJDY-driven) | ~85% (UPI usage) |
| Bangladesh | 170M | ~60% | ~53% | ~45% (bKash + Nagad) |
| Nepal | 30M | ~70% | ~67% | ~25% (eSewa + Khalti) |
| Sri Lanka | 22M | ~73% | ~89% | ~15% (LankaPay + bank-led) |

**Pakistan is FELO's launch market** — founder's home market, lower wallet
saturation than India (so FELO's value prop is sharper), and the largest
diaspora corridor flowing into Canada/UK/USA where the founder lives.

### Cross-border corridors (Phase 6 of the journey)

Eight diaspora corridors matter for v1:

| Corridor | Annual remittance volume (approx, USD) | Why FELO matters |
|---|---|---|
| Saudi → PK | $7.5B | Largest single corridor for PK; unbanked recipients |
| UAE → PK | $5.2B | Second largest; high-income blue-collar workers |
| USA → PK | $3.4B | High per-capita; tech-sector diaspora |
| UK → PK | $2.3B | Pakistani-British working class |
| Canada → PK | $1.1B | Smallest by volume but highest tech adoption |
| USA → IN | $20B | Reference corridor; India's largest |
| UAE → BD | $2.1B | BD diaspora |
| Saudi → NP | $0.9B | Nepali laborers in GCC |

Inbound corridors (toward South Asia) dominate. Outbound (someone in PK sending
to someone in UAE) is rare and not a v1 priority.

### Competitive landscape — what they miss

**Mint / YNAB / Monarch** — built for US/Canada, assume credit-card-centric
spending and bank API aggregation. Don't work without manual entry in our
markets. Mint shut down in 2024.

**Bank apps (HBL, Meezan, ENBD, HDFC)** — siloed; show only that bank's data.
Some do basic budgeting (HBL Konnect categories) but no cross-bank view, no
wallet integration, no remittance.

**Remittance apps (Wise, Remitly, Western Union)** — single-purpose; do the
transfer but don't track what happens to the money on either side.

**Wallet apps (JazzCash, Easypaisa, Paytm)** — single-wallet view; some do bill
payments and merchant payments well, but again siloed.

**Personal-finance Twitter/YouTube** — popular in PK/IN; not software.

The **gap** FELO occupies: a single pane of glass that consolidates
everything **without requiring bank API integration** — which the SMS-parsing
unlock makes possible. No competitor in the space combines:

- SMS-driven auto-tracking (no manual entry)
- Multi-account / multi-wallet / multi-currency
- Goals + budgets that drive behavior (not just reports)
- Cross-border remittance corridors as a first-class concept

### Strategic opportunity in onboarding specifically

Onboarding is where the entire market positioning gets compressed into 5-7
minutes. The canonical narrative's "three things must be true" success
criterion — *they feel FELO understands them, the dashboard is configured,
they know what FELO is for* — is also the answer to "why is FELO different
from my bank app." If onboarding succeeds, retention has a chance. If it
fails, no feature later can recover the user.

---

## 1.3 Onboarding hypotheses (12, testable)

Each hypothesis maps to a measurable signal, a target threshold, and forward-references
the analytics events from Stage 6 that will validate it. Hypotheses that fail signal
the journey needs revision, not just copy tweaks.

### H1 — IP-detected region pre-selection beats manual

**Hypothesis:** Users whose primary region is auto-pre-selected from IP complete
Phase 2 at ≥95%, vs ≥75% for users who must manually pick from a list.

**Signal:** `phase2_step1_completed` events grouped by `prefilled_from_ip: bool`.

**Why it matters:** Region drives every later filter. Reducing Phase 2 friction
compounds across Phase 4-6. Per the narrative: "Region is the biggest
personalization lever in the entire app."

**FRD link:** FR-2.1.* (Stage 4)

### H2 — Goal-setting drives retention

**Hypothesis:** Users who complete Phase 5.2 (set 2 goals) have ≥3× higher D30
retention than users who skipped onboarding entirely (re-installs / returns
mid-flow).

**Signal:** Cohort analysis on `phase5_step2_completed` vs D30 active sessions.

**Why it matters:** Goals are the commitment device. Per the narrative:
"Research shows users with 2 goals achieve them at higher rates than users with
5." Validates the 2-goal hard limit (D-008).

**FRD link:** FR-5.2.* (Stage 4) + retention queries (Stage 6.2)

### H3 — Strong SMS framing lifts permission grant rate

**Hypothesis:** Phase 3 SMS permission grant rate ≥75% with the "you'll never
type a number again" copy, vs ≥40% with generic OS-default copy.

**Signal:** `phase3_sms_grant` rate, A/B-tested if/when copy variants ship.

**Why it matters:** SMS is FELO's wedge. If grant rate is below 50%, the value
prop has to fall back to manual entry — which is undifferentiated from
competitors.

**FRD link:** FR-3.1.* + FR-3.2.* (Stage 4)

### H4 — "Why we ask" microcopy under sensitive questions reduces drop-off

**Hypothesis:** Phase 4.1 (earning type) and Phase 5.1 (budget total) drop-off
is ≤8% when "why we ask" microcopy is shown, vs ≤15% without.

**Signal:** `phase4_step1_dropoff` + `phase5_step1_dropoff` rates, A/B-tested.

**Why it matters:** Income-adjacent questions are where users feel exposed.
Telling them why is cheap; not telling them is expensive.

**FRD link:** FR-4.1.* + FR-5.1.* (Stage 4) — open question on always-shown vs
tap-to-reveal in §1.6.

### H5 — Pre-filled budgets by region + earning type lift completion

**Hypothesis:** Phase 5.1 completion rate ≥85% when categories are pre-filled
by region+earning-type, vs ≤60% with empty fields.

**Signal:** `phase5_step1_completed` rate.

**Why it matters:** Per the narrative: "We're building the dashboard's skeleton
in real time as the user answers." Pre-fills aren't laziness — they're showing
the user FELO already knows their context.

**FRD link:** FR-5.1.* (Stage 4) + budget templates seed (Stage 4 schema)

### H6 — 2-goal hard limit beats unlimited on goal achievement

**Hypothesis:** 90-day goal-progress rate (% of users who made ≥1 contribution
toward at least one goal) is ≥60% for the 2-goal cohort, vs ≤35% for users
allowed unlimited goals (measurable post-launch when the premium-tier
unlimited-goals path opens).

**Signal:** `goal_contribution_made` events joined to slot count.

**Why it matters:** Validates D-008. If the hypothesis fails, the premium-tier
unlimited-goals upsell is wrong; we'd need to rethink.

**FRD link:** FR-5.2.* (Stage 4)

### H7 — Personalized Phase 7 status messages create the emotional payoff

**Hypothesis:** Time spent on Phase 7 (loading screen) median 3-5 seconds with
≥80% of users staying foregrounded; <5% backgrounding before completion.

**Signal:** `phase7_started` to `phase7_completed` time-delta + `app_backgrounded`
events during Phase 7.

**Why it matters:** Per narrative: "This is the most important screen in the
entire app." If users background during Phase 7, they didn't feel the payoff.
A shorter loading or a more personalized one would need to ship.

**FRD link:** FR-7.1.* (Stage 4)

### H8 — Region-filtered bank list lifts Phase 4.2 completion

**Hypothesis:** Phase 4.2 (accounts) completion ≥90% when bank/wallet list is
filtered to user's primary region, vs ≤70% with global list.

**Signal:** `phase4_step2_completed` rate.

**Why it matters:** A Lahore user shouldn't have to scroll past TD Canada Trust.
A Toronto user shouldn't have to scroll past 14 PK banks before finding TD.

**FRD link:** FR-4.2.* (Stage 4) + region-driven banks/wallets reference seed

### H9 — Conditional skip of Phase 6 doesn't hurt domestic-user satisfaction

**Hypothesis:** Domestic-only users (single PK region, "None of the above" in
6.1) report no friction when Phase 6.2 is skipped entirely. Measured by D7
NPS (-2 or better) and qualitative feedback.

**Signal:** Combination of skip rate + post-Phase-8 feedback prompt + D7 NPS.

**Why it matters:** The conditional skip is a design choice. Validating it
ships the right defaults for ~60% of PK users (estimated domestic-only).

**FRD link:** FR-6.* (Stage 4)

### H10 — State persistence drives resume rate after backgrounding

**Hypothesis:** Users who background the app mid-flow return and complete
onboarding at ≥40% within 24 hours, vs ~15% baseline for "abandoned signups."

**Signal:** `onboarding_resumed` events / `onboarding_started` events,
windowed at 24h.

**Why it matters:** Validates D-009. The whole reason we write-on-Continue
is to make resume painless.

**FRD link:** FR-9.* (cross-cutting state, Stage 4)

### H11 — OAuth lifts Phase 1 conversion vs email/mobile

**Hypothesis:** Phase 1 completion rate is ≥95% for users who pick Google/Apple,
vs ≥70% for users who pick email/mobile (which requires the OTP step).

**Signal:** `phase1_step3_completed` grouped by `signup_method`.

**Why it matters:** OAuth removes the OTP step entirely. Confirms the brief's
ordering of signup methods: OAuth first, email/mobile as fallbacks.

**FRD link:** FR-1.2.* (Stage 4)

### H12 — Phase 5.2 redesign lifts goals completion vs current "teesy" UI

**Hypothesis:** Phase 5.2 (goals) completion rate ≥75% with the redesigned
card-grid UI, vs the legacy onboarding's current ~?% (TBD — needs a baseline
measurement on the legacy `lib/features/onboarding/` flow before v2 ships).

**Signal:** `phase5_step2_completed` rate, A/B-tested with the legacy flow
on the feature flag.

**Why it matters:** This is the highest-risk phase per the narrative's drop-off
table ("HIGHEST RISK PHASE"). The redesign justifies its cost only if the
metric moves.

**FRD link:** FR-5.2.* (Stage 4)

**Open prerequisite:** Establish baseline % from legacy flow before Stage 7.
See open questions in §1.6.

---

## 1.4 Success metrics

### North star

**% of new installs that reach Phase 8 (Dashboard Reveal) within their first
session.**

This is the single most important metric. It captures every drop-off in the
8-phase journey. Target for v1 launch: **≥70%**.

### Per-step funnel targets

Aligned to the canonical narrative's drop-off risk table:

| Phase | Target completion (cumulative from install) |
|---|---|
| 1 — Identity | ≥85% |
| 2 — Context | ≥90% × Phase 1 = ≥77% |
| 3 — Permissions (any grant or skip) | ≥95% × Phase 2 = ≥73% |
| 4 — Financial profile | ≥90% × Phase 3 = ≥66% |
| 5 — Intent (budget + 2 goals) | ≥85% × Phase 4 = ≥56% |
| 6 — Remittance (or skip) | ≥98% × Phase 5 = ≥55% |
| 7 — Loading | ≥99% × Phase 6 = ≥54% |
| 8 — Dashboard reveal | ≥99% × Phase 7 = ≥53% |

Stretching these to ≥70% north star requires either tightening the drop-off
targets or reducing the install-to-Phase-1 funnel loss. Both are post-launch
optimization levers.

### Secondary metrics

- **D1 retention** — % of users active the day after Phase 8. Target ≥45%
  (Phase 8 personalization should drive same-day return).
- **D7 retention** — Target ≥30%.
- **D30 retention** — Target ≥15%.
- **Goal-completion rate** — % of users who make ≥1 goal contribution within
  90 days. Target ≥60%. Validates H6.
- **Account-linking rate** — % of users who tap "Connect" on at least one
  account tile within 7 days of Phase 8. Target ≥50%. (Note: actual bank
  linking is post-onboarding, but tapping the CTA is a proxy for intent.)
- **SMS permission grant rate** — Target ≥75%. Validates H3.
- **Phase 7 backgrounding rate** — Target ≤5%. Validates H7.

### Per-persona variation

Different personas have different expected paths:

| Persona | Expected screens | Expected time |
|---|---|---|
| Student Sana (shortest path) | ~12 screens | ~4 minutes |
| Salaried Saadia | ~14 screens | ~5 minutes |
| Diaspora Daniyal | ~15 screens | ~6 minutes |
| Freelancer Faisal (longest path) | ~17 screens | ~7 minutes |

If actual time per persona deviates ≥30% from these targets, we have either a
copy/design problem or a state-persistence bug.

---

## 1.5 Non-goals for v1

Per the brief, none of these ship in this onboarding sprint:

- **Bank API integration** — accounts are selected during onboarding for tile
  display + categorization context, but actual transaction-feed wiring is
  post-onboarding (and gated on Plaid-equivalent infrastructure that doesn't
  yet exist for our markets)
- **Real money movement** — FELO is read-only in v1; no transfers, no payments,
  no remittance execution
- **Crypto trading** — Phase 4.4 captures "I invest in crypto" as context for
  dashboard widgets, but no order placement or wallet creation
- **Investment advice / robo-advisory** — Phase 4 captures investment types as
  context only; no recommendations, no portfolio rebalancing, no regulated
  advisory disclaimers
- **Multi-language UI** — EN-only per D-004; Urdu/Hindi/Bengali ARB port is
  tracked debt for post-v1
- **Premium tier / paywall during onboarding** — D-008 plants the upsell seed
  ("FELO Plus members can set unlimited goals") but no purchase flow ships
- **Phase 8's full dashboard** — D-010 ships a configurable handoff stub that
  proves data flowed; the rich dashboard (transactions ledger, charts,
  detailed widgets) remains a separate downstream deliverable

### Things that look like non-goals but actually ship

- **SMS permission GRANT** ships. **SMS parsing engine** is non-goal — the
  permission is captured for later use; no parsing happens in v1.
- **Account selection** ships. **Account balance fetch** is non-goal —
  selected accounts render as "Connect" CTAs on the dashboard.
- **Goals** ship with target amount + target date. **Auto-roundup engine**
  that contributes to goals is non-goal (yesterday's wire-through retrospective
  flagged this as a polish-cycle item).
- **Remittance corridors** ship as Phase 6 user input. **Live FX rates** in
  the dashboard remittance tile are non-goal for v1; static reference rates
  acceptable.

---

## 1.6 Open questions

These are the gaps the canonical narrative leaves unresolved. Each must be
answered before PRD lock at Review Gate 2 (end of Stage 3). Defaults are
listed but should be confirmed.

### Q1 — "Why we ask" microcopy: always-shown vs tap-to-reveal vs first-time-only

**Context:** Hypothesis H4 depends on this UX. Three options:

- **Always-shown** — every sensitive question shows a 1-line "we ask because…"
  underneath. Simplest; reads as more transparent; adds vertical screen height.
- **Tap-to-reveal** — small "?" icon next to the field; users opt in. Clean;
  may be missed.
- **First-time-only** — shown once per session/user; assumes trust is earned
  after the first tap. Sophisticated; harder to A/B.

**Default:** Always-shown for sensitive questions (income, accounts, goals);
omitted for low-stakes questions (name, region).

### Q2 — Premium-tier disclosure timing

**Context:** D-008 plants an upsell seed in Phase 5.2 ("FELO Plus members can
set unlimited goals"). When else does FELO Plus get mentioned?

- **A — Onboarding-silent** — never mentioned until post-Phase-8 when the user
  hits a Plus-gated feature
- **B — Phase 5.2 only** — single mention as the seed; no other touchpoint
- **C — Phase 8 reveal** — the dashboard shows a "Try Plus free for 30 days"
  banner

**Default:** B. Single mention, no banner. Avoids feeling sales-y during
onboarding.

### Q3 — Region detection failure UX

**Context:** D-006 says NestJS does the IP→country lookup. What if the resolver
returns no country or low confidence (corporate proxy, satellite ISP, VPN)?

- **A — Fall back to a country picker with no pre-selection** — user picks
  manually, no friction beyond losing the H1 lift
- **B — Fall back with a hint** — "We couldn't detect your country
  automatically — please pick" with a search field
- **C — Block onboarding** — show an error and ask user to retry on a different
  network. Worst UX; only acceptable if no fallback works.

**Default:** B. Better than A because it explains the deviation; better than C
because it's recoverable.

### Q4 — Goal target-date validation

**Context:** Phase 5.2 captures target amount + target date per goal. What
constraints?

- **Allow past dates?** Probably no — but a user who set an "Emergency fund
  by 2025-12-31" goal in 2026 should be allowed to update their target.
- **Minimum future window?** "≥30 days from today"? "≥1 month"?
- **Maximum future window?** Hajj or retirement could be 30 years out — no cap?
- **Date input UI?** Native date picker, or custom month/year picker? Custom
  is better for far-future goals where day-precision is meaningless.

**Default:** Min 30 days, no max, custom month/year picker for >1 year out and
native date picker for ≤1 year. Confirm at Stage 3.

### Q5 — Investment platform/broker selection

**Context:** Phase 4.4 captures investment types (Stocks, Crypto, etc.). The
brief says "for each selected → optional follow-up to indicate which platform/
broker (deferred to dashboard, just store selection in v1)."

The narrative agrees with the deferral. But: when does the dashboard prompt for
this? Day 1? On first investment widget tap? Never (only when user manually
adds in settings)?

**Default:** Never auto-prompt; surface as "Add your broker" in the investment
widget on the dashboard. Confirm at Stage 3.

### Q6 — Phase 7 timeout / error handling

**Context:** Phase 7 status messages are "real work, not theater" per the
narrative. What if the work fails mid-loading? FX rate fetch times out, market
data API is down, dashboard config builder throws?

- **A — Continue to Phase 8 anyway** — degraded dashboard (no FX, no market
  data); user can refresh later
- **B — Show a recoverable error** — "We had trouble building your dashboard.
  Retry?" with full context preserved
- **C — Block forever on the failed message** — never. UX-hostile.

**Default:** A for individual widget failures (degraded dashboard), B for the
core profile/budget/goals build failure (which is non-recoverable without
retry). Confirm at Stage 3.

### Q7 — "I'll add later" affordance on Phase 4.2 (accounts)

**Context:** The narrative says Phase 4.2 has a multi-select pill UI. What if
the user genuinely doesn't want to select any accounts now (e.g., wants to
explore the app first)?

- **A — Empty selection allowed** — Continue button enabled with 0 accounts
- **B — Force at least 1 account** — Continue disabled with 0 accounts
- **C — "I'll add later" link** — explicit skip, sets `accountsDeferred: true`

**Default:** C. Lets us track the deferral analytically; lets the dashboard
show a richer "Add your first account" CTA.

### Q8 — Legacy-flow baseline measurement before Stage 7

**Context:** H12 needs a baseline on the legacy onboarding's Phase 5.2
completion rate. The legacy flow exists in `lib/features/onboarding/` but
isn't currently instrumented at the per-step level.

- **A — Skip baseline** — measure v2 only; can't directly validate H12
- **B — Add lightweight instrumentation to legacy** — 1 day of work; requires
  pre-launch
- **C — Run a brief A/B post-Stage-7** — flag-gated 50/50 split for 2 weeks
  to capture both numbers

**Default:** C. Doesn't delay v2 launch; gives the cleanest H12 validation.
Confirm at Stage 5 sprint planning.

### Q9 — Phase 6.1 wording: "regularly" / "abroad" / "household"

**Context:** Phase 6.1 multi-select options include "I send money to family
regularly" and "I receive money from abroad" and "I manage shared household
expenses." These are colloquial; do they mean different things in PK / IN / BD
/ UAE / SA?

**Cultural-fit risk:** "Family" in PK includes extended family (cousins,
in-laws, siblings); in CA it's typically nuclear. "Household" in UAE may mean
"the workers I live with"; in PK it's "the family I live with." Wording matters.

**Default:** Run wording past 2-3 native speakers per market before Stage 3
PRD lock. Track open until done.

### Q10 — IP detection vendor

**Context:** Already raised at Review Gate 0. Default = MaxMind GeoLite2
self-hosted (prod), ipinfo.io (dev). Awaiting confirmation.

**Resolution path:** Lock at Stage 4 with cost + privacy review. Open Q at
Review Gate 1 unless answered now.

### Q11 — D-007 vendor placeholder stance

**Context:** Already raised at Review Gate 0. Default = ship architecture, plug
specific vendors in when procurement closes.

**Resolution path:** Same as Q10. Lock at Stage 4 with whatever vendor
agreements have closed by then.

---

## 1.7 What changes in scope after Stage 1

This stage didn't add new features. It added **measurement targets, validation
hypotheses, and explicit unknowns**. What it changes for downstream stages:

- **Stage 2 (Personas)** must produce per-persona path statistics aligned to
  §1.4's screen-count / time targets. If a persona's expected path doesn't fit
  the narrative's drop-off table, the persona is wrong.
- **Stage 3 (PRD)** must close Q1-Q9 (and Q10/Q11 if not answered at Review
  Gate 1) before lock. Each open question becomes a PRD section with the
  resolved decision.
- **Stage 4 (FRD + System Design)** must define the schema for analytics
  events such that every hypothesis in §1.3 is queryable.
- **Stage 5 (Sprint planning)** must include a story for Q8's legacy-flow
  baseline if option C is picked.
- **Stage 6 (Analytics)** is the validator. Every hypothesis here gets a SQL
  query template in `06-analytics/funnel-queries.sql`.
- **Stage 7 (Implementation)** ships the journey such that all targets in
  §1.4 are achievable. If they're not after launch, we revise the journey,
  not the metrics.

---

## 1.8 Decision log additions

Stage 1 surfaced no new architectural decisions. All input feeds Stage 2-3.
The 11 open questions above are the next decisions to lock.

The full decision log remains:

| ID | Stage | One-liner |
|---|---|---|
| D-001..D-007 | Stage 0 | (Repo / SMS / i18n / vendors — see [`../decision-log.md`](../decision-log.md)) |
| D-008 | Stage 0 | Exactly 2 goals (hard) |
| D-009 | Stage 0 | Write-on-Continue, resume-from-last-completed-step |
| D-010 | Stage 0 | Stage 7 success = dashboard reflects every input |
| D-011..D-021 *(TBD)* | Stage 3 | One per Q1-Q11 once resolved |

---

## 1.9 Sign-off checklist for Review Gate 1

- [ ] Problem statement matches what's been observed in user research
- [ ] Market context numbers are accurate (smartphone / banking / wallet penetration)
- [ ] Hypotheses H1-H12 are accepted as the validation surface for v1 launch
- [ ] Success metric targets in §1.4 are realistic given the narrative's drop-off table
- [ ] Non-goals in §1.5 are agreed; nothing missing
- [ ] Open questions Q1-Q11 are noted; defaults reviewed; explicit answers
      requested for any that block Stage 2 (Personas) or Stage 3 (PRD)

When all checked, reply **"approved, continue"** and Stage 2 (Personas) starts.
