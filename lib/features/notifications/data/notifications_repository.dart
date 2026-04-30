import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/features/notifications/domain/felo_notification.dart';
import 'package:felo/features/sms_parser/domain/parsed_sms.dart';

// ============================================================================
// Abstract Interface
// ============================================================================

abstract class NotificationsRepository {
  List<FeloNotification> seedNotifications({
    required List<Budget> budgets,
    required List<Goal> goals,
    required List<ParsedSms> parsedSmsMessages,
    required List<FamilyMember> familyMembers,
  });

  Future<List<FeloNotification>> fetchNotifications({
    String? cursor,
    int? limit,
  });

  Future<void> markRead(String id);
  Future<void> markAllRead();
  Future<void> subscribe(Map<String, dynamic> payload);
}

// ============================================================================
// API Implementation (production)
// ============================================================================

class ApiNotificationsRepository implements NotificationsRepository {
  ApiNotificationsRepository(this._api);

  final FeloApiClient _api;

  @override
  List<FeloNotification> seedNotifications({
    required List<Budget> budgets,
    required List<Goal> goals,
    required List<ParsedSms> parsedSmsMessages,
    required List<FamilyMember> familyMembers,
  }) {
    // API mode does not use seed notifications — it fetches from the server.
    return const [];
  }

  @override
  Future<List<FeloNotification>> fetchNotifications({
    String? cursor,
    int? limit,
  }) async {
    final raw = await _api.listNotifications(cursor: cursor, limit: limit);
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_notificationFromApi).toList(growable: false);
  }

  @override
  Future<void> markRead(String id) async {
    await _api.markNotificationRead(id);
  }

  @override
  Future<void> markAllRead() async {
    await _api.markAllNotificationsRead();
  }

  @override
  Future<void> subscribe(Map<String, dynamic> payload) async {
    await _api.subscribeNotifications(payload);
  }
}

// ============================================================================
// Fake Implementation (demo/offline mode)
// ============================================================================

class FakeNotificationsRepository implements NotificationsRepository {
  @override
  List<FeloNotification> seedNotifications({
    required List<Budget> budgets,
    required List<Goal> goals,
    required List<ParsedSms> parsedSmsMessages,
    required List<FamilyMember> familyMembers,
  }) {
    final firstBudget = budgets.isEmpty ? null : budgets.first;
    final firstGoal = goals.isEmpty ? null : goals.first;
    final firstParse = parsedSmsMessages.isEmpty ? null : parsedSmsMessages.first;
    final familyMember = familyMembers.length > 1
        ? familyMembers[1]
        : familyMembers.isEmpty
            ? null
            : familyMembers.first;

    return [
      if (firstBudget != null)
        FeloNotification.budgetAlert(
          id: 'notification_budget_${firstBudget.id}',
          createdAt: DateTime(2026, 4, 25, 9, 12),
          budgetId: firstBudget.id,
          thresholdPercent: firstBudget.alertThresholdPercent,
        ),
      if (firstGoal != null)
        FeloNotification.goalMilestone(
          id: 'notification_goal_${firstGoal.id}',
          createdAt: DateTime(2026, 4, 24, 18, 35),
          goalId: firstGoal.id,
          progressPercent:
              ((firstGoal.savedMinor / firstGoal.targetMinor) * 100)
                  .round()
                  .clamp(0, 100),
        ),
      if (firstParse != null)
        FeloNotification.smsParserEvent(
          id: 'notification_sms_${firstParse.id}',
          createdAt: DateTime(2026, 4, 24, 15, 50),
          parsedSmsId: firstParse.id,
          confidencePercent: (firstParse.confidence * 100).round(),
        ),
      if (familyMember != null)
        FeloNotification.familyActivity(
          id: 'notification_family_${familyMember.id}',
          createdAt: DateTime(2026, 4, 23, 20, 5),
          memberId: familyMember.id,
          isRead: true,
        ),
      FeloNotification.systemMessage(
        id: 'notification_system_phase_1',
        createdAt: DateTime(2026, 4, 22, 10, 15),
        isRead: true,
      ),
    ];
  }

  @override
  Future<List<FeloNotification>> fetchNotifications({
    String? cursor,
    int? limit,
  }) async {
    return seedNotifications(
      budgets: const [],
      goals: const [],
      parsedSmsMessages: const [],
      familyMembers: const [],
    );
  }

  @override
  Future<void> markRead(String id) async {}

  @override
  Future<void> markAllRead() async {}

  @override
  Future<void> subscribe(Map<String, dynamic> payload) async {}
}

// ============================================================================
// JSON Helper
// ============================================================================

FeloNotification _notificationFromApi(Map<String, dynamic> json) {
  final id = json['id'].toString();
  final createdAt =
      DateTime.tryParse(
        (json['createdAt'] ?? json['created_at'] ?? '').toString(),
      ) ??
      DateTime.now();
  final isRead =
      json['readAt'] != null ||
      json['read_at'] != null ||
      json['isRead'] == true;
  final archived =
      json['archivedAt'] != null || json['archived_at'] != null;

  final payload = (json['payload'] is Map)
      ? (json['payload'] as Map).cast<String, dynamic>()
      : const <String, dynamic>{};
  final kind = (payload['kind'] ?? '').toString();

  switch (kind) {
    case 'budget_alert':
      return FeloNotification.budgetAlert(
        id: id,
        createdAt: createdAt,
        budgetId: (payload['budgetId'] ?? payload['budget_id'] ?? '').toString(),
        thresholdPercent:
            _intFrom(payload['thresholdPercent'] ?? payload['threshold_percent']) ??
            0,
        isRead: isRead,
        archived: archived,
      );
    case 'goal_milestone':
      return FeloNotification.goalMilestone(
        id: id,
        createdAt: createdAt,
        goalId: (payload['goalId'] ?? payload['goal_id'] ?? '').toString(),
        progressPercent:
            _intFrom(payload['progressPercent'] ?? payload['progress_percent']) ??
            0,
        isRead: isRead,
        archived: archived,
      );
    case 'sms_parser_event':
      return FeloNotification.smsParserEvent(
        id: id,
        createdAt: createdAt,
        parsedSmsId:
            (payload['parsedSmsId'] ?? payload['parsed_sms_id'] ?? '').toString(),
        confidencePercent:
            _intFrom(
              payload['confidencePercent'] ?? payload['confidence_percent'],
            ) ??
            0,
        isRead: isRead,
        archived: archived,
      );
    case 'family_activity':
      return FeloNotification.familyActivity(
        id: id,
        createdAt: createdAt,
        memberId: (payload['memberId'] ?? payload['member_id'] ?? '').toString(),
        isRead: isRead,
        archived: archived,
      );
    default:
      return FeloNotification.systemMessage(
        id: id,
        createdAt: createdAt,
        isRead: isRead,
        archived: archived,
      );
  }
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}
