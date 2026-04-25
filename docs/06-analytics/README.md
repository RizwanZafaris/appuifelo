# Stage 6 — Analytics Funnel

> 🟡 **Pending Review Gate 5 approval.** Will be filled at Stage 6 — **before any code in Stage 7**.

Target output:

- `event-taxonomy.md` — full event catalog with FR links
- `funnel-queries.sql` — drop-off, conversion, cohort, time-to-complete
- `instrumentation-contract.md` — `screenAnalytics` mixin spec

The traceability rule is absolute: every event carries its FR ID. The
mixin makes this automatic — the developer cannot forget.

Standard event names per screen:

```
{phase}_{step}_viewed
{phase}_{step}_completed
{phase}_{step}_skipped       (if skippable)
{phase}_{step}_back          (if user pressed back)
{phase}_{step}_validation_error  (if applicable)
```

Properties always include: `frd_id`, `step_id`, `phase`, `session_id`,
`user_id`, `timestamp`. Phase-specific properties are documented per FR.
