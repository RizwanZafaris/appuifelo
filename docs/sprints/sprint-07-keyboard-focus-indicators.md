# Sprint 07 — Keyboard Focus Indicators on `FeloButton` & `FeloCard`

**Severity:** P1 (Accessibility)
**Source audit:** `/audit` 2026-04-29 — Accessibility finding (no visible focus state for keyboard users)

## Stacked on
This branch builds on `sprint/04-felo-shadows` (which itself stacks on `sprint/03-felo-corner-radius`). Both predecessors must land before this one. Cleaner-diff alternative considered: `FocusableActionDetector` direct-wrap. Rejected — `InkWell.onFocusChange` is already in the widget tree, hooking it requires no new wrapper and preserves `const` constructors.

## Problem
Keyboard users (assistive tech, external Bluetooth keyboards on iPad/Android, web builds) had no visible indicator of which `FeloButton` or `FeloCard` was focused. This is a WCAG 2.1 AA failure (2.4.7 Focus Visible).

## Solution
Convert `FeloButton` and `FeloCard` to `StatefulWidget` and track `_focused` via `InkWell.onFocusChange`. When focused, render a 2dp `Border.all(color: colorScheme.primary)` on the visible decoration:

- **FeloCard:** border on the inner `DecoratedBox`.
- **FeloButton:** border on the `Ink.decoration` (across all three variants — primary / secondary / ghost).

Both widgets also set `focusColor: colorScheme.primary.withValues(alpha: 0.08)` so Flutter's built-in focus highlight respects brand color even when the explicit border isn't yet painted.

The border tracks `colorScheme.primary` so it adapts cleanly between light + dark themes (sprints 02 + 06).

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** Pure FE accessibility upgrade.

## Files changed
- `lib/shared/widgets/felo_card.dart` — Stateful conversion, focus tracking, border on focus.
- `lib/shared/widgets/felo_button.dart` — Stateful conversion, focus tracking, border on focus across all variants.
- `test/shared/widgets/focus_indicators_test.dart` (new — 4 widget tests).

## Acceptance criteria
- [x] `FeloButton` shows a brand-colored border when focused; clears when unfocused.
- [x] `FeloCard` (tappable) shows a brand-colored border when focused.
- [x] Non-tappable `FeloCard` is not focus-traversable (no `InkWell`).
- [x] Both widgets wire `onFocusChange` and `focusColor` on the underlying `InkWell`.
- [x] Public API of both widgets unchanged.
- [x] `flutter analyze` clean.
- [x] Tests 4/4 pass.

## Test evidence
```
flutter analyze lib/shared/widgets/felo_button.dart lib/shared/widgets/felo_card.dart \
  test/shared/widgets/focus_indicators_test.dart
No issues found!

flutter test test/shared/widgets/focus_indicators_test.dart
+4: All tests passed!
  ✓ FeloButton wires onFocusChange + focusColor on InkWell
  ✓ FeloButton focus event renders a focus border
  ✓ FeloCard non-tappable card has no InkWell and no border
  ✓ FeloCard tappable card wires focus + renders border on focus
```

The tests drive `InkWell.onFocusChange` directly rather than Flutter's full Tab-traversal pipeline. This isolates the contract we own (border response to focus events) from the framework's traversal machinery, which is already covered by Flutter's own tests and varies subtly across Flutter versions.

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Stateful conversion is minimal and necessary. Border uses theme tokens (`colorScheme.primary`) so it inherits dark-mode work from sprint 06. Public API stable — drop-in replacement.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: No deps added, no `pubspec.lock` change. No network, storage, secrets, or auth surface touched. Strictly improves accessibility posture.

## Migration notes
None. Behavioral change is additive (focus indicator now appears where it was previously invisible). No persisted state changes.

## Cross-sprint coordination
- Land order: sprint 03 → sprint 04 → **sprint 07**.
- Pairs well with sprint 02 (system theme mode) and sprint 06 (dark theme overrides) — focus indicator now adapts to whichever theme the user has selected.

## Follow-ups
- Apply the same focus-indicator pattern to `FeloChip`, `FeloInput`, and `FeloBottomSheet` when their respective sprints come up.
- Consider a dedicated `FeloFocusBorder` widget if a fourth surface needs the same treatment, to centralize the border-color/width tokens.
