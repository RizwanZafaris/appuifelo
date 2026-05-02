# Sprint 04 — `FeloShadows` Token

**Severity:** P1 (Theming consistency)
**Source audit:** `/audit` 2026-04-29 — Anti-Patterns finding (inconsistent shadow opacities)

## Stacked on
This branch builds on `sprint/03-felo-corner-radius` (cleaner diff vs same-file conflicts on FeloCard / FeloButton / FeloScaffold). Land sprint 03 first.

## Problem
Three different shadow opacities (`0.08`, `0.12`, `0.16`) were duplicated across `FeloCard`, `FeloButton`, `FeloScaffold` with hand-tuned blur/offset. Any new component had nothing to reference and would drift the elevation language.

## Solution
Introduce `FeloShadows` with three steps — `sm` (resting), `md` (floating), `lg` (CTA) — exposed as `const List<BoxShadow>` so consumers can keep `const BoxDecoration` and avoid rebuild cost. Tints encode `lavenderMascot` RGB with the documented alpha so values are byte-identical to before.

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** Pure FE token.

## Files changed
- `lib/core/theme/felo_shadows.dart` (new)
- `lib/shared/widgets/felo_card.dart` — `FeloShadows.sm`
- `lib/shared/widgets/felo_button.dart` — `FeloShadows.lg` (primary, enabled-only)
- `lib/shared/widgets/felo_scaffold.dart` — `FeloShadows.md`; dropped now-unused `felo_colors.dart` import
- `test/core/theme/felo_shadows_test.dart` (new — 4 tests)

## Acceptance criteria
- [x] Three named shadow tokens (sm/md/lg) at alpha 0.08/0.12/0.16.
- [x] Each token is a `const List<BoxShadow>` usable in `const BoxDecoration`.
- [x] All previously hardcoded shadow opacities in shared widgets replaced.
- [x] Visual parity: tints are `lavenderMascot` RGB with the same alpha bytes.
- [x] `flutter analyze` clean; tests 4/4 pass.

## Test evidence
```
flutter analyze lib/core/theme/felo_shadows.dart lib/shared/widgets/felo_card.dart \
  lib/shared/widgets/felo_button.dart lib/shared/widgets/felo_scaffold.dart \
  test/core/theme/felo_shadows_test.dart
No issues found!

flutter test test/core/theme/felo_shadows_test.dart
+4: All tests passed!
```

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: `const` lists let `BoxDecoration` upgrade to `const` in `FeloScaffold`. Test asserts RGB+alpha equivalence with `lavenderMascot` — guards against future drift.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Visual constants only. No deps, secrets, network, or storage.

## Migration notes
None. Tints are byte-equivalent to prior `withValues(alpha:)` outputs.

## Follow-ups
- Sprint 07 — focus indicators (will further refactor `FeloButton`/`FeloCard`).
- Audit other components for stray `BoxShadow` literals.
