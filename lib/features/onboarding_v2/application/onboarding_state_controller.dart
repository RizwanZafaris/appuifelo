import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/dio_provider.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_state.dart';

part 'onboarding_state_controller.g.dart';

const _kOnboardingStateKey = 'felo.onboarding_v2.state';
const _kResumeWindow = Duration(days: 7);

/// Riverpod async notifier for OnboardingState (FR-11.0.1..4 / D-009).
///
/// Two-tier persistence:
/// - **Local** (synchronous, before nav): `flutter_secure_storage`
/// - **Remote** (fire-and-forget, retries on next Continue): NestJS
///   `PATCH /v1/onboarding/state`
///
/// On cold start, restores from secure storage. If `lastUpdatedAt` is
/// within 7 days, the user resumes at the next step. Otherwise the
/// caller is expected to prompt "Pick up where you left off?" before
/// dispatching this controller.
@riverpod
class OnboardingStateController extends _$OnboardingStateController {
  static const _storage = FlutterSecureStorage();

  @override
  Future<OnboardingState> build() async {
    final raw = await _storage.read(key: _kOnboardingStateKey);
    if (raw == null) return OnboardingState.empty();
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return OnboardingState.fromJson(json);
    } catch (_) {
      // Corrupt local state — start fresh (better than crashing).
      return OnboardingState.empty();
    }
  }

  /// FR-11.0.1 + FR-11.0.2 — write-on-Continue. Persist locally first
  /// (synchronously), then fire remote sync. Never throws on remote
  /// failure; the next successful Continue retries.
  Future<void> patch(OnboardingState Function(OnboardingState) updater) async {
    final current = state.value ?? OnboardingState.empty();
    final next = updater(current).copyWith(
      lastUpdatedAt: DateTime.now(),
    );
    state = AsyncValue.data(next);

    // Local persist FIRST — this must complete before nav.
    await _storage.write(
      key: _kOnboardingStateKey,
      value: jsonEncode(next.toJson()),
    );

    // Remote sync — fire and forget. Failures don't block the user.
    unawaited(_remotePatch(next));
  }

  /// Lighter helper: bumps `lastCompletedStep` and persists.
  Future<void> markStepCompleted(String stepId) async {
    return patch((s) => s.copyWith(lastCompletedStep: stepId));
  }

  /// Reset state — used on explicit "Start over" branch in resume flow.
  Future<void> resetState() async {
    state = AsyncValue.data(OnboardingState.empty());
    await _storage.delete(key: _kOnboardingStateKey);
  }

  /// Whether the persisted state is recent enough to auto-resume.
  /// FR-11.0.3.
  bool get canAutoResume {
    final s = state.value;
    if (s == null || s.lastUpdatedAt == null) return false;
    return DateTime.now().difference(s.lastUpdatedAt!) < _kResumeWindow;
  }

  Future<void> _remotePatch(OnboardingState next) async {
    final dio = ref.read(dioProvider);
    try {
      // Translate the freezed state to the snake_case wire format the
      // NestJS PATCH endpoint expects.
      final body = <String, dynamic>{
        if (next.primaryRegion != null) 'primary_region': next.primaryRegion,
        if (next.secondaryRegions.isNotEmpty)
          'secondary_regions': next.secondaryRegions,
        if (next.name != null) 'name': next.name,
        if (next.ipCountry != null) 'ip_country': next.ipCountry,
        if (next.smsGranted != null) 'sms_granted': next.smsGranted,
        if (next.notificationsGranted != null)
          'notifications_granted': next.notificationsGranted,
        if (next.locationGranted != null)
          'location_granted': next.locationGranted,
        if (next.contactsAck != null) 'contacts_ack': next.contactsAck,
        if (next.earningTypes.isNotEmpty) 'earning_types': next.earningTypes,
        if (next.earningTypeCustom != null)
          'earning_type_custom': next.earningTypeCustom,
        if (next.accounts.isNotEmpty)
          'accounts': next.accounts.map((a) => a.toJson()).toList(),
        'accounts_deferred': next.accountsDeferred,
        if (next.invests != null) 'invests': next.invests,
        if (next.investmentTypes.isNotEmpty)
          'investment_types': next.investmentTypes,
        if (next.budgetTotalMinor != null)
          'budget_total_minor': next.budgetTotalMinor,
        if (next.budgetCurrency != null)
          'budget_currency': next.budgetCurrency,
        if (next.budgetCategories.isNotEmpty)
          'budget_categories':
              next.budgetCategories.map((c) => c.toJson()).toList(),
        if (next.goals.isNotEmpty)
          'goals': next.goals.map((g) => g.toJson()).toList(),
        if (next.remittanceOptions.isNotEmpty)
          'remittance_options': next.remittanceOptions,
        if (next.sendsTo.isNotEmpty) 'sends_to': next.sendsTo,
        if (next.receivesFrom.isNotEmpty) 'receives_from': next.receivesFrom,
        if (next.lastCompletedStep != null)
          'last_completed_step': next.lastCompletedStep,
      };
      await dio.patch<void>('/onboarding/state', data: body);
    } catch (_) {
      // Remote failure is fine — local state is authoritative;
      // next Continue retries.
    }
  }
}
