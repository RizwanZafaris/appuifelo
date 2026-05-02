# Stage 2 — Personas

> **Companion to:** [`../00-discovery/user-journey-as-told.md`](../00-discovery/user-journey-as-told.md) (canonical narrative) · [`../00-discovery/discovery.md`](../00-discovery/discovery.md) (Stage 1)
> **Date:** 2026-04-26
> **Status:** Awaiting Review Gate 2 approval.
>
> Five personas covering FELO's onboarding edge cases. Each is walked through
> all 8 phases. The per-persona path stats here must match the screen-count /
> time targets in `discovery.md §1.4`. If they don't, either the persona is
> wrong or the success metric is wrong.

---

## Persona summary

| # | Name | Location | Age | Type | Path | Time |
|---|---|---|---|---|---|---|
| P1 | **Saadia** Khan | Karachi, PK | 28 | Salaried (modal user) | 14 screens | ~5 min |
| P2 | **Faisal** Mahmood | Lahore, PK | 34 | Freelancer + Investor | 17 screens | ~7 min |
| P3 | **Daniyal** Hassan | Toronto, CA | 41 | Diaspora remitter | 15 screens | ~6 min |
| P4 | **Bushra** Iqbal | Islamabad, PK | 45 | Business owner (mixed) | 16 screens | ~6 min |
| P5 | **Sana** Rahman | Dhaka, BD | 21 | Student (shortest path) | 12 screens | ~4 min |

---

## P1 — Salaried Saadia (Karachi, 28)

### Profile

- **Job:** Relationship manager at a private bank in Karachi (~5 years' tenure)
- **Income:** PKR 180,000/month, paid on the 1st via direct deposit
- **Currency exposure:** PKR only
- **Banking:** HBL salary account (where her employer pays); a small Easypaisa
  wallet for utility bills; no credit card
- **Investments:** None. Considered Mutual Funds via her bank's app once,
  didn't follow through
- **Family situation:** Single, lives with parents in DHA; sends PKR
  20,000-30,000/month to her parents for household expenses (informally — same
  household, just a contribution)
- **Smartphone:** Mid-range Android (Infinix), Pakistani SIM, avg English
  literacy
- **Why she'd download FELO:** A friend mentioned it; she's curious whether
  she's actually saving as much as she thinks she is

### Mental model entering the app

> "Probably another budgeting app. I'll give it five minutes — if it's
> annoying I'll uninstall."

She's signed up to plenty of apps. She's wary of permission-grabbing. She
won't tolerate a 20-question form. But she's the modal user FELO needs to
serve — if Saadia churns at Phase 3, FELO's market fit is wrong.

### 8-phase walkthrough

**Phase 1 — Identity** (2 screens, 30s)
- Welcome screen — taps "Get started" without reading the value prop
- Picks Google sign-in (her most-used login method) → instant verification

**Phase 2 — Context** (2 screens, 30s)
- IP detection shows "Pakistan — PKR" pre-selected. She taps Continue without
  changing anything. *Doesn't add a secondary region.*
- Name pre-filled "Saadia" from Google. Edits to "Saadia K." Continue.

**Phase 3 — Permissions** (1 screen, 30s)
- Reads the SMS pitch carefully — "auto-track every transaction, never type
  a number." Grants SMS. ✅
- Grants notifications without much thought. ✅
- **Skips location.** No interest in place-based categorization.
- **Skips contacts.** No reason to share now.

**Phase 4 — Financial profile** (3 screens, 60s)
- Earning type: picks **Salaried** only. Single tap. Continue.
- Accounts: list shows Pakistani banks first. Picks **HBL** + **Easypaisa**.
  Continue.
- Invest: **No.** Skips Phase 4.4 entirely.

**Phase 5 — Intent** (2 screens, 90s) — **highest engagement phase**
- Budget: pre-filled total ₨120,000 (FELO's salaried-PK template suggests
  ~67% of stated income, but Saadia hasn't told FELO her income yet — the
  template is a starting point). She adjusts down to ₨90,000.
  - Categories pre-filled: Food ₨20k / Transport ₨10k / Rent ₨0 (lives with
    parents) / Shopping ₨15k / Family support ₨25k / Savings ₨20k
  - She zeros out Rent, bumps Family support to ₨30k. Continue.
- Goals: picks exactly 2 — **Travel** (target ₨300,000 by Dec 2026) and
  **Emergency fund** (target ₨500,000 by Jun 2028).
  - Auto-calc shows: ₨37,500/month + ₨18,500/month = ₨56,000/month required.
    Her budget allows ₨20,000/month savings. *Soft warning fires:*
    "You'd need ₨56,000/month — your budget allows ₨20,000. Adjust?"
  - She doesn't adjust. Acknowledges and continues. (Real users will do this
    most of the time. The warning is informational, not blocking.)

