// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'felo_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeloAccount _$FeloAccountFromJson(Map<String, dynamic> json) => _FeloAccount(
  id: json['id'] as String,
  provider: $enumDecode(_$FeloAccountProviderEnumMap, json['provider']),
  type: $enumDecode(_$FeloAccountTypeEnumMap, json['type']),
  displayName: json['displayName'] as String,
  currency: json['currency'] as String,
  balanceMinor: (json['balanceMinor'] as num).toInt(),
  lastSyncedAt: DateTime.parse(json['lastSyncedAt'] as String),
  syncStatus: $enumDecode(_$FeloAccountSyncStatusEnumMap, json['syncStatus']),
);

Map<String, dynamic> _$FeloAccountToJson(_FeloAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provider': _$FeloAccountProviderEnumMap[instance.provider]!,
      'type': _$FeloAccountTypeEnumMap[instance.type]!,
      'displayName': instance.displayName,
      'currency': instance.currency,
      'balanceMinor': instance.balanceMinor,
      'lastSyncedAt': instance.lastSyncedAt.toIso8601String(),
      'syncStatus': _$FeloAccountSyncStatusEnumMap[instance.syncStatus]!,
    };

const _$FeloAccountProviderEnumMap = {
  FeloAccountProvider.td: 'td',
  FeloAccountProvider.rbc: 'rbc',
  FeloAccountProvider.easypaisa: 'easypaisa',
  FeloAccountProvider.jazzcash: 'jazzcash',
  FeloAccountProvider.manual: 'manual',
};

const _$FeloAccountTypeEnumMap = {
  FeloAccountType.bank: 'bank',
  FeloAccountType.card: 'card',
  FeloAccountType.wallet: 'wallet',
};

const _$FeloAccountSyncStatusEnumMap = {
  FeloAccountSyncStatus.synced: 'synced',
  FeloAccountSyncStatus.syncing: 'syncing',
  FeloAccountSyncStatus.needsReview: 'needsReview',
};
