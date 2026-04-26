# Onboarding v2 — feature folder

8-phase journey per `/docs/02-prd/prd-onboarding.md` (TBD at Stage 3).

## Layout

```
onboarding_v2/
├─ domain/            # Models (freezed) — OnboardingState, Region, EarningType, Goal, etc.
├─ data/              # Repositories — call NestJS at /v1/onboarding/*
├─ application/       # Riverpod controllers — OnboardingController, AnalyticsService
└─ presentation/
   ├─ phase1_identity/        # welcome / signup_method / otp_verification
   ├─ phase2_context/         # confirm_region / name_input
   ├─ phase3_permissions/     # permissions
   ├─ phase4_financial/       # earning_type / accounts / investment_gate / investment_types
   ├─ phase5_intent/          # budget / goals (redesigned card grid)
   ├─ phase6_remittance/      # remittance / corridor
   ├─ phase7_personalization/ # loading screen
   ├─ phase8_handoff/         # dashboard handoff stub
   └─ shared/                 # ProgressBar, BackButton, OptionCard, PillChip, CTAButton, OTPInput
```

## Feature flag

The legacy `lib/features/onboarding/` flow stays alive during cutover.
Selection happens in `app_router.dart` based on `FeloEnv.useOnboardingV2`
(set via `--dart-define=FELO_USE_ONBOARDING_V2=true`).

## State source of truth

`OnboardingState` is the single source of truth. Persisted via:
- **Local** — `flutter_secure_storage` (resume mid-flow on cold start)
- **Remote** — synced to NestJS `POST /v1/onboarding/state` on every step
  completion (resume across devices)

The remote sync is fire-and-forget with retry; the user never blocks on
network for state updates.

## Analytics

Every screen auto-fires `viewed` / `completed` / `skipped` / `back` /
`validation_error` events via the `OnboardingAnalyticsMixin` in
`application/`. Each event carries its FR ID at compile time via route
metadata. Developers cannot forget to instrument.

## i18n status

EN-only in v1 per Decision D-004. Strings live as `const` in each phase
file for speed; the post-v1 ARB port will hoist them via `flutter gen-l10n`.