**Phase 6 — Remittance** (1 screen, 15s)
- Multi-select shows. She picks **"I support family members financially"**
  but unchecks "I send money to family regularly" (she lives with them).
- Phase 6.2 (corridor) is **skipped** — same-household support isn't a
  cross-border corridor.

**Phase 7 — Loading** (3-5s)
- Status messages reference her actual inputs:
  - "Setting up your PKR account..."
  - "Linking HBL and Easypaisa..."
  - "Building your budget for ₨90,000..."
  - "Tracking your Travel and Emergency fund goals..."
  - "Personalizing your dashboard, Saadia..."

**Phase 8 — Dashboard reveal**
- Greeting: "Salaam, Saadia 👋"
- Net position card in PKR
- 2 account tiles (HBL + Easypaisa) — both show "Connect"
- Budget ring: ₨90,000 monthly
- 2 goal hero cards (Travel + Emergency fund) at 0% with target dates
- **No** investment section
- **No** remittance tile
- Earning-type widget: "Days until next salary: 6 days"

### Drop-off risks for Saadia

| Phase | Risk | Mitigation |
|---|---|---|
| 1 | Low — Google sign-in is frictionless | — |
| 3 | Medium — could decline SMS if framing is weak | "Never type a number" copy |
| 5.2 | Low for her — only 2 goals to pick fits her mental model | — |
| Loading | Low — 3-5 seconds is acceptable | — |

### Success criterion specifically for Saadia

When she hits Phase 8 and sees "Days until next salary: 6 days" + her HBL tile
+ Travel goal, she should feel "this is mine, this is for salaried Pakistanis
like me." If the dashboard shows generic placeholders, she churns the same day.

### Conditional logic the PRD must address (from P1)

- **Phase 5.2 over-ambitious-goal warning is non-blocking.** Most users
  pick aspirational targets; the warning is a soft nudge, not a wall.
