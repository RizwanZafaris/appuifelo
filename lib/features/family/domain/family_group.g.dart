// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyGroup _$FamilyGroupFromJson(Map<String, dynamic> json) => _FamilyGroup(
  id: json['id'] as String,
  name: json['name'] as String,
  createdBy: json['createdBy'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  members: (json['members'] as List<dynamic>)
      .map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
      .toList(),
  isDefault: json['isDefault'] as bool? ?? false,
);

Map<String, dynamic> _$FamilyGroupToJson(_FamilyGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'members': instance.members,
      'isDefault': instance.isDefault,
    };
