# Felo — Documentation

Staged execution model for the **8-phase onboarding journey** (`onboarding_v2`).
Lives alongside the production app (`lib/features/onboarding/` is the legacy
flow, kept behind a feature flag during rollout).

## Folder map

| Folder | Stage | What lives here |
|---|---|---|
| `00-discovery/` | 1 | Problem statement, market context, hypotheses, success metrics, non-goals, open questions |
| `01-personas/` | 2 | 5 onboarding personas walked through the 8-phase journey |
| `02-prd/` | 3 | Product requirements: 8 phases with conditional logic, global rules, acceptance criteria |
| `03-frd/` | 4 | Functional requirements (FR-X.Y.Z), each linked to PRD section + analytics events |
| `04-system-design/` | 4 | Architecture, data flow per phase, schema, RLS, edge functions |
| `05-epics-sprints/` | 5 | Epics (E1-E9), Sprint 1 stories, Definition of Done |
| `06-analytics/` | 6 | Event taxonomy, funnel queries, instrumentation contract |
| `decision-log.md` | all | Every non-trivial decision with date + rationale |

## Stage gates (do not skip)

```
Stage 0 → Review Gate 0 → wait for "approved, continue"
Stage 1 → Review Gate 1 → wait for "approved, continue"
...
Stage 7 → Review Gate 7 → wait for "approved, ship"
```

## Architecture decisions (locked in at Stage 0)

| Decision | Choice | Why |
|---|---|---|
| Repo strategy | **Side-by-side** (`lib/features/onboarding_v2/`) | Preserves yesterday's wire-through; legacy `onboarding/` stays alive behind a flag during cutover |
| Backend layer | **NestJS controllers** route onboarding writes | Architecturally consistent with the 9 already-wired domains; Supabase admin client is called server-side, not from Flutter |
| SMS verification | **Pluggable corridor-keyed adapter** (PK/IN/BD/NP/LK/AE/CA/UK/US/SA each route through their best local vendor) | Compliance + cost + deliverability vary wildly by corridor; one provider doesn't fit |
| i18n on new screens | **EN-only in v1** (deviation from existing 432-key EN+UR ARB) | Per brief; tracked as known debt — Urdu coverage in a follow-up |
| Migration strategy | **Additive** — `006_onboarding_v2.sql` extends existing 5-migration chain | Zero risk to live data; new tables only, no rewrites of `profiles` etc. |

See [`decision-log.md`](./decision-log.md) for the full ledger.

## Companion docs (Obsidian vault)

The `/Volumes/T7 Shield/felo_idea/02_Engineering/` vault has the project-wide
build status:

- `FELO_Live_Project_Status.md` — master status doc
- `FELO_Flutter_Implementation_Status.md` — coverage matrix
- `FELO_Backend_Build_Spec.md` — backend architecture
- `FELO_Wire_Through_Audit_2026-04-25.md` — yesterday's wire-through retrospective

This `docs/` folder is the **onboarding-v2 specific** spec; the Obsidian vault
covers the broader product.
