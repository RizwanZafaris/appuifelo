# Felo Onboarding — User Journey Explained

> **Canonical narrative.** This document is the source of truth for what the
> user experiences. The PRD, FRDs, system design, and code must all serve
> this journey — not the other way around.
>
> **Provenance:** Provided by product owner (Rizwan Zafar) at Stage 0,
> 2026-04-26. Verbatim — do not edit without an explicit decision log entry.

---

## The Big Picture

A new user opens FELO for the first time. By the time they leave onboarding
(5-7 minutes later), three things must be true:

1. They feel FELO understands them — their country, their currency, their
   banks, their goals.
2. Their dashboard is already configured for their specific situation. No
   empty states, no generic placeholders.
3. They know what FELO is for and why it's different from their bank's app.

If any of these three fail, onboarding failed — even if the user clicked
through every screen.

---

## The Journey in Plain English

### Phase 1 — "Who are you?"

The user lands on a welcome screen, decides FELO looks worth trying, and
creates an account. They pick how to sign up — Google, Apple, Facebook,
email, or mobile number. If they choose email or mobile, they verify with
a 6-digit code. If they choose Google/Apple/Facebook, they're verified
instantly through OAuth.

**Why this order:** Identity comes first because every subsequent answer
gets attached to a user record. Without auth, we can't persist anything,
can't analyze drop-off per user, can't resume mid-flow.

**What the user feels:** "Standard sign-up, nothing weird, takes 30 seconds."

### Phase 2 — "Where are you?"

FELO auto-detects the user's country from their IP address and shows it
pre-selected: "Pakistan — PKR." The user confirms or picks a different
region. If they have ties to other countries (a Pakistani in Toronto, an
Indian in Dubai), they tap "+ Add another region" and add those too.

Then we ask their name — pre-filled from OAuth if available.

**Why this order:** Region is the biggest personalization lever in the
entire app. It determines currency, which banks we show next, which
remittance corridors apply, and which regulatory copy we surface. We need
this BEFORE the financial questions or the banks list will be wrong.

**What the user feels:** "It already knows where I am — that's nice. And it
knows my name."

### Phase 3 — "Can we help you?"

We ask for permissions, but we explain WHY for each one. SMS access is the
big one — we tell them, "If you let us read your bank SMS, we'll auto-track
every transaction. You'll never type a number." We also ask for
notifications, and optionally location and contacts. Each permission is
independently skippable. Skipping does not block onboarding.

**Why this order:** Permissions come AFTER region but BEFORE financial data
because (a) the SMS pitch makes more sense once they know we're serious
about their market, and (b) we want the permission grant to happen before
they invest effort in setup — if they bail, at least we have permissions
for next time.

**What the user feels:** "They're being upfront about what they want and
why. I trust this more than apps that just demand everything."

### Phase 4 — "How do you make and hold money?"

Three sub-questions:

First, **"How do you earn?"** — multi-select: Salaried, Freelancer, Business
owner, Investor, Finance professional, Student, Homemaker, Other. Multiple
selections allowed because real life is hybrid (a salaried person who
freelances on weekends).

Second, **"Your accounts"** — we show banks and wallets relevant to their
region. They tap the ones they use. Multi-select pills.

Third, **"Do you invest?"** — Yes/No. If yes, **"What in?"** Stocks, Mutual
Funds, Crypto, Gold, Real Estate, Bonds/Sukuk, Other. If no, we skip the
investment question entirely.

**Why this order:** Earning type drives budget defaults in the next phase.
Account selection populates the dashboard's account tiles. Investment
selection determines whether the dashboard has an investments section at
all. We're building the dashboard's skeleton in real time as the user
answers.

**What the user feels:** "These are the right questions. They're asking
like a real financial advisor would, not like a form."

### Phase 5 — "What are you trying to do?"

This phase is where FELO earns the user's trust. Two sub-steps:

