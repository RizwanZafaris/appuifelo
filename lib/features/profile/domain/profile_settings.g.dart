// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileSettings _$ProfileSettingsFromJson(Map<String, dynamic> json) =>
    _ProfileSettings(
      languageCode: json['languageCode'] as String,
      themeMode: $enumDecode(_$FeloThemeModeEnumMap, json['themeMode']),
      operationalNotifications: json['operationalNotifications'] as bool,
      marketingConsent: json['marketingConsent'] as bool,
      smsParserEnabled: json['smsParserEnabled'] as bool,
    );

Map<String, dynamic> _$ProfileSettingsToJson(_ProfileSettings instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'themeMode': _$FeloThemeModeEnumMap[instance.themeMode]!,
      'operationalNotifications': instance.operationalNotifications,
      'marketingConsent': instance.marketingConsent,
      'smsParserEnabled': instance.smsParserEnabled,
    };

const _$FeloThemeModeEnumMap = {
  FeloThemeMode.system: 'system',
  FeloThemeMode.light: 'light',
  FeloThemeMode.dark: 'dark',
};