- **Phase 6.1 "I support family members financially" alone (without "send
  regularly") doesn't trigger Phase 6.2.** Same-household support is
  domestic.
- **"Days until next salary" widget shows iff Phase 4.1 includes "Salaried"**
  AND user's Phase 5.1 budget is structured around a monthly cadence.

---

## P2 — Freelancer Faisal (Lahore, 34)

### Profile

- **Job:** Senior backend developer freelancing for US/EU agencies via
  Upwork and direct contracts
- **Income:** Irregular. Roughly USD 4,500-7,000/month, paid via Wise → JazzCash
  + SadaPay; some clients still use bank wire to Bank Alfalah
- **Currency exposure:** USD (earnings) + PKR (spending) + small ETH/SOL
  positions (~USD 8,000)
- **Banking:** JazzCash (primary spend), SadaPay (secondary), Bank Alfalah
  (formal account for taxes), Wise (USD holding)
- **Investments:** Crypto (Binance Pakistan, before ban — now uses a global
  exchange via VPN); occasional stocks via Bourse Plus
- **Family:** Married, one kid. Wife works part-time. Lives in DHA Lahore.
  Sends PKR 50,000/month to his parents in Faisalabad (separate household)
- **Smartphone:** iPhone 14, Pakistani + UK SIM (uses UK number for some clients)
- **Why he'd download FELO:** Saw it on a Pakistani fintech newsletter; thinks
  he can finally consolidate his "5 wallet apps and 2 banking apps" view

### Mental model entering the app

> "If this can show me my actual net worth across PKR + USD + crypto, I'll
> use it. Otherwise it's another spreadsheet replacement."

He's the demanding power user. He'll skim the welcome screen but won't tolerate
laziness. If FELO's currency conversion is wrong on day one, he'll uninstall.

### 8-phase walkthrough

**Phase 1 — Identity** (2 screens, 25s)
- Picks **Apple** sign-in (privacy-conscious, Apple's "hide my email" feature)

**Phase 2 — Context** (2 screens, 60s) — **his longest non-financial step**
- IP shows "Pakistan — PKR" pre-selected. Confirms.
- Taps **"+ Add another region"** → adds **United States — USD** (his
  primary client geography)
- Name pre-filled from Apple "Faisal M." (Apple gives less data than Google).
  Continue.

**Phase 3 — Permissions** (1 screen, 30s)
- Grants SMS — knows it's the value prop. ✅
- Grants notifications. ✅
- **Skips location.** Doesn't trust apps with location.
- **Skips contacts.** Same.

**Phase 4 — Financial profile** (4 screens, 120s) — **most engagement here**
- Earning type: picks **Freelancer** + **Investor** (multi-select). Continue.
- Accounts: list shows PK banks/wallets (because primary region = PK).
  Picks **JazzCash** + **SadaPay** + **Bank Alfalah**. Then notices:
  "Where's Wise?" — Wise is in the wallets list (FELO's seed includes
  international wallets relevant to PK diaspora/freelancers). Picks it.
- Invest: **Yes.**
- Investment types: picks **Crypto** + **Stocks**. Continue. (Open Q5 from
  discovery: no platform follow-up here; deferred to dashboard.)

**Phase 5 — Intent** (2 screens, 120s) — **slowest step for Faisal**
- Budget: pre-filled template for "Freelancer + multi-currency" emphasizes
  *savings buffer* heavily because of irregular income. Total ₨300,000.
  - Categories: Food ₨40k / Transport ₨15k / Rent ₨80k / Family support
    ₨50k / Savings ₨80k / Buffer ₨35k
  - He cuts buffer to ₨0 (he keeps buffer in USD), bumps savings to ₨110k.
    Continue.
- Goals: picks **Buy a home** (₨15M, 5 years) + **Education fund** for kid
  (USD 30k, 15 years).
  - Multi-currency goal! FELO must accept the goal's target in any currency
    the user has exposure to (this is a Stage 4 FRD-level question).
  - Auto-calc fires for both. Soft warning at home goal because aggressive.
    Acknowledges, continues.

**Phase 6 — Remittance** (2 screens, 30s) — **uses cross-border**
- Multi-select: picks **"I receive money from abroad"** + **"I support
  family members financially"**.
- Phase 6.2 fires.
  - Pre-selected "Receive from: USA" (because secondary region = US)
  - Pre-selected "Send to: <none>" — but Faisal sends to his parents
    domestically (within PK), so no cross-border send. He leaves it empty.
  - *Open question Q9 from discovery surfaces:* The Phase 6.1 wording
    "I support family members financially" is true for Faisal (he supports
    his parents in Faisalabad) but Phase 6.2 cross-border send-to is empty.
    Is the Phase 6.2 even triggered when only "support" is checked but no
    cross-border? — must answer at Stage 3.

**Phase 7 — Loading** (4-5s)
- Status messages reference his inputs:
  - "Setting up your PKR + USD accounts..."
  - "Linking JazzCash, SadaPay, Bank Alfalah, Wise..."
  - "Building your multi-currency budget..."
  - "Tracking Buy a home and Education fund..."
  - "Connecting your USA → Pakistan corridor..."
  - "Loading your crypto and stock positions..."
  - "Personalizing your dashboard, Faisal..."

**Phase 8 — Dashboard reveal**
- Greeting: "Salaam, Faisal 👋"
- Net position with currency toggle (PKR / USD)
- 4 account tiles (JazzCash, SadaPay, Bank Alfalah, Wise)
- Budget ring
- 2 goal hero cards (Buy a home, Education fund) — both with multi-currency
  display (PKR equivalent shown for the USD goal)
- **Investment section visible** — crypto card + stocks card, both showing
  "Add your broker" CTA
- **Remittance tile visible** — USA → Pakistan corridor highlighted
- Earning-type widget: "This week's invoices" (freelancer-flavored, not
  salary-flavored)

### Drop-off risks for Faisal

| Phase | Risk | Mitigation |
|---|---|---|
| 4.2 | High — list might not include Wise | Include international wallets in PK seed |
| 5.1 | Medium — multi-currency budget is non-trivial | Currency picker in budget total; clear template explanation |
| 5.2 | Medium — multi-currency goal target | Allow goal target in any user-currency |
| 6.2 | Medium — confusion if "support" is checked without cross-border | Resolve Q9 at Stage 3 |

### Success criterion specifically for Faisal

When Phase 8 shows his crypto + stocks + Wise USD balance preview correctly
**in his secondary currency (USD)**, he stays. If currencies are mashed into
PKR with no toggle, he uninstalls.

### Conditional logic the PRD must address (from P2)

- **Multi-currency goal target.** Phase 5.2 must let the user pick the
  currency for each goal independently. Stage 4 FRD-level.
- **Phase 6.2 trigger logic.** Cross-border send-to is independent of
  domestic-support. Must enumerate the truth table at Stage 3.
- **International wallet seed for PK region.** Wise, Payoneer, PayPal —
  not just local PK wallets — should appear when primary region = PK AND
  earning type includes "Freelancer" or "Investor."
- **Currency toggle on Phase 8.** Mandatory if user has secondary region.

---

## P3 — Diaspora Daniyal (Toronto, 41)

### Profile

- **Job:** Senior software engineer at a Toronto-based bank (10+ years)
- **Income:** CAD 165,000/year, biweekly pay
- **Currency exposure:** CAD (primary), PKR (parents in Pakistan), small
  USD via TFSA brokerage
- **Banking:** TD Canada Trust (chequing + savings), RBC (Mastercard +
  Mortgage), Wealthsimple (TFSA + RRSP)
- **Investments:** ETFs in Wealthsimple (~CAD 180k); Canadian-listed REITs;
  no crypto
- **Family:** Married to a Pakistani-Canadian; two kids; sends CAD 1,200-1,500
  to his parents in Karachi every month via Remitly
- **Smartphone:** iPhone 15 Pro, Canadian SIM only
- **Why he'd download FELO:** A cousin in Karachi mentioned FELO; Daniyal
  wants something that "actually understands the Canada-to-Pakistan corridor"
  — Mint never did

### Mental model entering the app

> "I've used Mint, YNAB, Monarch, Copilot. Show me something they don't."

He's the diaspora power user. The Phase 6 corridor is a feature he's been
waiting for. If FELO doesn't pre-fill "Send to: Pakistan" without him
typing, he loses interest fast.

### 8-phase walkthrough

**Phase 1 — Identity** (2 screens, 25s)
- Picks **Apple** sign-in.

**Phase 2 — Context** (2 screens, 30s) — **the moment FELO either wins or loses him**
- IP shows "Canada — CAD" pre-selected (he's in Toronto). H1 fires correctly.
- Taps **"+ Add another region"** → picks **Pakistan — PKR**. (FELO must
  surface this as a recommended add-on for Canada users — see PRD §3.3.)
- Name pre-filled "Daniyal H." Continue.

**Phase 3 — Permissions** (1 screen, 25s)
- Grants notifications. ✅
- **Doesn't grant SMS.** Why? He's on Canadian SIM; PK banks don't send SMS
  to his Canadian number. SMS parsing is irrelevant for him. Skips. ✅ for FELO
  — this is the right behavior; the permission framing must explain the SMS
  unlock applies "if your bank sends transaction SMS to this device."

**Phase 4 — Financial profile** (4 screens, 90s)
- Earning type: picks **Salaried** + **Investor**.
- Accounts: list shows **Canadian banks first** (TD, RBC, Wealthsimple all
  visible as "Canadian banks" + "Canadian wallets" pills). Picks **TD** +
  **RBC** + **Wealthsimple**. Continue.
  - Note: he has secondary region PK but doesn't tap a PK bank because his
    parents have those, not him. The PRD must allow secondary-region banks
    to be optional, not auto-shown.
- Invest: **Yes.**
- Investment types: picks **Stocks** + **Mutual Funds**.

**Phase 5 — Intent** (2 screens, 90s)
- Budget: pre-filled template for "Salaried + Canada" suggests CAD 6,000/month
  (50% of stated income; FELO's CA template). He adjusts up to CAD 7,500.
  - Categories: Food $1.5k / Transport $300 / Rent/mortgage $3.2k / Daycare
    $1.5k / Savings $1k / Family support $1.2k (CAD).
  - **Family support is in CAD** but earmarked for PKR conversion via
    Remitly. The dashboard remittance tile must show this rate.
- Goals: picks **Retirement** ($1.5M CAD by 2050) + **Education fund** for
  kids ($120k CAD by 2040).

**Phase 6 — Remittance** (2 screens, 30s) — **his hero phase**
- Multi-select: picks **"I send money to family regularly"**.
- Phase 6.2: pre-selected "Send to: Pakistan" (because secondary region = PK,
  primary region = CA, this is the canonical diaspora flow). He doesn't change
  anything. Continue.

**Phase 7 — Loading** (4-5s)
- Status messages reference his inputs:
  - "Setting up your CAD account..."
  - "Linking TD, RBC, and Wealthsimple..."
  - "Building your budget for $7,500/month..."
  - "Tracking your Retirement and Education fund goals..."
  - "Connecting your Canada → Pakistan corridor..."
  - "Loading your stock and mutual fund positions..."
  - "Personalizing your dashboard, Daniyal..."

**Phase 8 — Dashboard reveal**
- Greeting: "Hello, Daniyal 👋"
- Net position in **CAD with PKR equivalent** subtitle ("≈ ₨X.XM")
- 3 account tiles (TD, RBC, Wealthsimple)
- Budget ring
- 2 goal hero cards (Retirement, Education fund) — long-horizon
- **Investment section visible**
- **Remittance tile prominently shown** — "Canada → Pakistan" with current FX
  rate, recent send tracking, suggested next-send-date based on his pattern
  (post-onboarding feature; v1 just shows the tile)
- Earning-type widget: "Days until next paycheck: 9 days"

### Drop-off risks for Daniyal

| Phase | Risk | Mitigation |
|---|---|---|
| 2 | Critical — must auto-detect CA correctly via IP | MaxMind / ipinfo |
| 3 | Low — he expects to skip SMS | Permission copy explains the relevance |
| 6 | Low — pre-fill is the magic moment for him | Deliver the pre-fill correctly |
| 8 | High if remittance tile is missing | D-010 enforces it |

### Success criterion specifically for Daniyal

When Phase 8 shows the "Canada → Pakistan" remittance tile **without him
typing it**, he stays. The pre-fill is the entire reason he downloaded FELO.

### Conditional logic the PRD must address (from P3)

- **Secondary-region banks are not auto-suggested.** A diaspora user with
  secondary region PK should still see only Canadian banks in Phase 4.2
  unless they tap "Show banks from my secondary regions."
- **CA→PK is the canonical diaspora corridor.** Phase 6.2 pre-fills
  "Send to: Pakistan" automatically when primary = CA AND secondary
  includes PK.
- **Multi-currency net position display.** Mandatory primary-currency view
  + collapsible secondary-currency subtitle on Phase 8.
- **SMS permission framing must mention "applies when bank sends SMS to
  this device"** — otherwise diaspora users feel pressured to grant it for
  no reason.

---

## P4 — Business owner Bushra (Islamabad, 45)

### Profile

- **Job:** Owner of a small textile export business (~10 employees);
  business is registered in Pakistan but exports to UAE retailers
- **Income:** Highly variable. Personal salary PKR 350k/month; business cashflow
  PKR 5-15M/month
- **Currency exposure:** PKR + AED + USD (export receivables)
- **Banking:** Bank Al Habib (personal salary), HBL Business (commercial),
  Standard Chartered (international wire), JazzCash (employee
  reimbursements), small UAE business account at Mashreq
- **Investments:** Real estate (3 plots in Islamabad), gold (deposit box),
  some stocks via Bourse Plus
- **Family:** Married, 3 kids (oldest in university), widowed mother she
  supports, household runs ~PKR 250k/month
- **Smartphone:** Samsung S22, Pakistani SIM
- **Why she'd download FELO:** Her accountant nephew suggested it; she
  conflates business and personal finances and wants help separating

### Mental model entering the app

> "I have an accountant for the business. I want this for my own money."

Critical insight: **Bushra wants FELO to track her PERSONAL finances, not
the business.** FELO must clearly position itself as personal-finance to
not scare her with promises it can't keep.

### 8-phase walkthrough

**Phase 1 — Identity** (2 screens, 30s)
- Picks **Email** sign-up. (Her generation prefers email; she has 3 inboxes
  open at any time.) Enters her email; verifies with 6-digit OTP.

**Phase 2 — Context** (2 screens, 45s)
- IP: "Pakistan — PKR" pre-selected. Continue.
- Taps **"+ Add another region"** → picks **United Arab Emirates — AED**
  (where her business sells).
- Name "Bushra" — types it manually.

**Phase 3 — Permissions** (1 screen, 30s)
- Grants SMS. ✅ (She gets a lot of bank SMS; this is valuable.)
- Grants notifications. ✅
- Skips location, contacts.

**Phase 4 — Financial profile** (4 screens, 100s) — **most cluttered for her**
- Earning type: picks **Business owner** + **Salaried** + **Investor**.
  (Multi-select demonstrates real-life hybrid.)
- Accounts: she sees the PK list. Picks **Bank Al Habib** + **HBL** +
  **Standard Chartered** + **JazzCash**. *Doesn't pick Mashreq because the
  list defaults to her primary region.*
  - **Open question for PRD:** Does the AED secondary region surface UAE
    banks in Phase 4.2? Bushra needs Mashreq. If she has to add it
    post-onboarding, that's friction.
- Invest: **Yes.**
- Investment types: picks **Real Estate** + **Gold** + **Stocks**.

**Phase 5 — Intent** (2 screens, 90s)
- Budget: pre-filled template for "Business owner + Salaried" emphasizes
  *separation between personal and business* — this is critical. Total
  PKR 250,000 (her household monthly).
  - Categories: Food / Transport / Rent (₨0, owns home) / Family support
    (₨80k for mother) / Education (kids' fees ₨60k) / Savings (₨50k)
  - She's used to mental-modeling much larger numbers (business cashflow);
    the modesty of the personal budget is a feature, not a bug.
- Goals: picks **Retirement** + **Education fund** (kids' university).

**Phase 6 — Remittance** (2 screens, 30s)
- Multi-select: picks **"I support family members financially"** (her mother)
  + **"I receive money from abroad"** (UAE export receivables).
- Phase 6.2 fires.
  - Pre-selected "Receive from: UAE" (because secondary region = AE).
  - "Send to" left empty (her support is domestic).

**Phase 7 — Loading** (4-5s)
- Status messages:
  - "Setting up your PKR + AED accounts..."
  - "Linking Bank Al Habib, HBL, Standard Chartered, JazzCash..."
  - "Building your personal budget for ₨250,000..."
  - "Tracking Retirement and Education fund goals..."
  - "Connecting your UAE → Pakistan corridor..."
  - "Loading your real estate, gold, and stock positions..."
  - "Personalizing your dashboard, Bushra..."

**Phase 8 — Dashboard reveal**
- Greeting: "Salaam, Bushra 👋"
- Net position in PKR with AED toggle
- 4 account tiles
- Budget ring
- 2 goal hero cards
- **Investment section visible** — real estate + gold + stocks (3 cards)
- **Remittance tile** — UAE → Pakistan (inbound)
- Earning-type widget: ambiguous (Business owner + Salaried). Could show
  "Cash flow this month" (business-flavored) or "Days until next salary"
  (salaried-flavored). PRD must decide which dominates.

### Drop-off risks for Bushra

| Phase | Risk | Mitigation |
|---|---|---|
| 4.1 | Medium — confused by "is FELO for my business or personal?" | Onboarding copy: "your personal money" |
| 4.2 | High — UAE banks not surfaced | Stage 3 PRD must close: secondary-region banks |
| Earning widget | Medium — multi-earning-type ambiguity | Stage 3: pick a precedence |

### Success criterion specifically for Bushra

When Phase 8 clearly shows "personal" framing (no business cashflow forecasts,
no payroll widgets), she trusts FELO and uses it for her own money. If FELO
tries to be both, she churns.

### Conditional logic the PRD must address (from P4)

- **Secondary-region bank surfacing.** When secondary = UAE, do UAE banks
  appear in Phase 4.2? Yes? No? With a "Show UAE banks too" toggle?
  Stage 3 must answer.
- **Multi-earning-type widget precedence.** When user picks Business owner
  + Salaried + Investor, which earning-type widget renders on Phase 8?
  Stage 3 must define a precedence rule (e.g., "most-recently-tapped wins"
  or "fixed precedence: Salaried > Freelancer > Business owner").
- **Personal-vs-business framing in copy.** Phase 4.1 + Phase 5.1 must
  reinforce "this is for your personal money, not your business."

---

## P5 — Student Sana (Dhaka, 21)

### Profile

- **Job:** University student at North South University; part-time
  freelance graphic designer (irregular)
- **Income:** BDT 8,000-15,000/month from design work; BDT 12,000/month
  allowance from parents
- **Currency exposure:** BDT only
- **Banking:** Dutch-Bangla Bank student account; **bKash** (primary
  spend)
- **Investments:** None.
- **Family:** Lives in dorm; parents in Sylhet support her
- **Smartphone:** Mid-range Android (Samsung A series), Bangladeshi SIM,
  decent English literacy
- **Why she'd download FELO:** Saw it on Instagram; her older sister uses it

### Mental model entering the app

> "I just want to know if I can afford that lipstick this week."

She's the low-friction first-time user. Every extra question is a chance
to lose her. If FELO asks her about retirement or remittance, she churns
at Phase 5.

### 8-phase walkthrough

**Phase 1 — Identity** (2 screens, 20s)
- Picks **Google** sign-in.

**Phase 2 — Context** (2 screens, 25s)
- IP: "Bangladesh — BDT" pre-selected. ✅ (FELO supports BD as primary
  market.) Continue.
- *Doesn't add a secondary region.*
- Name "Sana" pre-filled. Continue.

**Phase 3 — Permissions** (1 screen, 25s)
- Grants SMS. ✅ (bKash sends SMS for every transaction; she's pumped to
  see it auto-tracked.)
- Grants notifications. ✅
- Skips location, contacts.

**Phase 4 — Financial profile** (3 screens, 60s)
- Earning type: picks **Student** (single tap). Continue.
  - Note: she occasionally freelances. Doesn't multi-select. The PRD must
    NOT punish her for this — the journey adapts to "Student" cleanly.
- Accounts: list shows BD-region. Picks **Dutch-Bangla** + **bKash**.
- Invest: **No.** Skip Phase 4.4.

**Phase 5 — Intent** (2 screens, 60s)
- Budget: pre-filled template for "Student + Bangladesh" → BDT 18,000/month.
  - Categories: Food ৳5k / Transport ৳1.5k / Rent ৳0 (dorm) / Education
    (books) ৳2k / Entertainment ৳3k / Shopping ৳3k / Savings ৳1k / Family
    contribution ৳2.5k
  - She zeros out Family contribution (her parents support HER, not the
    other way around — until later in life). The PRD must handle "Family
    contribution" naturally going to ₨0.
- Goals: picks **Travel** + **Education fund**.
  - "Travel" target: BDT 50,000 by 2027 (a trip to India next year).
  - "Education fund" target: BDT 200,000 by 2027 (master's prep).
  - Auto-calc fires; her budget barely supports either. Soft warning. She
    doesn't care; she still picks both. Continue.

**Phase 6 — Remittance** (1 screen, 10s) — **she skips entirely**
- Multi-select: picks **"None of the above"**.
- Phase 6.2 is **skipped entirely** (her primary region is BD, no secondary,
  no cross-border activity).

**Phase 7 — Loading** (3-4s) — **shorter for her** (less to do)
- Status messages:
  - "Setting up your BDT account..."
  - "Linking Dutch-Bangla and bKash..."
  - "Building your budget for ৳18,000..."
  - "Tracking your Travel and Education fund goals..."
  - "Personalizing your dashboard, Sana..."

**Phase 8 — Dashboard reveal**
- Greeting: "Hello, Sana 👋"
- Net position in BDT
- 2 account tiles (Dutch-Bangla, bKash)
- Budget ring (small denomination — ৳18k)
- 2 goal hero cards (Travel, Education fund)
- **No** investment section
- **No** remittance tile
- Earning-type widget: "Days until next allowance: 12 days" (student-flavored)

### Drop-off risks for Sana

| Phase | Risk | Mitigation |
|---|---|---|
| 4 | Low — short list | — |
| 5 | Medium — auto-warning for over-ambitious goals could feel preachy | Soft warning, dismissable |
| 6 | Critical — must skip cleanly with no friction | Conditional skip enforced |

### Success criterion specifically for Sana

When Phase 8 takes ≤4 minutes and shows her bKash + Dutch-Bangla and her
Travel goal, she's happy. If she sees an empty "Remittance" section or an
"Add your investments" prompt, she feels the app isn't for her.

### Conditional logic the PRD must address (from P5)

- **Student-flavored earning widget.** "Days until next allowance" is the
  right framing for a student. Salaried users get "next paycheck"; freelancers
  get "this week's invoices"; students get "next allowance."
- **BD as a primary market.** Phase 4.2 must include BD banks (Dutch-Bangla,
  Brac, EBL, City Bank) and wallets (bKash, Nagad, Rocket).
- **"Family contribution" can be ₨0.** A student doesn't financially support
  family yet — Phase 5.1 must accept a zero in this category without warning.
- **Phase 6 conditional skip.** Critical for low-friction users. Already in
  the canonical narrative, but Stage 3 PRD must lock the precise truth table.

---

## Cross-persona insights

### Path-length variance is feature, not bug

- Sana: 12 screens, 4 min
- Saadia: 14 screens, 5 min
- Daniyal: 15 screens, 6 min
- Bushra: 16 screens, 6 min
- Faisal: 17 screens, 7 min

Range: 12-17 screens, ~75% variation. The conditional skip + multi-select
pattern means each persona gets the right amount of journey for their context.

### Phase-by-phase persona pressure

| Phase | Where it pressures |
|---|---|
| 1 | Saadia (modal) — Google must work. Bushra — email OTP must be reliable. |
| 2 | Daniyal — IP must auto-detect Canada |
| 3 | Daniyal (might skip SMS legitimately); Saadia (must grant) |
| 4.2 | Faisal (Wise must be in seed); Bushra (UAE banks question) |
| 5.1 | Faisal (multi-currency); Bushra (personal vs business framing) |
| 5.2 | All — but Sana most because budget is tight |
| 6 | Daniyal (corridor pre-fill is hero); Sana (must skip cleanly) |
| 7 | All — must reference actual inputs |
| 8 | All — Bushra (multi-earning widget); Faisal (currency toggle); Daniyal (remittance tile); Saadia (no investment section); Sana (no remittance tile) |

### The 8-phase journey is correctly ordered

Walking through 5 personas confirms:
- **Region before banks** is essential (Faisal needs PK list; Daniyal needs
  CA list)
- **Permissions before financial data** is correct (Saadia/Sana grant before
  effort invested)
- **Earning type before budget** drives the pre-fill (Faisal's irregular vs
  Saadia's salaried)
- **Budget before goals** prevents unrealistic targets (every persona's
  auto-calc warning fires somewhere)
- **Remittance after intent** lets domestic users (Saadia, Sana) skip cleanly

If any phase order changed, at least one persona's journey breaks.

### New open questions surfaced by personas

These get added to the PRD's open question list at Stage 3:

- **Q12** (from P2 Faisal): Multi-currency goal target — must goals accept
  any currency the user has exposure to?
- **Q13** (from P2 Faisal + P5 Sana): Phase 6.1 truth table — when does
  "support family financially" alone trigger Phase 6.2 vs not?
- **Q14** (from P3 Daniyal): SMS permission copy must mention "applies when
  bank sends SMS to this device" so diaspora users don't feel pressured.
- **Q15** (from P4 Bushra): Secondary-region banks in Phase 4.2 — auto-shown,
  toggle, or hidden?
- **Q16** (from P4 Bushra): Multi-earning-type widget precedence on Phase 8.
- **Q17** (from P5 Sana + P1 Saadia): "Family contribution" budget category —
  default semantic (you SUPPORT family vs you GET supported by family)?
- **Q18** (from P5 Sana): Earning-type widget for Student is "next allowance"
  not "next paycheck."

These are PRD-resolvable; none change the journey's architecture.

---

## Persona → Phase 8 dashboard contract

D-010 says the dashboard is the success criterion. Here's the per-persona
dashboard contract — Stage 7 must produce this exact output for each persona's
inputs:

| Element | Saadia (P1) | Faisal (P2) | Daniyal (P3) | Bushra (P4) | Sana (P5) |
|---|---|---|---|---|---|
| Greeting | Salaam | Salaam | Hello | Salaam | Hello |
| Currency | PKR | PKR (toggle USD) | CAD (toggle PKR) | PKR (toggle AED) | BDT |
| Account tiles | 2 | 4 | 3 | 4 | 2 |
| Budget ring | ✅ | ✅ multi-cur | ✅ | ✅ | ✅ |
| Goal cards | 2 | 2 | 2 | 2 | 2 |
| Investment section | ❌ | ✅ | ✅ | ✅ | ❌ |
| Remittance tile | ❌ | ✅ inbound | ✅ outbound | ✅ inbound | ❌ |
| Earning widget | "Next salary" | "This week's invoices" | "Next paycheck" | TBD (Q16) | "Next allowance" |

If a Stage 7 integration test runs each persona's path and the dashboard
doesn't render exactly the right elements, the build fails.

---

## Sign-off checklist for Review Gate 2

- [ ] All 5 personas reflect realistic users in their respective markets
- [ ] Per-persona path stats (12-17 screens, 4-7 min) align with §1.4
      success metric targets
- [ ] Phase 8 dashboard contract per persona is accurate
- [ ] New open questions Q12-Q18 are accepted as PRD-resolvable, not
      journey-architectural
- [ ] No persona's walkthrough contradicts the canonical narrative

When all checked, reply **"approved, continue"** and Stage 3 (PRD) starts.
