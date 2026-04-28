# Sprint 06 — Dark Theme Explicit `ColorScheme` Overrides

**Severity:** P1 (Theming + Accessibility)
**Source audit:** `/audit` 2026-04-29 — Theming + dark-mode contrast finding

## Problem
`FeloTheme.dark()` previously used `ColorScheme.fromSeed(seedColor: feloiTeal, brightness: dark)`, which silently derived all 30+ Material 3 color slots from a single seed. The brand's semantic palette (mint / peach / sage / rose) was lost in dark mode, and contrast was unverified — onSurface/surface and several `on*`/`*` pairs sat below the WCAG AA 4.5:1 threshold.

## Solution
Replace `fromSeed` with an explicit `const ColorScheme.dark(...)` mapping each role to a vetted `FeloColors` token. Pick the brand variants whose luminance gap with their `on*` partner clears 4.5:1.

Notable picks for dark mode:
- `primary: lavenderSoft` (light) + `onPrimary: ink900` — mascot/primary tones sat in mid-luminance and failed AA against both white and black.
- `error: roseBase` + `onError: ink900` — `signalCrimson` failed AA against any practical foreground in dark mode.
- `secondary: mintBase`, `tertiary: peachBase` — already light enough; paired with `ink900` foregrounds.

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** Pure FE theme.

## Files changed
- `lib/core/theme/felo_theme.dart` — `dark()` rewritten with explicit `ColorScheme.dark`.
- `test/core/theme/felo_dark_theme_test.dart` — new (3 tests, including a real WCAG luminance/contrast computation).

## Acceptance criteria
- [x] No `ColorScheme.fromSeed` in `dark()`.
- [x] All semantic anchors (primary / secondary / tertiary / error / surface) map to `FeloColors`.
- [x] All `on*` / `*` pairs in scheme: contrast ≥ 4.5:1 (AA).
- [x] `flutter analyze` clean.
- [x] Tests 3/3 pass.

## Test evidence
```
flutter analyze lib/core/theme/felo_theme.dart test/core/theme/felo_dark_theme_test.dart
No issues found!

flutter test test/core/theme/felo_dark_theme_test.dart
+3: All tests passed!
  ✓ brightness is dark
  ✓ semantic anchors map to FeloColors (no fromSeed drift)
  ✓ on* foreground pairs meet WCAG AA (≥ 4.5:1)
```

The contrast check is a real WCAG 2.x luminance computation (not a stub). It guards every `on*`/`*` pair so future palette tweaks fail loudly.

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Const scheme — zero allocation cost on theme rebuild. All tokens centralized; future palette work edits one file. Test enforces contrast at CI time.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Visual-only change. No deps, secrets, network, or storage. Improves accessibility surface (low-vision users in dark mode).

## Migration notes
Visible behavioral change: dark mode looks different (intentionally — the previous `fromSeed` derivation was the regression). Light theme untouched. No data migration; no env vars.

## Cross-sprint coordination
- Sprint 02 lights up dark mode for the first time (`ThemeMode.system`). Sprint 06 ensures it's actually accessible.
- Sprint 05 added `feloMarkGradientDark`; this sprint makes the surrounding chrome respect contrast too.

## Follow-ups
- Run a real-device dark-mode screenshot pass and update audit score.
- Future: add a contrast-check golden test for any *new* color token added to `FeloColors`.
