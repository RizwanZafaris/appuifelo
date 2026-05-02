import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member.freezed.dart';
part 'family_member.g.dart';

enum FamilyRole { admin, member, viewer }

@freezed
abstract class FamilyMember with _$FamilyMember {
  const factory FamilyMember({
    required String id,
    required String displayName,
    required String phoneMasked,
    required FamilyRole role,
    required bool canViewSharedTransactions,
    required bool canEditSharedBudgets,
  }) = _FamilyMember;

  factory FamilyMember.fromJson(Map<String, Object?> json) =>
      _$FamilyMemberFromJson(json);
}
