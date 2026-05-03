# Claude Code notes — appuifelo

This is the **Flutter mobile app** for Felo. One of three repos. The
canonical project-wide handoff is at:

    /Users/rizwanzafar/Desktop/Felo_Project/FELO_HANDOFF.md

…if available.

## Active branch

`soft-launch/v1` — manual remittance notebook only, no live money
movement. Stub features (KYC, investments, sms-parser, family,
live remittance) are gated behind `FeloEnv.enable*` dart-defines and
default to OFF in release.

## Source of truth

| Topic | Read |
|---|---|
| Boot + Crashlytics | `lib/main.dart` |
| All --dart-define inputs + boot guards | `lib/core/config/felo_env.dart` |
| Routes + feature flags | `lib/core/router/app_router.dart` |
| Network: cert pin → trace → auth → retry | `lib/core/network/dio_provider.dart` |
| Error taxonomy | `lib/core/error/app_error.dart` |
| Offline writes | `lib/core/offline/mutation_queue.dart` |
| GDPR consent | `lib/core/legal/consent_gate.dart` |
| Real biometric | `lib/core/security/biometric_service.dart` |
| Operational checklist | `OPS_CONFIG.md` |
| Launch readiness | `LAUNCH_READINESS.md` |

## Conventions

- Never default `FELO_API_URL` to an emulator URL (`10.0.2.2`,
  `localhost`). `assertProductionReady()` rejects them in release.
- Never set `FELO_USE_FAKE_DATA=true` for a release build — release
  always forces it false regardless of dart-define.
- The placeholder TOTP secret `JBSWY3DPEHPK3PXP` is forbidden by CI.
- `flutter_windowmanager` is discontinued; do NOT re-add it.
  `ScreenSecurity` is currently a no-op stub — replace with a
  maintained alternative (P1).
- Never re-introduce `lib/features/send_money/` or
  `lib/features/remittance_stub/` — both are deleted in soft-launch.

## Quick build (demo APK)

```bash
SUPABASE_PUBLISHABLE_KEY=<from Supabase Settings > API > anon>
FELO_REQUIRE_RELEASE_SIGNING=0 flutter build apk --debug --flavor prod \
  --dart-define=FELO_API_URL=https://appbackendfelo-production.up.railway.app/v1 \
  --dart-define=SUPABASE_URL=https://qooaehrmlhenfrklzcht.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY="$SUPABASE_PUBLISHABLE_KEY" \
  --dart-define=FELO_USE_FAKE_DATA=false \
  --dart-define=FELO_USE_ONBOARDING_V2=true
```

Output: `build/app/outputs/flutter-apk/app-prod-debug.apk`

## Quick-validate

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze       # 0 errors expected; pre-existing 154 info/warn
flutter test
```

## Known follow-ups

See `LAUNCH_READINESS.md` P1 list. Highest priority:
- Replace `flutter_windowmanager` (`ScreenSecurity` is stubbed)
- Bake cert pins from prod TLS once Railway domain is final
- Wire `BiometricService.enable()` from auth-recovery screen
- Family-invite deeplink token validation
- Drop legacy `lib/features/onboarding/` once `onboarding_v2` confirmed
