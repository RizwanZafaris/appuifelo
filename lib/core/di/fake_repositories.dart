import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/features/accounts/data/accounts_repository.dart';
import 'package:felo/features/accounts/domain/felo_account.dart';
import 'package:felo/features/auth/domain/app_user.dart';
import 'package:felo/features/budgets/data/budgets_repository.dart';
import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/features/goals/data/goals_repository.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/features/family/data/family_repository.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/features/kyc/data/kyc_repository.dart';
import 'package:felo/features/notifications/data/notifications_repository.dart';
import 'package:felo/features/notifications/data/live_notifications_service.dart';
import 'package:felo/features/notifications/domain/felo_notification.dart';
import 'package:felo/features/receipt_capture/data/receipt_capture_repository.dart';
import 'package:felo/features/receipt_capture/domain/receipt_capture.dart';
import 'package:felo/features/sms_parser/data/sms_parser_repository.dart';
import 'package:felo/features/sms_parser/domain/parsed_sms.dart';
import 'package:felo/features/transactions/data/transactions_repository.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';
import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';

part 'fake_repositories.g.dart';

// ============================================================================
// AUTH
// ============================================================================

class AuthRepository {
  final dynamic _supabase;

  AuthRepository({dynamic supabase}) : _supabase = supabase;

  AppUser? currentUser() {
    try {
      final user = _supabase?.auth?.currentUser;
      if (user != null) {
        final meta = user.userMetadata ?? {};
        final corridorStr = meta['corridor'] ?? 'other';
        return AppUser(
          id: user.id,
          displayName: meta['display_name'] ?? user.email ?? 'User',
          email: user.email ?? '',
          corridor: corridorStr == 'canada'
              ? UserCorridor.canada
              : corridorStr == 'pakistan'
                  ? UserCorridor.pakistan
                  : UserCorridor.canada,
          languageCode: meta['language_code'] ?? 'en',
          createdAt: user.createdAt != null
              ? DateTime.parse(user.createdAt)
              : DateTime.now(),
        );
      }
    } catch (_) {}
    return null;
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository();

@riverpod
AppUser? currentUser(CurrentUserRef ref) =>
    ref.watch(authRepositoryProvider).currentUser();

// ============================================================================
// FAMILY
// ============================================================================

@riverpod
FamilyRepository familyRepository(FamilyRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeFamilyRepository();
  }
  return ApiFamilyRepository(ref.watch(feloApiClientProvider));
}

@riverpod
Future<List<FamilyGroup>> familyGroups(FamilyGroupsRef ref) {
  return ref.watch(familyRepositoryProvider).listGroups();
}

@riverpod
Future<FamilyGroup> familyGroup(FamilyGroupRef ref, String groupId) {
  return ref.watch(familyRepositoryProvider).getGroup(groupId);
}

@riverpod
Future<List<FamilyMember>> familyMembers(FamilyMembersRef ref, String groupId) {
  return ref.watch(familyRepositoryProvider).listMembers(groupId);
}

// ============================================================================
// KYC
// ============================================================================

@riverpod
KycRepository kycRepository(KycRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeKycRepository();
  }
  return ApiKycRepository(ref.watch(feloApiClientProvider));
}

@riverpod
Future<KycStatus> kycStatus(KycStatusRef ref) {
  return ref.watch(kycRepositoryProvider).getStatus();
}

// ============================================================================
// RECEIPT CAPTURE
// ============================================================================

@riverpod
ReceiptCaptureRepository receiptCaptureRepository(
  ReceiptCaptureRepositoryRef ref,
) {
  if (FeloEnv.useFakeData) {
    return FakeReceiptCaptureRepository();
  }
  return ApiReceiptCaptureRepository(ref.watch(feloApiClientProvider));
}

@riverpod
class ReceiptCaptureSession extends _$ReceiptCaptureSession {
  @override
  ReceiptCaptureState build(String transactionId) {
    return const ReceiptCaptureState.idle();
  }

  Future<void> pick(ReceiptCaptureSource source) async {
    state = ReceiptCaptureState.processing(source: source);

    unawaited(
      ref
          .read(imagePickerProvider)
          .pickImage(
            source: source == ReceiptCaptureSource.camera
                ? ImageSource.camera
                : ImageSource.gallery,
          )
          .catchError((Object _) => null),
    );

    await Future<void>.delayed(const Duration(milliseconds: 450));
    final transactions = await ref.read(transactionsProvider.future);
    final transaction = transactions.firstWhere(
      (item) => item.id == transactionId,
    );

    final repo = ref.read(receiptCaptureRepositoryProvider);
    if (repo is FakeReceiptCaptureRepository) {
      final result = repo.mockResultFor(transaction);
      state = ReceiptCaptureState.ready(result: result);
    } else {
      // API mode: upload then parse
      state = ReceiptCaptureState.ready(
        result: ReceiptOcrResult(
          id: 'receipt_${transaction.id}',
          transactionId: transaction.id,
          merchant: transaction.merchant,
          purchasedAt: transaction.bookedAt,
          currency: transaction.currency,
          totalMinor: transaction.amountMinor.abs(),
          lineItems: [
            ReceiptLineItem(
              name: transaction.category,
              amountMinor: (transaction.amountMinor.abs() * 0.7).round(),
            ),
          ],
          confidence: transaction.parserConfidence.clamp(0, 1),
        ),
      );
    }
  }

