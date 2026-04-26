# Stage 4 — System Design

> 🟡 **Pending Review Gate 3 approval.** Will be filled at Stage 4 (alongside FRD).

Target file: `system-design.md` covering:

1. Architecture diagram (mermaid): Flutter ↔ NestJS ↔ Supabase
2. Data flow per phase
3. Postgres schema (additive — extends existing 5-migration chain):
   - `regions`, `banks`, `wallets`, `currencies`, `goal_templates` (reference, seeded)
   - `onboarding_sessions` (resume state)
   - `permissions`, `earning_types`, `user_accounts`, `user_investments`
   - `remittance_preferences`, `goals`, `budgets`, `budget_categories`
   - `events`, `funnel_sessions` (analytics traceability)
4. RLS policies (every read/write scoped to `auth.uid()`)
5. NestJS controllers + Supabase admin client (per Decision D-003)
6. SMS verification: pluggable corridor-keyed adapter (per Decision D-005)
7. IP-to-region resolution: NestJS controller calling ip-api/ipinfo
8. Analytics event emitter contract — every event carries its FR ID
