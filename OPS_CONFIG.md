# Felo Mobile — Ops Config (credentials & build artifacts)

> Things Engineering cannot code. Each row is a launch blocker until
> filled in by the owning team and recorded in the Mobile secret store
> (Fastlane match for iOS, GitHub Actions encrypted secrets for Android +
> dart-defines).

| Status legend | |
|---|---|
| ☐ | Not yet provisioned |
| ⏳ | Provisioned, awaiting validation |
| ✅ | Provisioned, in CI/secret store, validated |

---

## 1. `--dart-define` (CI/release builds)

| Var | Status | Owner | Notes |
|---|---|---|---|
| `FELO_API_URL` | ☐ | Mobile | Must be `https://...` and **not** point at `10.0.2.2` / `localhost` in release. |
| `SUPABASE_URL` | ☐ | Platform | Mirrors backend OPS_CONFIG. |
| `SUPABASE_PUBLISHABLE_KEY` | ☐ | Platform | Anon-tier; safe to ship. |
| `FELO_USE_FAKE_DATA` | n/a | n/a | Forced `false` in release builds regardless of dart-define. |
| `FELO_USE_ONBOARDING_V2` | ☐ | Mobile | Pick before TestFlight cutover. |
| `FELO_ENABLE_KYC` | ☐ | Mobile | Default false until backend KYC vendor wired. |
| `FELO_ENABLE_INVESTMENTS` | ☐ | Mobile | Default false. |
| `FELO_ENABLE_SMS_PARSER` | ☐ | Mobile | Default false. |
| `FELO_ENABLE_LIVE_REMITTANCE` | ☐ | Mobile | Default false; flips on per-corridor as backend providers go live. |

## 2. Android signing

| Item | Status | Owner | Notes |
|---|---|---|---|
| Upload keystore (`upload-keystore.jks`) | ☐ | Mobile | Generate with `keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`. Store in CI secret store, never in repo. |
| `android/key.properties` (in CI) | ☐ | Mobile | Keys: `storeFile`, `storePassword`, `keyAlias`, `keyPassword`. |
| `FELO_REQUIRE_RELEASE_SIGNING=1` env in CI | ✅ | Mobile | Default ON in `android/app/build.gradle.kts`. |
| Play App Signing (Google) | ☐ | Mobile | Once uploaded, Google holds the deployment key. |

## 3. iOS signing

| Item | Status | Owner | Notes |
|---|---|---|---|
| Apple Developer team membership | ☐ | Mobile |  |
| Distribution cert | ☐ | Mobile | Managed by Fastlane match preferred. |
| Provisioning profile (App Store) | ☐ | Mobile |  |
| Push entitlement (APNs) | ☐ | Mobile |  |

## 4. Firebase

| Item | Status | Owner | Notes |
|---|---|---|---|
| Firebase project (Felo Prod) | ☐ | Mobile |  |
| `google-services.json` (per flavor) | ☐ | Mobile | Drop into `android/app/src/{staging,prod}/`. Never commit prod copies. |
| `GoogleService-Info.plist` (per flavor) | ☐ | Mobile | Drop into `ios/Runner/Firebase/{Staging,Prod}/`. |
| Crashlytics enabled in console | ☐ | Mobile | Verify dSYM upload script runs in CI. |
| Cloud Messaging server key (FCM) | ☐ | Mobile | Mirrors backend OPS_CONFIG. |

## 5. App Links / Universal Links

| Item | Status | Owner | Notes |
|---|---|---|---|
| `assetlinks.json` published at `https://<domain>/.well-known/assetlinks.json` | ☐ | Platform | Required for Family invite deep links. |
| `apple-app-site-association` published | ☐ | Platform |  |
| Manifest intent-filters with `android:autoVerify="true"` | ☐ | Mobile | Add when domain is finalised. |
| Associated Domains entitlement (iOS) | ☐ | Mobile |  |

## 6. Cert-pinning hashes (P1 — track for next sprint)

| SPKI SHA-256 (production) | Status | Owner |
|---|---|---|
| Primary leaf | ☐ | Platform |
| Backup pin (root or intermediate) | ☐ | Platform |

## 7. CI / supply chain

| Item | Status | Owner |
|---|---|---|
| Branch protection on `main` (required reviews + green CI) | ☐ | Platform |
| MobSF scan on debug APK in CI | ☐ | Security |
| Dependabot for `pubspec.yaml` | ☐ | Security |

---

## Final boot gate

After every dart-define is set in CI and every keystore/cert is in the
right secret store, Mobile flips `FELO_REQUIRE_RELEASE_SIGNING=1` (already
the default) and produces release artifacts via:

```
flutter build appbundle \
  --flavor prod -t lib/main.dart \
  --dart-define-from-file=ci/prod-defines.json
```

Do **not** ship a release where any row above is `☐`.
