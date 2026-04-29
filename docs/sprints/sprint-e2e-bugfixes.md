# Sprint — E2E Test Pass: Bug Fixes

**Severity:** P0 (prod) + P1 (test) + P2 (test) — found via end-to-end test pass on merged `main` @ `8c575f3`.

## Problem
Running `flutter test` against post-merge `main` surfaced **8 failures**. Investigation classified them into 3 actual issues + 4 pre-existing tech-debt items unrelated to sprint work.

## Bugs fixed (3)

### Bug 1 — `IntegerDivisionByZeroException` in `NewSplitScreen` (P0 prod)
**File:** `lib/features/splits/presentation/splits_screens.dart:547`
**Cause:** `_draftParticipants(int totalMinor)` does `totalMinor ~/ _participants.length`. `_participants` is initialized empty in `_NewSplitScreenState` — first build crashes the whole screen.
**Fix:** Early-return `const <SplitParticipantDraft>[]` when `_participants.isEmpty` (matches the existing guard in `_applyEqualShares`).
**User-visible impact:** New Split screen would have crashed for every user on first open until they added a participant. Real prod bug.

### Bug 2 — `widget_test.dart` missing `ProviderScope` (P1 test)
**File:** `test/widget_test.dart`
**Cause:** Sprint 02 converted `FeloApp` to a `ConsumerWidget`. The pre-existing top-level smoke test wrapped `FeloApp` directly without `ProviderScope`, so any `ref.watch` threw `Bad state: No ProviderScope found`.
**Fix:** Wrap with `const ProviderScope(child: FeloApp())` — matches the production tree in `main.dart`.

### Bug 3 — Stale golden images (P2 test)
**Files:** `test/golden/goldens/felo_shared_components.png`, `test/golden/goldens/notifications_components.png`
**Cause:** Sprints 03 (corner radius), 04 (shadows), and 07 (focus indicators) changed widget visuals slightly (≤ 0.01% pixel diff). Goldens were captured before those sprints.
**Fix:** Regenerated via `flutter test --update-goldens test/golden/`. Both PNGs grew by ~10–25 bytes.

## Pre-existing failures (4) — NOT fixed in this sprint

Confirmed by checking out the test files at `main` pre-merge (commit `9cda4b2`) — same 4 failures occurred. These are stale fake-data fixtures, not regressions:

| File | Failure | Likely cause |
|------|---------|--------------|
| `test/widget/onboarding_flow_test.dart` | "onboarding reaches the auth screen" | Flow text drift |
| `test/widget/investments_test.dart` | Looking for "Total market value" — 0 found | Fake-data fixture renamed |
| `test/widget/mfa_test.dart` | "mfa setup verifies and shows recovery codes" | MFA flow text drift |
| `test/widget/splits_test.dart` | Looking for "May rent" — 0 found | Fake-data fixture renamed |

**Filed as TD-7** in `docs/audit-progress.md` for a future cleanup sprint.

## Repos touched
- `appuifelo` (FE)
- `appbackendfelo` — **BE: not applicable.** All 3 bugs are FE-only.

## Files changed
- `lib/features/splits/presentation/splits_screens.dart` — empty-list guard.
- `test/widget_test.dart` — `ProviderScope` wrap.
- `test/golden/goldens/felo_shared_components.png` — regenerated.
- `test/golden/goldens/notifications_components.png` — regenerated.

## Test evidence
**Before:**
```
flutter test → 135 passed / 8 failed
```
**After (this sprint applied):**
```
flutter test → 139 passed / 4 failed
                          └── all 4 confirmed pre-existing on main pre-merge
```

**Runtime smoke (Pixel 10 Pro emulator):**
```
APK installed:  com.felo.felo
PID alive:      17989 (no crashes)
Logcat scan:    no Flutter exceptions, no AndroidRuntime errors
Time-to-display: 451ms
```

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Bug 1 is a real prod crash; the empty-list guard mirrors the existing pattern in `_applyEqualShares` so the codebase stays consistent. Bug 2 fixes a test that was silently broken by sprint 02. Bug 3 is mechanical golden refresh — diffs are sub-pixel-perceptible.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: No deps, secrets, network, storage, or auth surface. Empty-list guard reduces an attack-vector class (DoS-on-empty-input pattern).

## Migration notes
None. The prod fix only changes behavior for previously-crashing input.

## Follow-ups (TD-7)
File 4 pre-existing flow-test failures as a dedicated tech-debt sprint. They need fake-data fixture realignment with current copy.
