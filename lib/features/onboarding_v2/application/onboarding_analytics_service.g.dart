// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_analytics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingAnalyticsServiceHash() =>
    r'0554466a733869fcbdada91a0bf4fbf7809ba8ce';

/// Multi-sink analytics emitter (Flutter side of D-030).
///
/// Posts canonical events to NestJS `POST /v1/analytics/event`. The server
/// fans out to (a) Postgres `events` table — internal source of truth,
/// (b) Meta CAPI server-side — Facebook ad attribution, (c) returns a GTM
/// payload for the client to `dataLayer.push` via JS bridge / native plugin.
///
/// Mechanism rule: when sinks are inactive (env vars unset on the server),
/// they enter stub mode and no client code change is needed. Drop in
/// credentials → live.
///
/// Copied from [OnboardingAnalyticsService].
@ProviderFor(OnboardingAnalyticsService)
final onboardingAnalyticsServiceProvider =
    AutoDisposeNotifierProvider<OnboardingAnalyticsService, void>.internal(
      OnboardingAnalyticsService.new,
      name: r'onboardingAnalyticsServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingAnalyticsServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingAnalyticsService = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
