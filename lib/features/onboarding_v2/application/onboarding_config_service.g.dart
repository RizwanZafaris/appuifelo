// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_config_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingConfigVersionHash() =>
    r'8340bff039906911dddacd30e1184dc3276cf53e';

/// Convenience accessor — returns just the version string (for cache
/// debugging + version-aware logging).
///
/// Copied from [onboardingConfigVersion].
@ProviderFor(onboardingConfigVersion)
final onboardingConfigVersionProvider =
    AutoDisposeFutureProvider<String?>.internal(
      onboardingConfigVersion,
      name: r'onboardingConfigVersionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingConfigVersionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingConfigVersionRef = AutoDisposeFutureProviderRef<String?>;
String _$onboardingConfigHash() => r'6f41a7a026037ad8c41d4aa76129ce5c5151069a';

/// Flutter side of D-029 — fetches the DB-driven journey config from
/// NestJS and caches locally with version-hash invalidation.
///
/// Behavior:
/// - On cold start, returns cached payload immediately if present
/// - Refreshes opportunistically on app foreground (TTL 24h via the
///   AppLifecycleState listener that wraps this provider)
/// - If the server returns a different `version` than the cached one,
///   invalidates the cache and emits the fresh payload
/// - On network failure with no cache, returns the bundled fallback
///   so the app never blocks on first launch (out-of-scope for E0;
///   bundled fallback added in E9 sprint).
///
/// Copied from [OnboardingConfig].
@ProviderFor(OnboardingConfig)
final onboardingConfigProvider =
    AutoDisposeAsyncNotifierProvider<
      OnboardingConfig,
      Map<String, dynamic>
    >.internal(
      OnboardingConfig.new,
      name: r'onboardingConfigProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingConfigHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingConfig = AutoDisposeAsyncNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
