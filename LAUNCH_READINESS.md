# Felo Mobile — Launch Readiness

> Companion to the backend `appbackendfelo/LAUNCH_READINESS.md`. Treat
> every unchecked row as a launch blocker.

## P0 — Launch blockers (code)

| # | Status | Item | Where |
|---|---|---|---|
| 1 | ✅ | Crashlytics initialised + recordError on all three error hooks | `lib/main.dart` |
| 2 | ✅ | `FELO_API_URL` defaults to empty + boot fails fast on http:// or emulator URL in release | `lib/core/config/felo_env.dart` |
| 3 | ✅ | `useFakeData` forced false in release regardless of dart-define | `lib/core/config/felo_env.dart` |
| 4 | ✅ | Stub features (KYC, investments, sms-parser, live remittance) gated by feature flags | `lib/core/feature_flags/stub_gate.dart`, `lib/core/router/app_router.dart` |
| 5 | ✅ | `send_money/` + `remittance_stub/` deleted; `/remittance` redirects to `/remittance-notebook` | `lib/core/router/app_router.dart` |
| 6 | ✅ | Retry interceptor restricted to idempotent verbs + jitter + Retry-After | `lib/core/network/retry_interceptor.dart` |
| 7 | ✅ | Real biometric service via `local_auth` (replaces fake setState toggle) | `lib/core/security/biometric_service.dart` |
| 8 | ✅ | FLAG_SECURE helper for KYC / OTP / remittance / app-lock screens | `lib/core/security/screen_security.dart` |
| 9 | ✅ | Android `allowBackup=false` + `dataExtractionRules` exclude all domains | `android/app/src/main/AndroidManifest.xml`, `res/xml/data_extraction_rules.xml` |
| 10 | ✅ | Android `networkSecurityConfig` blocks cleartext (except localhost) | `res/xml/network_security_config.xml` |
| 11 | ✅ | Release-keystore fence default ON; staging + prod flavors | `android/app/build.gradle.kts` |
| 12 | ✅ | ProGuard/R8 keep rules for Firebase / Drift / Flutter | `android/app/proguard-rules.pro` |

## P0 — Operational (tracked in OPS_CONFIG.md)

| Item | Owner |
|---|---|
| Android upload keystore (`android/key.properties`) | Mobile |
| iOS distribution cert + provisioning profile | Mobile |
| Firebase config files (`google-services.json`, `GoogleService-Info.plist`) | Mobile |
| App Links domain (`assetlinks.json`) | Platform |
| Universal Links (`apple-app-site-association`) | Platform |
| Production `--dart-define` set in CI (FELO_API_URL, SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY) | Mobile |
| Cert-pinning SPKI hashes (next iteration — tracked as P1 below) | Mobile |

## P1 — Within 30 days

- Cert pinning at the Dio adapter level (SHA-256 SPKI compare) once the
  prod TLS chain is finalised.
- Wire `BiometricService.enable()` from the auth-recovery screen.
- Apply `ScreenSecurity.enable()` in initState of: KYC, OTP, MFA setup,
  remittance entry, app-lock, profile-edit-with-IBAN.
- Privacy overlay for iOS (covers screenshot vector that FLAG_SECURE
  doesn't address).
- Family-invite deep-link token validation + Universal/App Links manifest.
- Wire export / monthly-close TODO API calls.
- Replace the placeholder TOTP secret in `auth_recovery_screens.dart`
  with a server-issued provisioning URI.

## P2 — Tech debt

- Riverpod 2 → 3, go_router 16 → 17, drop `golden_toolkit`.
- Split `lib/core/di/fake_repositories.dart` (now smaller after deleting
  send_money fakes; still ~700 LOC) into per-feature seed files.
- Add accessibility `Semantics` on money-entry screens.
- Localisations for `ar`, `bn` (Pakistani diaspora corridors).

## Re-audit checklist (mechanical)

```
# 1. Firebase init present in main.dart
grep -q "Firebase.initializeApp" lib/main.dart

# 2. Crashlytics recordError on all three hooks
[ "$(grep -c "recordError\|recordFlutterFatalError" lib/main.dart)" -ge 3 ]

# 3. FELO_API_URL has no emulator default
! grep -q "10.0.2.2" lib/core/config/felo_env.dart

# 4. send_money / remittance_stub fully gone
! [ -d lib/features/send_money ]
! [ -d lib/features/remittance_stub ]
! grep -RIn "send_money\|remittance_stub" lib/ test/

# 5. Stub routes are gated
grep -q "StubGate" lib/core/router/app_router.dart

# 6. Android allowBackup off + network config wired
grep -q 'allowBackup="false"' android/app/src/main/AndroidManifest.xml
[ -f android/app/src/main/res/xml/network_security_config.xml ]

# 7. Release keystore fence default ON
grep -q 'FELO_REQUIRE_RELEASE_SIGNING.*\\?: "1"' android/app/build.gradle.kts
```

If any line returns non-zero or matches, **do not ship**.
