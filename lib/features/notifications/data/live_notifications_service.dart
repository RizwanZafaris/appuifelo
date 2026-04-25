import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/features/notifications/domain/felo_notification.dart';

part 'live_notifications_service.g.dart';

/// Thin facade over backend `/v1/notifications` and `/v1/devices` routes.
///
/// The existing `notificationInboxProvider` continues to model the
/// rich `FeloNotification` union types for the UI. This service is what
/// the inbox calls when the user marks something read or archives it,
/// so the backend stays in sync with the optimistic local state.
@riverpod
class LiveNotificationsService extends _$LiveNotificationsService {
  @override
  Future<void> build() async {
    // No state — service only exposes async operations.
  }

  FeloApiClient get _api => FeloApiClient(ref.read(dioProvider));

  Future<int> unreadCount() async {
    final raw = await _api.notificationsUnreadCount();
    final res = (raw as Map?)?.cast<String, dynamic>() ?? const {};
    final c = res['count'];
    return c is int ? c : int.tryParse('$c') ?? 0;
  }

  /// Fetch the inbox from `/v1/notifications` and map backend rows into
  /// the Flutter `FeloNotification` union types. Wave 2B-1 maps every
  /// row to [SystemMessageNotification] because the backend doesn't yet
  /// emit typed metadata (budgetId, goalId, etc.); a follow-up will add a
  /// `meta` JSON column on the backend so `BudgetAlertNotification` /
  /// `GoalMilestoneNotification` can be reconstructed.
  Future<List<FeloNotification>> list({bool unreadOnly = false}) async {
    final raw = await _api.listNotifications(unreadOnly: unreadOnly);
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_notificationFromApi).toList(growable: false);
  }

  Future<void> markRead(String id) async {
    await _api.markNotificationRead(id);
  }

  Future<void> markAllRead() async {
    await _api.markAllNotificationsRead();
  }

  Future<void> archive(String id) async {
    await _api.deleteNotification(id);
  }

  /// Debug-only helper used by `/notifications/test`. Backend returns
  /// 403 in production so this can't be abused.
  Future<void> sendTest({
    required String title,
    required String body,
    String channel = 'inapp',
    String type = 'system',
  }) async {
    await _api.listNotifications().catchError((_) => <Map<String, dynamic>>[]);
    // Best-effort POST; the backend's gate handles prod safety.
    await ref.read(dioProvider).post('/notifications', data: {
      'channel': channel,
      'type': type,
      'title': title,
      'body': body,
    });
  }
}

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
  // Wave 2B-1: every backend notification renders as SystemMessage.
  // Backend `type` and `body` aren't yet rich enough to reconstruct the
  // typed unions; the screen's SystemMessage branch uses i18n copy.
  return FeloNotification.systemMessage(
    id: id,
    createdAt: createdAt,
    isRead: isRead,
    archived: archived,
  );
}

/// Registers the current device so the backend can target push later.
/// Idempotent — safe to call on every app launch.
@riverpod
class DeviceRegistration extends _$DeviceRegistration {
  @override
  Future<void> build() async {
    // Lazy — only runs when register() is called.
  }

  Future<void> register({
    required String platform, // 'ios' | 'android' | 'web'
    required String pushToken,
  }) async {
    final api = FeloApiClient(ref.read(dioProvider));
    await api.registerDevice({'platform': platform, 'pushToken': pushToken});
  }

  Future<List<Map<String, dynamic>>> listMyDevices() async {
    final api = FeloApiClient(ref.read(dioProvider));
    final raw = await api.listDevices();
    return (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
  }

  Future<void> unregister(String deviceId) async {
    final api = FeloApiClient(ref.read(dioProvider));
    await api.unregisterDevice(deviceId);
  }
}
