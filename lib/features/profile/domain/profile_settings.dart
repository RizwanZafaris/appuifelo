import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_settings.freezed.dart';
part 'profile_settings.g.dart';

enum FeloThemeMode { system, light, dark }

@freezed
abstract class ProfileSettings with _$ProfileSettings {
  const factory ProfileSettings({
    required String languageCode,
    required FeloThemeMode themeMode,
    required bool operationalNotifications,
    required bool marketingConsent,
    required bool smsParserEnabled,
  }) = _ProfileSettings;

  factory ProfileSettings.fromJson(Map<String, Object?> json) =>
      _$ProfileSettingsFromJson(json);
}
