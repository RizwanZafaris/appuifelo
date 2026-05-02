# Sprint 02 — `ThemeMode.system` + Persisted User Override

**Severity:** P0 (Accessibility)
**Source audit:** `/audit` 2026-04-29 — Theming + Accessibility findings

## Problem
`FeloApp` hardcoded `themeMode: ThemeMode.light`, ignoring both the system dark-mode preference and the user's persisted choice already round-tripped through the backend (`profiles.settings.themeMode`). This is an accessibility barrier for low-vision users and undermines the existing settings infrastructure.

## Solution
**Frontend:** Convert `FeloApp` from `StatelessWidget` to `ConsumerWidget`. Watch the existing `profileSettingsNotifierProvider`, map `FeloThemeMode → MaterialApp.themeMode`, and default to `ThemeMode.system` while loading or on error.

**Backend:** No production code change required — `PATCH /profiles/me { themeMode }` and the `profiles.settings` JSONB column (migration 005) already implement persistence with safe partial-merge semantics. Added a unit-test contract to lock in the round-trip behavior.

The "persisted user override" flow is therefore: user toggles theme in Settings → `ProfileSettingsNotifier.updateThemeMode` → `PATCH /profiles/me` → `profiles.settings.themeMode` updated in Postgres → on next launch, `fetch()` returns it → `FeloApp` reflects it.

## Repos touched
- `appuifelo` (FE) — `FeloApp` rewritten as `ConsumerWidget`.
- `appbackendfelo` (BE) — test-only; no production code change.

## Files changed
**appuifelo:**
- `lib/felo_app.dart` — converted to `ConsumerWidget`, binds `themeMode` to settings; added `_materialThemeMode(FeloThemeMode)` mapper.
- `test/felo_app_theme_mode_test.dart` — new; 3 widget tests covering system/light/dark.

**appbackendfelo:**
- `src/modules/profiles/profiles.service.spec.ts` — new; 3 unit tests verifying themeMode round-trip, all enum values, and no-op-on-omit semantics.

## Acceptance criteria
- [x] `MaterialApp.themeMode` is no longer hardcoded.
- [x] Default (no settings loaded) is `ThemeMode.system`.
- [x] User-persisted override (`light`/`dark`/`system`) is reflected after settings load.
- [x] Backend rejects invalid values (DTO `@IsIn(['system','light','dark'])`).
- [x] Backend partial-merge preserves other `settings` keys when only `themeMode` is sent.
- [x] FE: `flutter analyze` clean on changed files; 3/3 widget tests pass.
- [x] BE: 3/3 unit tests pass.

## Test evidence

**FE:**
```
flutter analyze lib/felo_app.dart test/felo_app_theme_mode_test.dart
No issues found! (ran in 5.6s)

flutter test test/felo_app_theme_mode_test.dart
+3: All tests passed!
  ✓ themeMode follows FeloThemeMode.system
  ✓ themeMode honors FeloThemeMode.dark override
  ✓ themeMode honors FeloThemeMode.light override
```

**BE:**
```
npx jest src/modules/profiles/profiles.service.spec.ts
PASS src/modules/profiles/profiles.service.spec.ts
  ProfilesService — themeMode round-trip (sprint 02)
    ✓ persists themeMode=dark while preserving other settings keys
    ✓ accepts each valid themeMode value
    ✓ does not touch settings when themeMode is omitted
Tests: 3 passed, 3 total
```

## CTO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: Exhaustive switch on `FeloThemeMode`; no defaults to drift on. BE test pattern matches `health.controller.spec.ts`. No public API changes.

## CSO sign-off
- Date: 2026-04-29
- Verdict: ✅ Approve
- Notes: No secrets, no new deps, no auth/RLS surface change. `userId` derives from JWT (`RequestUser`), not request body — no IDOR. `themeMode` is non-PII UI preference. DTO whitelist + class-validator block invalid input.

## Migration notes
None. The required schema (`profiles.settings.themeMode`) shipped in migration `005_profile_settings.sql` already in `main`. No new migration. No env vars, no rollout flags. Safe to land independently.

## Cross-repo PRs
- FE: `RizwanZafaris/appuifelo` branch `sprint/02-thememode-system`
- BE: `RizwanZafaris/appbackendfelo` branch `sprint/02-user-theme-preference`
- Land order: either order is safe (BE has no prod changes). Recommend FE first so users see the fix immediately.

## Follow-ups
- Sprint 03 — `FeloCornerRadius` token + replace hardcoded radii.
- Future: add a settings-screen UI surface for the user to actively toggle theme (currently only programmatic).
- Future: consider a boot-time secure-storage cache to eliminate the brief default-system flash before settings resolve.
