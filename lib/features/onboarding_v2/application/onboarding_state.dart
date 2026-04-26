// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';
part 'onboarding_state.g.dart';

/// Single source of truth for the onboarding journey.
///
/// Per D-009 (write-on-Continue, resume-from-last-completed-step), this
/// state is persisted locally to `flutter_secure_storage` synchronously
/// on every Continue tap, then synced fire-and-forget to NestJS at
/// `PATCH /v1/onboarding/state`.
///
/// The shape mirrors `onboarding_state` table in `006_onboarding_v2.sql`.
/// Stage 7 epic E11 (state persistence) wires the controller; this
/// model is the contract.
@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    /// Anonymous device id pre-Phase-1 — promoted to Supabase UUID
    /// after auth.
    String? deviceId,
    String? userId,
    String? sessionId,

    // Phase 2 — Context
    String? primaryRegion,
    @Default(<String>[]) List<String> secondaryRegions,
    String? name,
    String? ipCountry,

    // Phase 3 — Permissions
    bool? smsGranted,
    bool? notificationsGranted,
    bool? locationGranted,
    bool? contactsAck,

    // Phase 4 — Financial profile
    @Default(<String>[]) List<String> earningTypes,
    String? earningTypeCustom,
    @Default(<OnboardingAccount>[]) List<OnboardingAccount> accounts,
    @Default(false) bool accountsDeferred,
    bool? invests,
    @Default(<String>[]) List<String> investmentTypes,

    // Phase 5 — Intent
    int? budgetTotalMinor,
    String? budgetCurrency,
    @Default(<OnboardingBudgetCategory>[])
    List<OnboardingBudgetCategory> budgetCategories,
    @Default(<OnboardingGoal>[]) List<OnboardingGoal> goals,

    // Phase 6 — Remittance
    @Default(<String>[]) List<String> remittanceOptions,
    @Default(<String>[]) List<String> sendsTo,
    @Default(<String>[]) List<String> receivesFrom,

    // Cross-cutting — D-009
    String? lastCompletedStep,
    DateTime? lastUpdatedAt,
  }) = _OnboardingState;

  factory OnboardingState.fromJson(Map<String, Object?> json) =>
      _$OnboardingStateFromJson(json);

  factory OnboardingState.empty() => const OnboardingState();
}

@freezed
abstract class OnboardingAccount with _$OnboardingAccount {
  const factory OnboardingAccount({
    required String accountKind, // 'bank' | 'wallet'
    required String providerSlug,
    required String regionIso2,
  }) = _OnboardingAccount;

  factory OnboardingAccount.fromJson(Map<String, Object?> json) =>
      _$OnboardingAccountFromJson(json);
}

@freezed
abstract class OnboardingBudgetCategory with _$OnboardingBudgetCategory {
  const factory OnboardingBudgetCategory({
    required String categorySlug,
    required int amountMinor,
    required String semantic, // 'inflow' | 'outflow' (D-020)
  }) = _OnboardingBudgetCategory;

  factory OnboardingBudgetCategory.fromJson(Map<String, Object?> json) =>
      _$OnboardingBudgetCategoryFromJson(json);
}

@freezed
abstract class OnboardingGoal with _$OnboardingGoal {
  const factory OnboardingGoal({
    required int slot, // 1 or 2 (D-008 hard limit)
    required String templateSlug,
    String? customLabel,
    required int targetAmountMinor,
    required String currency, // multi-currency per D-021
    required DateTime targetDate,
  }) = _OnboardingGoal;

  factory OnboardingGoal.fromJson(Map<String, Object?> json) =>
      _$OnboardingGoalFromJson(json);
}
