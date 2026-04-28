# Sprint 01 — Touch Target 44 → 48dp

**Severity:** P0 (WCAG 2.1 AA violation)
**Source audit:** `/audit` 2026-04-29 — Accessibility dimension finding #1

## Problem
`FeloSpacing.minTapTarget` was set to `44`, below the WCAG 2.1 AA minimum of 48dp for interactive touch targets. This affects all current and future call sites that rely on the design token to enforce minimum tappable area.

## Solution
Updated `FeloSpacing.minTapTarget` from `44` to `48` in `lib/core/theme/felo_spacing.dart`. No call sites currently reference the token (verified via grep), so the change is value-only and non-breaking.

## Repos touched
- `appuifelo` (FE-only)
- `appbackendfelo` — **BE: not applicable.** Reason: pure FE design token; no backend contract change.

## Files changed
- `lib/core/theme/felo_spacing.dart` (1 line)
- `test/core/theme/felo_spacing_test.dart` (new, 2 tests)

## Acceptance criteria
- [x] `FeloSpacing.minTapTarget == 48`
- [x] All consumers compile (no current call sites)
- [x] `flutter analyze` introduces no new issues (58 pre-existing infos unchanged)
- [x] Token-value test added and passes

## Test evidence
```
flutter analyze  → 58 issues (pre-existing in unrelated files; no new issues from this diff)
flutter test test/core/theme/felo_spacing_test.dart
00:00 +2: All tests passed!
```

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: One-line numeric change to a design token. No architecture, state-management, or API impact.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: No secrets, no auth changes, no dependency diff, no PII surface. Zero security impact.

## Migration notes
None. Value-only change to an unreferenced token.

## Follow-ups
- Sprint 02 — `ThemeMode.system` with persisted user override
- Future sprints should apply `FeloSpacing.minTapTarget` to `FeloButton`, `FeloCard`, `FeloChip`, and any tappable IconButton wrappers to actually realize the WCAG benefit.
