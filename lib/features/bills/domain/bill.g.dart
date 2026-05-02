// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bill _$BillFromJson(Map<String, dynamic> json) => _Bill(
  id: json['id'] as String,
  name: json['name'] as String,
  category: $enumDecode(_$BillCategoryEnumMap, json['category']),
  dueDate: DateTime.parse(json['dueDate'] as String),
  currency: json['currency'] as String,
  amountMinor: (json['amountMinor'] as num).toInt(),
  autoPayEnabled: json['autoPayEnabled'] as bool,
  source: $enumDecode(_$BillSourceEnumMap, json['source']),
  status: $enumDecode(_$BillStatusEnumMap, json['status']),
);

Map<String, dynamic> _$BillToJson(_Bill instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': _$BillCategoryEnumMap[instance.category]!,
  'dueDate': instance.dueDate.toIso8601String(),
  'currency': instance.currency,
  'amountMinor': instance.amountMinor,
  'autoPayEnabled': instance.autoPayEnabled,
  'source': _$BillSourceEnumMap[instance.source]!,
  'status': _$BillStatusEnumMap[instance.status]!,
};

const _$BillCategoryEnumMap = {
  BillCategory.utility: 'utility',
  BillCategory.telecom: 'telecom',
  BillCategory.rent: 'rent',
  BillCategory.subscription: 'subscription',
};

const _$BillSourceEnumMap = {
  BillSource.manual: 'manual',
  BillSource.sms: 'sms',
};

const _$BillStatusEnumMap = {
  BillStatus.upcoming: 'upcoming',
  BillStatus.paid: 'paid',
};