  void edit() {
    final current = state;
    if (current is ReceiptCaptureReady) {
      state = current.copyWith(editing: true);
    }
  }

  void applyEdit({required String merchant, required int totalMinor}) {
    final current = state;
    if (current is! ReceiptCaptureReady) {
      return;
    }

    state = current.copyWith(
      editing: false,
      result: current.result.copyWith(
        merchant: merchant,
        totalMinor: totalMinor,
      ),
    );
  }

  void discard() {
    state = const ReceiptCaptureState.idle();
  }

  Future<void> confirm() async {
    final current = state;
    if (current is! ReceiptCaptureReady) {
      return;
    }

    await ref
        .read(transactionsProvider.notifier)
        .attachReceipt(
          transactionId: current.result.transactionId,
          receiptId: current.result.id,
        );
    state = ReceiptCaptureState.confirmed(result: current.result);
  }
}

// ============================================================================
// SMS PARSER
// ============================================================================

@riverpod
SmsParserRepository smsParserRepository(SmsParserRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeSmsParserRepository();
  }
  return ApiSmsParserRepository(ref.watch(feloApiClientProvider));
}

@riverpod
Future<List<ParsedSms>> parsedSmsMessages(ParsedSmsMessagesRef ref) {
  return ref.watch(smsParserRepositoryProvider).listIngestionLog();
}

// ============================================================================
// NOTIFICATIONS
// ============================================================================

@riverpod
NotificationsRepository notificationsRepository(
  NotificationsRepositoryRef ref,
) {
  if (FeloEnv.useFakeData) {
    return FakeNotificationsRepository();
  }
  return ApiNotificationsRepository(ref.watch(feloApiClientProvider));
}

/// Live notifications fetcher — only used in non-fake mode.
@riverpod
Future<List<FeloNotification>> liveNotifications(
  LiveNotificationsRef ref,
) async {
  final service = ref.watch(liveNotificationsServiceProvider.notifier);
  return service.list();
}

/// Source-of-truth selector for the notifications inbox.
@riverpod
bool useFakeNotificationsSource(UseFakeNotificationsSourceRef ref) {
  return FeloEnv.useFakeData;
}

@riverpod
class NotificationInbox extends _$NotificationInbox {
  @override
  List<FeloNotification> build() {
    if (ref.watch(useFakeNotificationsSourceProvider)) {
      final budgetsAsync = ref.watch(budgetsProvider);
      final goalsAsync = ref.watch(goalsProvider);
      return ref
          .watch(notificationsRepositoryProvider)
          .seedNotifications(
            budgets: budgetsAsync.valueOrNull ?? const <Budget>[],
            goals: goalsAsync.valueOrNull ?? const <Goal>[],
            parsedSmsMessages: const <ParsedSms>[],
            familyMembers: const <FamilyMember>[],
          );
    }
    return ref.watch(liveNotificationsProvider).valueOrNull ??
        const <FeloNotification>[];
  }

  Future<void> markAsRead(String notificationId) async {
    state = [
      for (final notification in state)
        if (notification.id == notificationId)
          notification.copyWith(isRead: true)
        else
          notification,
    ];
    if (!ref.read(useFakeNotificationsSourceProvider)) {
      await ref
          .read(liveNotificationsServiceProvider.notifier)
          .markRead(notificationId);
    }
  }

  Future<void> markAllRead() async {
    state = [
      for (final notification in state) notification.copyWith(isRead: true),
    ];
    if (!ref.read(useFakeNotificationsSourceProvider)) {
      await ref.read(liveNotificationsServiceProvider.notifier).markAllRead();
    }
  }

  Future<void> archive(String notificationId) async {
    state = [
      for (final notification in state)
        if (notification.id == notificationId)
          notification.copyWith(archived: true)
        else
          notification,
    ];
    if (!ref.read(useFakeNotificationsSourceProvider)) {
      await ref
          .read(liveNotificationsServiceProvider.notifier)
          .archive(notificationId);
    }
  }
}

@riverpod
class NotificationFilter extends _$NotificationFilter {
  @override
  FeloNotificationFilter build() => FeloNotificationFilter.all;

  void select(FeloNotificationFilter filter) {
    state = filter;
  }
}

@riverpod
List<FeloNotification> filteredNotifications(FilteredNotificationsRef ref) {
  final filter = ref.watch(notificationFilterProvider);
  final notifications = ref.watch(notificationInboxProvider);
  return [
    for (final notification in notifications)
      if (!notification.archived && notification.matches(filter)) notification,
  ];
}

@riverpod
int unreadNotificationCount(UnreadNotificationCountRef ref) {
  return ref
      .watch(notificationInboxProvider)
      .where((notification) => !notification.archived && !notification.isRead)
      .length;
}

// ============================================================================
// SHARED UTILITIES
// ============================================================================

@riverpod
ImagePicker imagePicker(ImagePickerRef ref) => ImagePicker();

@riverpod
class AccountConnectFlow extends _$AccountConnectFlow {
  @override
  AccountConnectState build() => const AccountConnectState.picker();

  void selectProvider(FeloAccountProvider provider) {
    state = AccountConnectState.oauth(provider: provider);
  }

  void reset() {
    state = const AccountConnectState.picker();
  }

  Future<void> complete() async {
    final current = state;
    if (current is! AccountConnectOAuth) {
      return;
    }

    final account = await ref
        .read(accountsProvider.notifier)
        .connect(current.provider);
    state = AccountConnectState.success(account: account);
  }
}
