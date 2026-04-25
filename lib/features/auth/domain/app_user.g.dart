// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  email: json['email'] as String,
  corridor: $enumDecode(_$UserCorridorEnumMap, json['corridor']),
  languageCode: json['languageCode'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'email': instance.email,
  'corridor': _$UserCorridorEnumMap[instance.corridor]!,
  'languageCode': instance.languageCode,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$UserCorridorEnumMap = {
  UserCorridor.canada: 'canada',
  UserCorridor.pakistan: 'pakistan',
};
