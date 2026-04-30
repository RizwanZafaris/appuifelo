import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/family/domain/family_group.dart';
import 'package:felo/features/family/domain/family_member.dart';

part 'family_repository.g.dart';

// ============================================================================
// Abstract Interface
// ============================================================================

abstract class FamilyRepository {
  Future<List<FamilyGroup>> listGroups();
  Future<FamilyGroup> getGroup(String id);
  Future<FamilyGroup> createGroup({required String name});
  Future<void> inviteMember(String groupId, {required String phone, required FamilyRole role});
  Future<void> acceptInvitation(String code);
  Future<List<FamilyMember>> listMembers(String groupId);
}

// ============================================================================
// API Implementation
// ============================================================================

class ApiFamilyRepository implements FamilyRepository {
  ApiFamilyRepository(this._api);

  final FeloApiClient _api;

  @override
  Future<List<FamilyGroup>> listGroups() async {
    final raw = await _api.listFamilyGroups();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_groupFromApi).toList(growable: false);
  }

  @override
  Future<FamilyGroup> getGroup(String id) async {
    final raw = await _api.getFamilyGroup(id);
    return _groupFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<FamilyGroup> createGroup({required String name}) async {
    final raw = await _api.createFamilyGroup({'name': name});
    return _groupFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<void> inviteMember(String groupId, {required String phone, required FamilyRole role}) async {
    await _api.inviteFamilyMember(groupId, {
      'phone': phone,
      'role': role.name,
    });
  }

  @override
  Future<void> acceptInvitation(String code) async {
    await _api.acceptFamilyInvitation(code);
  }

  @override
  Future<List<FamilyMember>> listMembers(String groupId) async {
    final raw = await _api.listFamilyMembers(groupId);
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_memberFromApi).toList(growable: false);
  }
}

// ============================================================================
// Fake Implementation (demo/offline mode)
// ============================================================================

class FakeFamilyRepository implements FamilyRepository {
  final List<FamilyGroup> _groups = [
    const FamilyGroup(
      id: 'group_default',
      name: 'My Family',
      createdBy: 'user_me',
      createdAt: DateTime(2026, 4, 1),
      isDefault: true,
      members: [
        FamilyMember(
          id: 'member_rizwan',
          displayName: 'Rizwan',
          phoneMasked: '+1 647 *** 1189',
          role: FamilyRole.admin,
          canViewSharedTransactions: true,
          canEditSharedBudgets: true,
        ),
        FamilyMember(
          id: 'member_amina',
          displayName: 'Amina',
          phoneMasked: '+92 300 *** 4412',
          role: FamilyRole.member,
          canViewSharedTransactions: true,
          canEditSharedBudgets: false,
        ),
      ],
    ),
  ];

  @override
  Future<List<FamilyGroup>> listGroups() async => List.unmodifiable(_groups);

  @override
  Future<FamilyGroup> getGroup(String id) async {
    return _groups.firstWhere((g) => g.id == id);
  }

  @override
  Future<FamilyGroup> createGroup({required String name}) async {
    final group = FamilyGroup(
      id: 'group_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      createdBy: 'user_me',
      createdAt: DateTime.now(),
      members: const [],
    );
    _groups.add(group);
    return group;
  }

  @override
  Future<void> inviteMember(String groupId, {required String phone, required FamilyRole role}) async {
    // no-op in fake mode
  }

  @override
  Future<void> acceptInvitation(String code) async {
    // no-op in fake mode
  }

  @override
  Future<List<FamilyMember>> listMembers(String groupId) async {
    final group = _groups.firstWhere((g) => g.id == groupId);
    return List.unmodifiable(group.members);
  }
}

// ============================================================================
// JSON Helpers
// ============================================================================

FamilyGroup _groupFromApi(Map<String, dynamic> json) {
  final membersJson = (json['members'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
  return FamilyGroup(
    id: json['id'].toString(),
    name: (json['name'] ?? '').toString(),
    createdBy: (json['createdBy'] ?? json['created_by'] ?? '').toString(),
    createdAt: DateTime.tryParse(
          (json['createdAt'] ?? json['created_at'] ?? '').toString(),
        ) ??
        DateTime.now(),
    isDefault: json['isDefault'] == true || json['is_default'] == true,
    members: membersJson.map(_memberFromApi).toList(growable: false),
  );
}

FamilyMember _memberFromApi(Map<String, dynamic> json) {
  final roleStr = (json['role'] ?? '').toString().toLowerCase();
  return FamilyMember(
    id: json['id'].toString(),
    displayName: (json['displayName'] ?? json['display_name'] ?? '').toString(),
    phoneMasked: (json['phoneMasked'] ?? json['phone_masked'] ?? '').toString(),
    role: FamilyRole.values.firstWhere(
      (r) => r.name == roleStr,
      orElse: () => FamilyRole.viewer,
    ),
    canViewSharedTransactions:
        json['canViewSharedTransactions'] == true ||
        json['can_view_shared_transactions'] == true,
    canEditSharedBudgets:
        json['canEditSharedBudgets'] == true ||
        json['can_edit_shared_budgets'] == true,
  );
}