First, **"Set your monthly budget."** We pre-fill suggested amounts based on
their region and earning type. They adjust the total at the top, and we
show categories underneath: Food, Transport, Rent, Shopping, Entertainment,
Health, Education, Savings. They can zero out anything that doesn't apply
(a student doesn't need a rent category if they live with parents).

Second, **"What are you working toward?"** They pick EXACTLY 2 goals — not
three, not five, exactly two. Options: Buy a home, Buy a vehicle, Education
fund, Travel, Wedding, Family planning, Retirement, Build wealth, Emergency
fund, Hajj/Umrah, Custom. For each goal, they tell us the target amount and
target date. We calculate the required monthly savings automatically.

If their goals require more savings than their budget allows, we show a
soft warning: "You'd need to save ₨15,000/month to hit this — your budget
allows ₨10,000. Adjust?" with a link back to the budget step.

**Why the 2-goal limit:** Three reasons. (1) Decision focus — research shows
users with 2 goals achieve them at higher rates than users with 5. (2)
Dashboard real estate — two goals fit beautifully as hero cards; five
become a cluttered list. (3) Product strategy — unlimited goals will be a
premium feature later. Saying "exactly 2" now sets up the upsell organically.

**Why this order:** Budget before goals because budget defines what's
financially possible. If we asked goals first, users would set unrealistic
targets, then we'd have to tell them their budget can't support those goals
— a worse experience than the reverse.

**What the user feels:** "Wait, this is actually useful. It's making me
think about my money in a way my bank app never has."

### Phase 6 — "Do you move money across borders?"

Conditional phase. Two sub-questions, but only shown if relevant.

First, **"Family & remittances"** — multi-select: I send money to family
regularly / I receive money from abroad / I support family members
financially / I manage shared household expenses / None of the above.

Second, **"Where to/from?"** — only shown if the first answer indicates
cross-border activity. Two pill groups: "Send to" countries and "Receive
from" countries. Pre-selected based on Phase 2 region choices.

**Logic:**

- A user whose primary region is Pakistan with no secondary regions and who
  picks "None of the above" in 6.1 → we **skip 6.2 entirely**. Why ask
  about a Canada→Pakistan corridor for a user who lives in Karachi and
  sends money to no one?
- A user whose primary region is Canada and secondary is Pakistan → we
  pre-select "Send to: Pakistan" because that's almost certainly what
  they're doing.
- A user whose primary region is Pakistan and secondary is UAE → we
  pre-select "Receive from: UAE" because they likely have family sending
  money home.

**Why this order:** Remittance comes after intent (budget/goals) because
it's the LEAST universal phase. Most domestic-only users don't need it.
Putting it last means those users get the bulk of the benefit before a
phase they might skip.

**What the user feels:** Two outcomes depending on user type:

- **Domestic-only Pakistani:** doesn't see this phase at all. "Smooth, it
  didn't waste my time."
- **Diaspora user:** "It already figured out my Canada-to-Pakistan
  corridor. I didn't even have to tell it."

### Phase 7 — "We're building it for you"

A full-screen loading state. Status messages appear one at a time, each
with a green check when complete:

```
"Setting up your PKR account..."                       ✓
"Linking Pakistan's banks..."                          ✓
"Building your budget for ₨80,000..."                  ✓
"Tracking your Hajj fund and home down payment..."     ✓
"Connecting your UAE → Pakistan corridor..."           ✓
"Personalizing your dashboard, Rizwan..."              ✓
```

Three to five seconds total.

**Why this phase exists:** This is the emotional payoff. Every status
message references something the user actually told us. They watch their
inputs become a real product. A generic "Setting up your account..." would
feel like wasted time. "Tracking your Hajj fund and home down payment"
feels like FELO listened.

Behind the scenes, this isn't theater — we're actually doing real work:
building the user_profile object, computing the dashboard configuration,
fetching FX rates if remittance corridors are set, fetching market data if
investments are selected, inserting initial budget categories and goals
into the database.

**What the user feels:** "Okay, this is different. It's not just another
finance app — it actually built something for me."

### Phase 8 — "Here's your FELO"

The user lands on the dashboard. It's already configured:

- Greeting uses their name
- Currency matches their region
- Account tiles for each bank/wallet they selected (each shows "Connect"
  — actual bank linking happens post-onboarding)
- Budget ring showing their total monthly budget
- Two hero cards for their two goals with progress rings (at 0% initially,
  but visually committed)
- Investment widgets only if they said they invest
- Remittance tile only if they have cross-border corridors
- A widget tailored to their earning type (e.g., "Days until next salary"
  for salaried users)

A small one-time tooltip introduces the first action: "Connect your first
account to start tracking."

**Why this phase exists:** This is the onboarding success criterion. If the
dashboard looks generic, all 7 prior phases failed. Every onboarding answer
must visibly show up here.

**What the user feels:** "Oh — it's already mine. I haven't even done
anything yet and it already looks like my financial life."

---

## Journey Variations by Persona

Not every user takes the same path. Here's how the journey adapts:

### Salaried Saadia (Karachi, single bank, no investments, sends to parents)

- All 8 phases
- Phase 4: picks "Salaried", picks HBL only, picks "No" on invest
- Phase 5: budget pre-filled for salaried Pakistani context, 2 goals chosen
- Phase 6: picks "I send money to family" → no corridor needed (domestic)
- **Total:** ~5 minutes, ~14 screens

### Freelancer Faisal (Lahore, irregular income, multiple wallets, crypto)

- All 8 phases
- Phase 4: picks "Freelancer" + "Investor", picks JazzCash + SadaPay +
  Wise, picks "Yes" on invest, picks Crypto + Stocks
- Phase 5: budget pre-filled for irregular income (savings emphasis), 2
  goals
- Phase 6: picks "I receive money from abroad", corridor Pakistan←USA via
  Wise
- **Total:** ~7 minutes, ~17 screens

### Diaspora Daniyal (Toronto, sends to family in Pakistan)

- Phase 2: primary Canada, secondary Pakistan
- Phase 4: Canadian banks shown
- Phase 6: pre-filled "Send to: Pakistan"
- Dashboard heavily features remittance tile
- **Total:** ~6 minutes, ~15 screens

### Student Sana (Dhaka, JazzCash + small bank, no investments, no remittance)

- Phase 4: picks "Student", picks JazzCash, picks "No" on invest
- Phase 5: budget pre-filled small (student context), 2 goals (likely
  Travel + Education fund)
- Phase 6: picks "None of the above" → skip corridor entirely
- **Total:** ~4 minutes, ~12 screens (shortest path)

---

## Drop-Off Risk Map

Where users are most likely to abandon, and why:

| Phase | Expected drop | Mitigation |
|---|---|---|
| 1 — Identity | 5-15% | Strong welcome screen value prop |
| 3 — Permissions | 10-20% if SMS framing is weak | Explicit "you'll never type a number again" copy |
| 4.2 — Accounts | 5-10% if list is overwhelming | Region-filtered list, search, "I'll add later" link |
| **5.2 — Goals** | **HIGHEST RISK** | Visually rich card grid, 2-goal limit (not "up to 2"), required-field clarity |
| 6 — Remittance | Low (optional + skippable) | — |
| 7 — Loading | Near-zero, but watch for backgrounding | Keep it under 5 seconds |

If the funnel shows higher drop than these targets, the journey needs
revision, not just copy tweaks.

---

## Design Principles Underlying the Journey

1. **Every answer matters.** If we ask, the answer must change something
   downstream. No vanity questions.
2. **Progressive disclosure.** We ask for trust before financial detail,
   region before banks, banks before investments, budget before goals. Each
   phase earns the right to ask the next.
3. **Skip-friendly where possible.** Permissions, accounts, investments,
   remittance — all skippable. We never block onboarding on optional data.
4. **Conditional > linear.** The journey adapts. A Pakistan-only domestic
   user takes 12 screens; a diaspora investor with cross-border activity
   takes 17. Both feel right for their context.
5. **The loading screen is product, not polish.** Phase 7 is the most
   important screen in the entire app. It's where the user decides whether
   FELO is "another finance app" or "the one that gets it."
6. **The dashboard is the test.** If a user finishes onboarding and the
   dashboard looks generic, the journey failed regardless of completion rate.

---

## What Implementation Must Remember

When building this:

- The 2-goal limit is a **hard product constraint**, not a soft suggestion.
- Phase 7's status messages must reference the user's **actual** inputs, not
  generic strings.
- Phase 6 must skip cleanly for domestic-only users — don't show empty
  corridor screens.
- Region selection in Phase 2 must filter the bank list in Phase 4.2. If a
  user changes region after selecting banks, prompt them to re-select.
- Every screen must persist state immediately on Continue. Closing the app
  and reopening should resume at the last completed step.
- The dashboard handoff is the success criterion. Every onboarding input
  must visibly show up on the dashboard for this build to count as done.
