// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingStateControllerHash() =>
    r'8196de34ebc240ed948673ddda2e1a2953247938';

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
///
/// Copied from [OnboardingStateController].
@ProviderFor(OnboardingStateController)
final onboardingStateControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      OnboardingStateController,
      OnboardingState
    >.internal(
      OnboardingStateController.new,
      name: r'onboardingStateControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingStateControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingStateController = AutoDisposeAsyncNotifier<OnboardingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
