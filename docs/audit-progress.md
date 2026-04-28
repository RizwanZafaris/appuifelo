# Audit Remediation — Progress Tracker

**Source audit:** `/audit` 2026-04-29 — initial score **14.5 / 20** (Good)
**Backlog:** `docs/sprint-orchestration-prompt.md` (15-sprint plan)
**Cloud routine:** `trig_01545XGiYc59gS8TRDvQ2XeW` — fires daily at 3:30 AM Asia/Karachi

## Sprint status

| # | Severity | Title | Branch | PR | Tests | Doc |
|---|----------|-------|--------|----|-------|-----|
| 01 | P0 | Touch target 44 → 48dp | `sprint/01-touch-target-48dp` | open | 2/2 ✅ | [doc](sprints/sprint-01-touch-target-48dp.md) |
| 02 | P0 | ThemeMode.system + persisted override (FE+BE) | `sprint/02-thememode-system` (FE) + `sprint/02-user-theme-preference` (BE) | open | 3/3 ✅ + 3/3 ✅ | [doc](sprints/sprint-02-thememode-system.md) |
| 03 | P0 | FeloCornerRadius token | `sprint/03-felo-corner-radius` | open | 3/3 ✅ | [doc](sprints/sprint-03-felo-corner-radius.md) |
| 04 | P1 | FeloShadows token (stacked on 03) | `sprint/04-felo-shadows` | open | 4/4 ✅ | [doc](sprints/sprint-04-felo-shadows.md) |
| 05 | P1 | Splash gradient → FeloColors | `sprint/05-splash-gradient-token` | open | 2/2 ✅ | [doc](sprints/sprint-05-splash-gradient-token.md) |
| 06 | P1 | Dark theme explicit ColorScheme | `sprint/06-dark-theme-overrides` | open | 3/3 ✅ | [doc](sprints/sprint-06-dark-theme-overrides.md) |
| 07 | P1 | Keyboard focus indicators (stacked on 04) | `sprint/07-keyboard-focus-indicators` | open | 4/4 ✅ | [doc](sprints/sprint-07-keyboard-focus-indicators.md) |
| 08 | P2 | FeloInput semantic error announcements | `sprint/08-felo-input-semantic-errors` | open | 5/5 ✅ | [doc](sprints/sprint-08-felo-input-semantic-errors.md) |
| 09 | P2 | Tablet adaptation in splits screen | `sprint/09-tablet-splits-layout` | open | 3/3 ✅ | [doc](sprints/sprint-09-tablet-splits-layout.md) |
| 10 | P2 | textScaleFactor in FeloButton height | — | not started | — | — |
| 11 | P2 | Riverpod .select() + lazy tab loading (FE+BE) | — | not started | — | — |
| 12 | P2 | precacheImage + ImageCache tuning | — | not started | — | — |
| 13 | P3 | Replace raw EdgeInsets with FeloSpacing | — | not started | — | — |
| 14 | P3 | Empty-state shimmer | — | not started | — | — |
| 15 | P3 | Final polish pass | — | not started | — | — |

## Merge-conflict matrix (as of 2026-04-29)

All branches merge cleanly to current `main`:

| Branch | merges to main? |
|---|---|
| sprint/01-touch-target-48dp | ✅ clean |
| sprint/02-thememode-system | ✅ clean |
| sprint/03-felo-corner-radius | ✅ clean |
| sprint/04-felo-shadows | ✅ clean (stacked on 03) |
| sprint/05-splash-gradient-token | ✅ clean |
| sprint/06-dark-theme-overrides | ✅ clean |
| sprint/07-keyboard-focus-indicators | ✅ clean (stacked on 04) |
| sprint/08-felo-input-semantic-errors | ✅ clean |
| sprint/09-tablet-splits-layout | ✅ clean |

**Stacking note:** Sprint 04 contains commits from 03; sprint 07 contains commits from 03+04. Recommended land order:

```
01 → 02 → 03 → 04 → 07   (these touch widget files; rebase when each lands)
05 → 06 → 08 → 09         (independent — any order)
```

After 03 lands, branches 04 and 07 must rebase. After 04 lands, branch 07 must rebase.

