// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Budget _$BudgetFromJson(Map<String, dynamic> json) => _Budget(
  id: json['id'] as String,
  category: json['category'] as String,
  currency: json['currency'] as String,
  limitMinor: (json['limitMinor'] as num).toInt(),
  spentMinor: (json['spentMinor'] as num).toInt(),
  period: $enumDecode(_$BudgetPeriodEnumMap, json['period']),
  rolloverEnabled: json['rolloverEnabled'] as bool,
  alertThresholdPercent: (json['alertThresholdPercent'] as num).toInt(),
);

Map<String, dynamic> _$BudgetToJson(_Budget instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'currency': instance.currency,
  'limitMinor': instance.limitMinor,
  'spentMinor': instance.spentMinor,
  'period': _$BudgetPeriodEnumMap[instance.period]!,
  'rolloverEnabled': instance.rolloverEnabled,
  'alertThresholdPercent': instance.alertThresholdPercent,
};

const _$BudgetPeriodEnumMap = {
  BudgetPeriod.weekly: 'weekly',
  BudgetPeriod.monthly: 'monthly',
};
