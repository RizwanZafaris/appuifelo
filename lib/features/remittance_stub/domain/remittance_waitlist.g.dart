// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remittance_waitlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemittanceWaitlist _$RemittanceWaitlistFromJson(Map<String, dynamic> json) =>
    _RemittanceWaitlist(
      id: json['id'] as String,
      corridor: json['corridor'] as String,
      joined: json['joined'] as bool,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RemittanceWaitlistToJson(_RemittanceWaitlist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'corridor': instance.corridor,
      'joined': instance.joined,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
