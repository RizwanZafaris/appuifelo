# Sprint 03 — `FeloCornerRadius` Token

**Severity:** P0 (Theming consistency)
**Source audit:** `/audit` 2026-04-29 — Theming finding

## Problem
Border radii were hardcoded across shared widgets (`BorderRadius.circular(20)` in `FeloCard` & `FeloButton`, `BorderRadius.circular(28)` in `FeloScaffold` x2). New components had no canonical token to reference, drifting the visual system.

## Solution
Introduce `FeloCornerRadius` (`sm=12`, `md=20`, `lg=28`) with both numeric values and prebuilt `BorderRadius` getters (`smAll`, `mdAll`, `lgAll`). Replace all hardcoded radii in shared widgets.

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** Pure FE design token.

## Files changed
- `lib/core/theme/felo_radius.dart` (new)
- `lib/shared/widgets/felo_card.dart` (1 site → `FeloCornerRadius.mdAll`)
- `lib/shared/widgets/felo_button.dart` (1 site + const BoxDecoration → `FeloCornerRadius.mdAll`)
- `lib/shared/widgets/felo_scaffold.dart` (2 sites → `FeloCornerRadius.lgAll`)
- `test/core/theme/felo_radius_test.dart` (new — 3 tests)

## Acceptance criteria
- [x] `FeloCornerRadius` exposes sm=12 / md=20 / lg=28.
- [x] Prebuilt `BorderRadius` getters (constants) for use in `const` decorations.
- [x] All hardcoded radii in `felo_card.dart`, `felo_button.dart`, `felo_scaffold.dart` replaced.
- [x] `flutter analyze` clean on changed files.
- [x] Token tests pass (3/3).

## Test evidence
```
flutter analyze lib/core/theme/felo_radius.dart lib/shared/widgets/felo_card.dart \
  lib/shared/widgets/felo_button.dart lib/shared/widgets/felo_scaffold.dart \
  test/core/theme/felo_radius_test.dart
No issues found!

flutter test test/core/theme/felo_radius_test.dart
+3: All tests passed!
```

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: `const` getters preserved through call sites; ghost variant `BoxDecoration` upgraded to `const` to satisfy `prefer_const_constructors`. Public API unchanged.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Pure visual constants. No deps, secrets, auth, RLS, network, or storage surface changed.

## Migration notes
None. Visual values are byte-identical to prior hardcoded literals (12/20/28).

## Follow-ups
- Sprint 04 — `FeloShadows` token (will touch the same widget files; coordinate landing order with this sprint).
- Audit other widgets for stray `BorderRadius.circular(...)` calls (chips, sheets, inputs).
