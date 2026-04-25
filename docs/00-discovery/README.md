# Stage 1 — Discovery

> 🟢 **Canonical narrative landed at Stage 0.** See
> [`user-journey-as-told.md`](./user-journey-as-told.md) — that document is
> the source of truth for what the user experiences. The Stage 1 discovery
> doc *complements* it with market analysis, hypotheses, success metrics,
> and open questions; it must not contradict it.
>
> 🟡 Stage 1 deliverable (`discovery.md`) is **pending Review Gate 0 approval**.

## Inputs already in this folder

| File | Provenance | Role |
|---|---|---|
| `user-journey-as-told.md` | Product owner, Stage 0 | Canonical narrative — what the user experiences phase-by-phase |
| `discovery.md` *(TBD)* | Stage 1 | Market context, hypotheses, success metrics targets, non-goals, open questions |

## Stage 1 deliverable scope (`discovery.md`)

When Stage 1 starts, that doc covers:

1. **Problem statement** — what FELO solves; reference the canonical
   narrative's "three things must be true" success criteria
2. **Market context** — primary markets (PK/IN/BD/NP/LK), corridors
   (UAE/CA/UK/US/SA), competitor analysis (Mint-style apps don't work in
   South Asia; bank apps are siloed; remittance apps don't budget), why
   SMS-parsing is FELO's unique unlock
3. **Onboarding hypotheses** — 8-12 testable hypotheses with measurable
   signals. Each must trace to a Stage 6 analytics event. Examples:
   - H1: Users with IP-pre-detected region complete Phase 2 ≥95% (vs ≥75%
     for manual region pickers)
   - H2: Users who set 2 goals during onboarding have 3× higher D30
     retention than users who skip goals
   - H3: SMS permission grant rate ≥75% when "you'll never type a number"
     copy is shown (vs ≥40% for generic copy)
   - …
4. **Success metrics** — north star (% of installs reaching Dashboard
   Reveal Phase 8) + per-step funnel targets aligned to drop-off risk
   table in the canonical narrative
5. **Non-goals for v1** — bank API integration, real money movement,
   crypto trading, investment advice, multi-language UI
6. **Open questions** — to be resolved before PRD lock at Review Gate 2

## How Stage 1 stays consistent with the narrative

- Every hypothesis must map to a behavior the narrative describes
- Every success metric must align with the narrative's drop-off risk table
- Non-goals must not conflict with anything the narrative claims FELO does
- Open questions are the *unresolved* gaps in the narrative — not contradictions
