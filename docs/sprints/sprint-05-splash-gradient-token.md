# Sprint 05 — Splash Gradient → `FeloColors.feloMarkGradient`

**Severity:** P1 (Theming consistency)
**Source audit:** `/audit` 2026-04-29 — Theming finding

## Problem
The splash screen's "F" mark inlined a `LinearGradient` with raw color stops (`FeloColors.feloiBlue`, `skyBlue`, `feloiTeal`). Bypasses the design-token system, has no dark-theme variant, and would silently drift if anyone reuses the look elsewhere.

## Solution
Promote the gradient into `FeloColors` as `feloMarkGradient` (light) and `feloMarkGradientDark` (deeper stops for dark background contrast). Splash screen now picks the variant via `Theme.of(context).brightness`.

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** Pure FE design token.

## Files changed
- `lib/core/theme/felo_colors.dart` — added `feloMarkGradient` + `feloMarkGradientDark`.
- `lib/features/onboarding/presentation/splash_screen.dart` — replaces inline gradient with brightness-aware token reference.
- `test/core/theme/felo_mark_gradient_test.dart` — new (2 tests).

## Acceptance criteria
- [x] `FeloColors.feloMarkGradient` and `feloMarkGradientDark` defined as `const LinearGradient`.
- [x] Splash screen consumes the token; no raw color list inline.
- [x] Dark variant has distinct stops and the same direction.
- [x] `flutter analyze` clean; tests 2/2 pass.

## Test evidence
```
flutter analyze lib/core/theme/felo_colors.dart \
  lib/features/onboarding/presentation/splash_screen.dart \
  test/core/theme/felo_mark_gradient_test.dart
No issues found!

flutter test test/core/theme/felo_mark_gradient_test.dart
+2: All tests passed!
```

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: `const` gradients keep splash widget rebuild-cheap. Brightness branch is the standard Flutter idiom; no `MediaQuery` rebuild storm.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Visual constants only. No deps, secrets, network, or storage.

## Migration notes
None. Light variant is byte-identical to the previous inline gradient.

## Follow-ups
- Sprint 06 — Dark-theme `ColorScheme` overrides (will validate dark-mode contrast for the new gradient).
- Audit other inline gradients (e.g. `FeloButton` primary variant) and migrate them.
