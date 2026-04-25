# Felo Flutter — Security & Code Quality Findings

> Date: 2026-04-25 · Sweep covers `lib/`, `android/`, `ios/`, `pubspec.yaml`.
> Result: **0 hardcoded secrets, 0 insecure HTTP, 0 unjustified permissions.**

## ✅ Clean

| Check | Result |
|---|---|
| Hardcoded secrets (API keys, AWS, Firebase, sk_/pk_ tokens) | None |
| Insecure HTTP calls in `lib/` | None — only `https://api.felo.invalid/v1` placeholder |
| `eval` / `dart:mirrors` / `Process.run` | None |
| Insecure storage (`SharedPreferences` for tokens) | None — `flutter_secure_storage` wired |
| Android cleartext traffic | Disabled by default (no `android:usesCleartextTraffic="true"`) |
| Network security config exceptions | None |
| Family-invite deeplink token sanitization | Token passed as data, never executed |
| PII in logs (`debugPrint`, `print`) | None — only stack traces in `main.dart` error handler |
| Android permissions justified | `READ_SMS`, `RECEIVE_SMS`, `INTERNET`, `POST_NOTIFICATIONS`, `CAMERA` — all map to documented features |

## 🔴 Production Blockers (resolved with documentation gates)

### P0 — Android release signed with debug keystore
**Where:** `android/app/build.gradle.kts`
**Status:** ⚠️ Fenced. Build hard-fails if `FELO_REQUIRE_RELEASE_SIGNING=1` is set in CI, preventing accidental publish. Production keystore wiring documented in-file.
**Action before launch:** generate upload keystore, wire `key.properties`, set CI env var.

### P1 — iOS purpose strings missing
**Where:** `ios/Runner/Info.plist`
**Status:** ✅ Fixed. Added `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription`, `NSPhotoLibraryAddUsageDescription`, `NSFaceIDUsageDescription`, `NSContactsUsageDescription`.

## 🟡 Tracked Tech Debt

| Item | Severity | Notes |
|---|---|---|
| `golden_toolkit ^0.15.0` discontinued | P2 | Replace with `alchemist` or vanilla `matchesGoldenFile`. |
| `sqlite3_flutter_libs` / `sqlcipher_flutter_libs` resolve to `+eol` | P2 | Track upstream successor; not blocking. |
| Riverpod 2 → 3, go_router 16 → 17 majors available | P2 | Coordinate as a single migration sprint. |
| Crashlytics not initialized (deps present in `pubspec.yaml`) | P2 | Three `TODO(felo): forward to Crashlytics` markers in `lib/main.dart`. Requires Firebase config files. |
| `JBSWY3DPEHPK3PXP` placeholder TOTP secret | informational | Deliberate mock for MFA setup screen (`auth_recovery_screens.dart`). Replace at backend integration. |

## 📊 Code Quality

| Metric | Value |
|---|---|
| `flutter analyze` | **No issues found** |
| `flutter test` | **59/59 passing** |
| TODO / FIXME / HACK markers in `lib/` | 3 (all Crashlytics integration) |
| Test files | 13 across `test/widget/`, `test/golden/`, `test/qa/` |
| Largest file (excl. generated) | `lib/core/di/fake_repositories.dart` — 933 lines (split candidate) |
| Strict lint rules enforced | 12 (`always_declare_return_types`, `avoid_dynamic_calls`, `unawaited_futures`, etc.) |

## 🎯 Top 5 Recommendations

1. **Generate an Android upload keystore** and wire `key.properties` before any Play Store upload.
2. **Wire Firebase + Crashlytics** in `lib/main.dart` — error visibility is currently zero in release.
3. **Coordinate dependency upgrade sprint** — Riverpod 2→3, go_router 16→17, drop `golden_toolkit`.
4. **Split `fake_repositories.dart`** (933 lines) into per-feature seed files to keep PR diffs reviewable.
5. **Add coverage gates in CI** — current `.github/workflows/` runs analyze/test but no coverage threshold.
