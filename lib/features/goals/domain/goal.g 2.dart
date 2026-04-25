// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Goal _$GoalFromJson(Map<String, dynamic> json) => _Goal(
  id: json['id'] as String,
  name: json['name'] as String,
  currency: json['currency'] as String,
  targetMinor: (json['targetMinor'] as num).toInt(),
  savedMinor: (json['savedMinor'] as num).toInt(),
  targetDate: DateTime.parse(json['targetDate'] as String),
  shared: json['shared'] as bool,
  cadence: $enumDecode(_$GoalCadenceEnumMap, json['cadence']),
  contributorNames: (json['contributorNames'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$GoalToJson(_Goal instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'currency': instance.currency,
  'targetMinor': instance.targetMinor,
  'savedMinor': instance.savedMinor,
  'targetDate': instance.targetDate.toIso8601String(),
  'shared': instance.shared,
  'cadence': _$GoalCadenceEnumMap[instance.cadence]!,
  'contributorNames': instance.contributorNames,
};

const _$GoalCadenceEnumMap = {
  GoalCadence.manual: 'manual',
  GoalCadence.weekly: 'weekly',
  GoalCadence.biweekly: 'biweekly',
  GoalCadence.monthly: 'monthly',
};
