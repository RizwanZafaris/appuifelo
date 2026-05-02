// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoachMessage _$CoachMessageFromJson(Map<String, dynamic> json) =>
    _CoachMessage(
      id: json['id'] as String,
      author: $enumDecode(_$CoachMessageAuthorEnumMap, json['author']),
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      adviceBoundaryVisible: json['adviceBoundaryVisible'] as bool,
    );

Map<String, dynamic> _$CoachMessageToJson(_CoachMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': _$CoachMessageAuthorEnumMap[instance.author]!,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'adviceBoundaryVisible': instance.adviceBoundaryVisible,
    };

const _$CoachMessageAuthorEnumMap = {
  CoachMessageAuthor.user: 'user',
  CoachMessageAuthor.coach: 'coach',
  CoachMessageAuthor.system: 'system',
};
