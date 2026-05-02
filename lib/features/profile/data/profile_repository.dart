import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/profile/domain/profile_settings.dart';

part 'profile_repository.g.dart';

/// Backend-shape profile contract.
///
/// `ApiProfileRepository` talks to NestJS at `/v1/profiles/me` (PATCH and
/// GET). `FakeProfileRepository` keeps Phase-1 default settings so the
/// app boots without a backend.
abstract class ProfileRepository {
  /// Legacy sync seed used during Phase-1 — returns a default
  /// `ProfileSettings` even in fake mode.
  ProfileSettings settings();

  Future<ProfileSettings> fetch();
  Future<ProfileSettings> update({
    String? languageCode,
    FeloThemeMode? themeMode,
    bool? operationalNotifications,
    bool? marketingConsent,
    bool? smsParserEnabled,
  });
}

class ApiProfileRepository implements ProfileRepository {
  ApiProfileRepository(this._api);

  final FeloApiClient _api;

  @override
  ProfileSettings settings() => const ProfileSettings(
        languageCode: 'en',
        themeMode: FeloThemeMode.system,
        operationalNotifications: true,
        marketingConsent: false,
        smsParserEnabled: false,
      );

  @override
  Future<ProfileSettings> fetch() async {
    final raw = await _api.getMyProfile();
    return _settingsFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<ProfileSettings> update({
    String? languageCode,
    FeloThemeMode? themeMode,
    bool? operationalNotifications,
    bool? marketingConsent,
    bool? smsParserEnabled,
  }) async {
    final body = <String, dynamic>{
      'languageCode': ?languageCode,
      'themeMode': ?themeMode?.name,
      'operationalNotifications': ?operationalNotifications,
      'marketingConsent': ?marketingConsent,
      'smsParserEnabled': ?smsParserEnabled,
    };
    final raw = await _api.updateMyProfile(body);
    return _settingsFromApi((raw as Map).cast<String, dynamic>());
  }
}

class FakeProfileRepository implements ProfileRepository {
  ProfileSettings _store = const ProfileSettings(
    languageCode: 'en',
    themeMode: FeloThemeMode.dark,
    operationalNotifications: true,
    marketingConsent: false,
    smsParserEnabled: true,
  );

  @override
  ProfileSettings settings() => _store;

  @override
  Future<ProfileSettings> fetch() async => _store;

  @override
  Future<ProfileSettings> update({
    String? languageCode,
    FeloThemeMode? themeMode,
    bool? operationalNotifications,
    bool? marketingConsent,
    bool? smsParserEnabled,
  }) async {
    _store = _store.copyWith(
      languageCode: languageCode ?? _store.languageCode,
      themeMode: themeMode ?? _store.themeMode,
      operationalNotifications:
          operationalNotifications ?? _store.operationalNotifications,
      marketingConsent: marketingConsent ?? _store.marketingConsent,
      smsParserEnabled: smsParserEnabled ?? _store.smsParserEnabled,
    );
    return _store;
  }
}

ProfileSettings _settingsFromApi(Map<String, dynamic> json) {
  return ProfileSettings(
    languageCode: (json['languageCode'] ?? json['language_code'] ?? 'en')
        .toString()
        .toLowerCase(),
    themeMode: _themeModeFrom(json['themeMode'] ?? json['theme_mode']),
    operationalNotifications:
        json['operationalNotifications'] != false &&
        json['operational_notifications'] != false,
    marketingConsent:
        json['marketingConsent'] == true || json['marketing_consent'] == true,
    smsParserEnabled:
        json['smsParserEnabled'] == true ||
        json['sms_parser_enabled'] == true,
  );
}

FeloThemeMode _themeModeFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'light' => FeloThemeMode.light,
    'dark' => FeloThemeMode.dark,
    _ => FeloThemeMode.system,
  };
}

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeProfileRepository();
  }
  return ApiProfileRepository(ref.watch(feloApiClientProvider));
}

/// Async profile settings notifier.
///
/// Replaces the old sync `profileSettings` provider in `fake_repositories`.
/// `update*()` methods are `Future<void>` — callers should await before
/// navigating away.
@riverpod
class ProfileSettingsNotifier extends _$ProfileSettingsNotifier {
  @override
  Future<ProfileSettings> build() async {
    return ref.watch(profileRepositoryProvider).fetch();
  }

  Future<void> updateSmsParserEnabled(bool enabled) async {
    final updated = await ref
        .read(profileRepositoryProvider)
        .update(smsParserEnabled: enabled);
    state = AsyncValue.data(updated);
  }

  Future<void> updateLanguage(String languageCode) async {
    final updated = await ref
        .read(profileRepositoryProvider)
        .update(languageCode: languageCode);
    state = AsyncValue.data(updated);
  }

  Future<void> updateThemeMode(FeloThemeMode mode) async {
    final updated = await ref
        .read(profileRepositoryProvider)
        .update(themeMode: mode);
    state = AsyncValue.data(updated);
  }

  Future<void> updateOperationalNotifications(bool enabled) async {
    final updated = await ref
        .read(profileRepositoryProvider)
        .update(operationalNotifications: enabled);
    state = AsyncValue.data(updated);
  }

  Future<void> updateMarketingConsent(bool enabled) async {
    final updated = await ref
        .read(profileRepositoryProvider)
        .update(marketingConsent: enabled);
    state = AsyncValue.data(updated);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(profileRepositoryProvider).fetch(),
    );
  }
}
