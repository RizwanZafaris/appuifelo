// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) =>
    _FamilyMember(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      phoneMasked: json['phoneMasked'] as String,
      role: $enumDecode(_$FamilyRoleEnumMap, json['role']),
      canViewSharedTransactions: json['canViewSharedTransactions'] as bool,
      canEditSharedBudgets: json['canEditSharedBudgets'] as bool,
    );

Map<String, dynamic> _$FamilyMemberToJson(_FamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'phoneMasked': instance.phoneMasked,
      'role': _$FamilyRoleEnumMap[instance.role]!,
      'canViewSharedTransactions': instance.canViewSharedTransactions,
      'canEditSharedBudgets': instance.canEditSharedBudgets,
    };

const _$FamilyRoleEnumMap = {
  FamilyRole.admin: 'admin',
  FamilyRole.member: 'member',
  FamilyRole.viewer: 'viewer',
};
