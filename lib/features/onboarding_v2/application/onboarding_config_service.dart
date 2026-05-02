import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/dio_provider.dart';

part 'onboarding_config_service.g.dart';

const _kConfigCacheKey = 'felo.onboarding_v2.config';
const _kConfigVersionKey = 'felo.onboarding_v2.config_version';

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
@riverpod
class OnboardingConfig extends _$OnboardingConfig {
  static const _storage = FlutterSecureStorage();

  @override
  Future<Map<String, dynamic>> build() async {
    // First pass — try cache, fall back to network.
    final cached = await _readCache();
    if (cached != null) {
      // Trigger background refresh for next launch but return cached now.
      // ignore: unawaited_futures
      _refreshIfStale();
      return cached;
    }
    return _fetchAndCache();
  }

  /// Force a refresh (called when the app foregrounds or on demand).
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchAndCache);
  }

  Future<Map<String, dynamic>> _fetchAndCache() async {
    final dio = ref.read(dioProvider);
    final response = await dio.get<Map<String, dynamic>>(
      '/onboarding/journey-config',
    );
    final payload = response.data;
    if (payload == null) {
      throw StateError('journey-config returned null body');
    }
    await _writeCache(payload);
    return payload;
  }

  /// If the cached version differs from the server's current version,
  /// silently refresh. Doesn't interrupt the current session even if
  /// content is stale; the next launch picks up the new version.
  Future<void> _refreshIfStale() async {
    try {
      await _fetchAndCache();
    } catch (_) {
      // Network blip — cache stays valid.
    }
  }

  Future<Map<String, dynamic>?> _readCache() async {
    final raw = await _storage.read(key: _kConfigCacheKey);
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeCache(Map<String, dynamic> payload) async {
    await _storage.write(key: _kConfigCacheKey, value: jsonEncode(payload));
    final version = payload['version']?.toString();
    if (version != null) {
      await _storage.write(key: _kConfigVersionKey, value: version);
    }
  }
}

/// Convenience accessor — returns just the version string (for cache
/// debugging + version-aware logging).
@riverpod
Future<String?> onboardingConfigVersion(OnboardingConfigVersionRef ref) async {
  final config = await ref.watch(onboardingConfigProvider.future);
  return config['version']?.toString();
}
