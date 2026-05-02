// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SplitParticipant _$SplitParticipantFromJson(Map<String, dynamic> json) =>
    _SplitParticipant(
      id: json['id'] as String,
      splitId: json['splitId'] as String,
      displayName: json['displayName'] as String,
      contact: json['contact'] as String,
      shareMinor: (json['shareMinor'] as num).toInt(),
      paidMinor: (json['paidMinor'] as num).toInt(),
      status: $enumDecode(_$SplitParticipantStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$SplitParticipantToJson(_SplitParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'splitId': instance.splitId,
      'displayName': instance.displayName,
      'contact': instance.contact,
      'shareMinor': instance.shareMinor,
      'paidMinor': instance.paidMinor,
      'status': _$SplitParticipantStatusEnumMap[instance.status]!,
    };

const _$SplitParticipantStatusEnumMap = {
  SplitParticipantStatus.pending: 'pending',
  SplitParticipantStatus.paid: 'paid',
};

_Split _$SplitFromJson(Map<String, dynamic> json) => _Split(
  id: json['id'] as String,
  name: json['name'] as String,
  currency: json['currency'] as String,
  totalMinor: (json['totalMinor'] as num).toInt(),
  status: $enumDecode(_$SplitStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  participants: (json['participants'] as List<dynamic>)
      .map((e) => SplitParticipant.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SplitToJson(_Split instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'currency': instance.currency,
  'totalMinor': instance.totalMinor,
  'status': _$SplitStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'participants': instance.participants,
};

const _$SplitStatusEnumMap = {
  SplitStatus.active: 'active',
  SplitStatus.settled: 'settled',
  SplitStatus.cancelled: 'cancelled',
};