## Open tech-debt items (out of audit scope, deferred)

These were observed during the audit and sprint work but are **not** in the 15-sprint backlog. Open as separate sprints when prioritized.

### TD-1 — Pre-existing analyzer infos (58 issues)
- 58 `info`-level analyzer hints exist in files outside the audit scope, mostly in `lib/features/onboarding_v2/**` (avoid_dynamic_calls, use_build_context_synchronously, curly_braces_in_flow_control_structures, prefer_single_quotes, unnecessary_underscores).
- **Impact:** none today; risks future drift.
- **Suggested sprint:** "TD-1 — analyzer-cleanup-onboarding-v2" — flat tidy pass; one PR per file or one PR for the whole feature.

### TD-2 — Outdated dependencies (46 packages)
- 46 packages have newer versions incompatible with current constraints; 1 discontinued.
- **Impact:** drift / future CVE exposure.
- **Suggested approach:** dedicated `chore/deps-q2` sprint with full regression run. **Do not** roll into a UX sprint — too risky.

### TD-3 — Flutter SDK deprecations
- Sprint 08 introduced 3 `info`-level deprecations (`SemanticsService.announce`, `SemanticsFlag.hasFlag`) targeting Flutter 3.35+ APIs not yet in our SDK channel.
- **Impact:** zero today; will become warnings on SDK upgrade.
- **Suggested sprint:** roll into TD-2 or a dedicated SDK-bump sprint.

### TD-4 — `gh` CLI unauthenticated locally
- 9 sprint PRs require manual creation via the `pull/new/...` GitHub URL.
- **Impact:** human friction in PR creation.
- **Fix:** `gh auth login` once on the dev machine. **Out-of-band — not a sprint.**

### TD-5 — Cloud routine repo access
- Routine `trig_01545XGiYc59gS8TRDvQ2XeW` was auto-disabled with `ended_reason: "auto_disabled_repo_access"` after `appbackendfelo` was added as a second source.
- **Fix:** grant the GitHub MCP connector access to both repos at https://claude.ai/customize/connectors and re-enable the routine.

### TD-6 — Audit follow-ups embedded in sprint docs
Each sprint's `Follow-ups` section enumerates next-step ideas. Quick consolidation:

- **Sprint 01:** apply `FeloSpacing.minTapTarget` to `FeloButton`/`FeloCard`/`FeloChip`/IconButtons to actually realize the WCAG benefit.
- **Sprint 02:** add a settings UI to expose theme toggle; consider boot-time secure-storage cache to eliminate default-system flash.
- **Sprint 03:** audit `FeloChip`, sheets, inputs for stray `BorderRadius.circular(...)`.
- **Sprint 04:** audit other widgets for stray `BoxShadow` literals.
- **Sprint 05:** migrate `FeloButton` primary-variant inline gradient to a token.
- **Sprint 06:** add a contrast-check golden test for any new color in `FeloColors`.
- **Sprint 07:** apply focus pattern to `FeloChip`, `FeloInput`, `FeloBottomSheet`.
- **Sprint 08:** pass `required: true` at form sites; migrate to `sendAnnouncement` post-SDK-upgrade.
- **Sprint 09:** apply 600dp pattern to `NewSplitScreen`, `SplitDetailScreen`; extract `splitsTabletBreakpoint` to a shared `lib/core/layout/breakpoints.dart`.

## Score projection (post-merge)

Once all 9 open PRs land, audit dimensions should improve:

| Dimension | Before | After (projected) | Driver |
|---|---|---|---|
| Accessibility | 2.5 | 3.5 | Sprints 01, 02, 06, 07, 08 |
| Performance | 3.5 | 3.5 | Unchanged (sprints 11, 12 still pending) |
| Theming | 3.0 | 4.0 | Sprints 03, 04, 05, 06 |
| Responsive | 3.0 | 3.5 | Sprint 09 (sprint 10 still pending) |
| Anti-Patterns | 2.5 | 3.5 | Sprints 04, 05 |
| **Total** | **14.5** | **18.0** | **Excellent band** |

Re-run `/audit` after the merge wave to confirm.
