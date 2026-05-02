import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:felo/features/family/domain/family_member.dart';

part 'family_group.freezed.dart';
part 'family_group.g.dart';

@freezed
abstract class FamilyGroup with _$FamilyGroup {
  const factory FamilyGroup({
    required String id,
    required String name,
    required String createdBy,
    required DateTime createdAt,
    required List<FamilyMember> members,
    @Default(false) bool isDefault,
  }) = _FamilyGroup;

  factory FamilyGroup.fromJson(Map<String, Object?> json) =>
      _$FamilyGroupFromJson(json);
}
