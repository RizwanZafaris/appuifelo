# Sprint 09 — Tablet Adaptation in `SplitsScreen`

**Severity:** P2 (Responsive design)
**Source audit:** `/audit` 2026-04-29 — Responsive Design finding

## Problem
`SplitsScreen` rendered a tabbed single-column layout at every viewport width. On tablets (≥ 600dp), this wastes horizontal space and forces an unnecessary tap to switch between Active and Settled lists.

## Solution
Wrap the screen body in a `LayoutBuilder` and switch on a `splitsTabletBreakpoint` (600dp):

- **Phone (`< 600dp`):** unchanged — `DefaultTabController` + `TabBar` + `TabBarView` with Active and Settled tabs.
- **Tablet (`≥ 600dp`):** side-by-side `Row` of two `_SplitsPane`s separated by a `VerticalDivider`. Each pane shows its title (`Active` / `Settled`) and the corresponding list. The new-split FAB still floats over both panes.

The breakpoint is exposed as `@visibleForTesting const double splitsTabletBreakpoint = 600` so widget tests pin it.

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** Pure FE layout change.

## Files changed
- `lib/features/splits/presentation/splits_screens.dart` — `SplitsScreen.build` rewritten with `LayoutBuilder`; new `_SplitsPhoneBody`, `_SplitsTabletBody`, `_SplitsPane` widgets; `splitsTabletBreakpoint` constant; explicit `AppLocalizations` import.
- `test/features/splits/splits_layout_test.dart` (new — 3 tests).

## Acceptance criteria
- [x] Phone width renders `TabBar` + `TabBarView` (no `VerticalDivider`).
- [x] Tablet width renders side-by-side panes (no `TabBar`/`TabBarView`).
- [x] Breakpoint exposed for tests at 600dp.
- [x] FAB available in both layouts.
- [x] RTL-safe (`PositionedDirectional` retained; new pane padding uses `EdgeInsetsDirectional`).
- [x] `flutter analyze` clean; 3/3 tests pass.

## Test evidence
```
flutter analyze lib/features/splits/presentation/splits_screens.dart
No issues found!

flutter test test/features/splits/splits_layout_test.dart
+3: All tests passed!
  ✓ phone width (<600dp): tabbed single-column
  ✓ tablet width (≥600dp): side-by-side panes, no TabBar
  ✓ breakpoint constant is 600
```

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: `LayoutBuilder` is the right primitive here (no `MediaQuery` rebuild storms). Phone path is byte-equivalent semantically; only the wrapping moved.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Pure layout change. No deps, secrets, network, storage, or auth surface affected. No new strings (existing `splitsActiveTab` / `splitsSettledTab` reused — en + ur parity preserved).

## Migration notes
None. No persisted state changes. No URL/route changes. Smaller phones are unchanged.

## Follow-ups
- Apply the same breakpoint pattern to `NewSplitScreen` and `SplitDetailScreen` for consistency.
- Consider `splitsLargeTabletBreakpoint` (≥ 900dp) for a 3-pane master-list-detail layout.
- Pull `splitsTabletBreakpoint` out into a shared `lib/core/layout/breakpoints.dart` once a second screen needs it.
