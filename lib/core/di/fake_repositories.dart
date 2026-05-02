import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/features/accounts/data/accounts_repository.dart';
import 'package:felo/features/accounts/domain/felo_account.dart';
import 'package:felo/features/auth/domain/app_user.dart';
// Bills moved to lib/features/bills/data/bills_repository.dart
import 'package:felo/features/budgets/data/budgets_repository.dart';
import 'package:felo/features/budgets/domain/budget.dart';
// Coach domain moved out of fake_repositories — see coach_conversation_controller.dart
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/features/goals/data/goals_repository.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/core/config/felo_env.dart';
import 'package:felo/features/notifications/data/live_notifications_service.dart';
import 'package:felo/features/notifications/data/notifications_repository.dart';
import 'package:felo/features/notifications/domain/felo_notification.dart';
// Profile moved to lib/features/profile/data/profile_repository.dart
import 'package:felo/features/receipt_capture/data/receipt_capture_repository.dart';
import 'package:felo/features/receipt_capture/domain/receipt_capture.dart';
// remittance_stub/ and send_money/ removed in launch-readiness pass.
// The fakes for those flows are deleted; the manual remittance notebook
// is the only shipping flow until the live remittance UI lands.
import 'package:felo/features/sms_parser/domain/parsed_sms.dart';
// Splits moved to lib/features/splits/data/splits_repository.dart
import 'package:felo/features/transactions/data/transactions_repository.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';

part 'fake_repositories.g.dart';

class AuthRepository {
  final dynamic _supabase;

  AuthRepository({dynamic supabase}) : _supabase = supabase;

  AppUser? currentUser() {
    // Try Supabase first if available
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
    } catch (_) {
      // Supabase not available — return null so callers handle gracefully
    }
    return null;
  }
}

// Phase-1 BudgetRepository / GoalRepository / TransactionRepository moved
// into per-feature data layers:
//   • lib/features/budgets/data/budgets_repository.dart
//   • lib/features/goals/data/goals_repository.dart
//   • lib/features/transactions/data/transactions_repository.dart
// Each now exposes both an Api-backed and a Fake-backed implementation,
// switched by `FeloEnv.useFakeData`.

class FakeReceiptCaptureRepository implements ReceiptCaptureRepository {
  @override
  ReceiptOcrResult mockResultFor(FeloTransaction transaction) {
    final totalMinor = transaction.amountMinor.abs();
    final primaryLineMinor = (totalMinor * 0.7).round();
    final secondaryLineMinor = totalMinor - primaryLineMinor;

    return ReceiptOcrResult(
      id: 'receipt_${transaction.id}',
      transactionId: transaction.id,
      merchant: transaction.merchant,
      purchasedAt: transaction.bookedAt,
      currency: transaction.currency,
      totalMinor: totalMinor,
      lineItems: [
        ReceiptLineItem(
          name: transaction.category,
          amountMinor: primaryLineMinor,
        ),
        ReceiptLineItem(
          name: transaction.merchant,
          amountMinor: secondaryLineMinor,
        ),
      ],
      confidence: transaction.parserConfidence.clamp(0, 1),
    );
  }
}


// FakeSendMoneyRepository deleted with the send_money/ feature.

class SmsParserRepository {
  List<ParsedSms> recentParses() {
    return [
      ParsedSms(
        id: 'sms_001',
        source: 'Easypaisa',
        body: 'Amount Rs. 2,500 sent to Test User.',
        amount: 2500,
        currency: 'PKR',
        merchant: 'Test User',
        category: 'Family',
        confidence: 0.94,
        parsedAt: DateTime(2026, 4, 24, 15, 45),
      ),
      ParsedSms(
        id: 'sms_002',
        source: 'JazzCash',
        body: 'You paid Rs. 1,240 to Demo Utility.',
        amount: 1240,
        currency: 'PKR',
        merchant: 'Demo Utility',
        category: 'Bills',
        confidence: 0.91,
        parsedAt: DateTime(2026, 4, 23, 19, 12),
      ),
    ];
  }
}

// CoachRepository removed — Coach screen now uses
// `coachConversationProvider` from lib/features/coach/application/.

class FamilyRepository {
  List<FamilyMember> members() {
    return const [
      FamilyMember(
        id: 'member_01',
        displayName: 'Test Admin',
        phoneMasked: '+1 555 *** 0001',
        role: FamilyRole.admin,
        canViewSharedTransactions: true,
        canEditSharedBudgets: true,
      ),
      FamilyMember(
        id: 'member_02',
        displayName: 'Test Member',
        phoneMasked: '+92 300 *** 0002',
        role: FamilyRole.member,
        canViewSharedTransactions: true,
        canEditSharedBudgets: false,
      ),
    ];
  }
}

// ProfileRepository moved to lib/features/profile/data/profile_repository.dart

// RemittanceRepository (waitlist stub) deleted with the remittance_stub/ feature.

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
    final firstParse = parsedSmsMessages.isEmpty
        ? null
        : parsedSmsMessages.first;
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
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository();

@riverpod
AppUser? currentUser(CurrentUserRef ref) =>
    ref.watch(authRepositoryProvider).currentUser();

// Budget / Goal / Transaction providers moved to feature-data layers.
// See: lib/features/{budgets,goals,transactions}/data/*_repository.dart

// Splits provider moved to lib/features/splits/data/splits_repository.dart

// Transactions provider moved to lib/features/transactions/data/transactions_repository.dart.

@riverpod
SmsParserRepository smsParserRepository(SmsParserRepositoryRef ref) {
  return SmsParserRepository();
}

@riverpod
List<ParsedSms> parsedSmsMessages(ParsedSmsMessagesRef ref) {
  return ref.watch(smsParserRepositoryProvider).recentParses();
}

// Coach: live conversation logic lives in
// lib/features/coach/application/coach_conversation_controller.dart
// (the screen reads `coachConversationProvider` directly). The legacy
// fake `coachMessagesProvider` was unused in screens — removed.

@riverpod
FamilyRepository familyRepository(FamilyRepositoryRef ref) =>
    FamilyRepository();

@riverpod
List<FamilyMember> familyMembers(FamilyMembersRef ref) {
  return ref.watch(familyRepositoryProvider).members();
}

// Profile moved to lib/features/profile/data/profile_repository.dart

// remittanceRepository / remittanceWaitlist providers removed —
// the underlying RemittanceWaitlist domain belonged to the deleted
// remittance_stub/ feature.

@riverpod
NotificationsRepository notificationsRepository(
  NotificationsRepositoryRef ref,
) {
  return FakeNotificationsRepository();
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
///
/// Defaults to [FeloEnv.useFakeData], but tests override this directly so
/// they can exercise the synthesis path without flipping a compile-time
/// constant.
@riverpod
bool useFakeNotificationsSource(UseFakeNotificationsSourceRef ref) {
  return FeloEnv.useFakeData;
}

@riverpod
class NotificationInbox extends _$NotificationInbox {
  @override
  List<FeloNotification> build() {
    if (ref.watch(useFakeNotificationsSourceProvider)) {
      // Fake mode: synthesize from local budgets/goals/sms/family state.
      // (Budgets/goals are async post-Wave-1; we tolerate the loading window.)
      final budgetsAsync = ref.watch(budgetsProvider);
      final goalsAsync = ref.watch(goalsProvider);
      return ref
          .watch(notificationsRepositoryProvider)
          .seedNotifications(
            budgets: budgetsAsync.valueOrNull ?? const <Budget>[],
            goals: goalsAsync.valueOrNull ?? const <Goal>[],
            parsedSmsMessages: ref.watch(parsedSmsMessagesProvider),
            familyMembers: ref.watch(familyMembersProvider),
          );
    }
    // Live mode: pull from `/v1/notifications`. Renders an empty list
    // while loading; the screen still has loading affordances.
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

@riverpod
ReceiptCaptureRepository receiptCaptureRepository(
  ReceiptCaptureRepositoryRef ref,
) {
  return FakeReceiptCaptureRepository();
}

@riverpod
ImagePicker imagePicker(ImagePickerRef ref) => ImagePicker();

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
    final result = ref
        .read(receiptCaptureRepositoryProvider)
        .mockResultFor(transaction);
    state = ReceiptCaptureState.ready(result: result);
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

// Accounts / Bills providers moved to per-feature data layers.
// See: lib/features/{accounts,bills}/data/*_repository.dart

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

// sendMoneyRepository / sendRecipients / SendMoneyFlow removed with the
// send_money/ feature. Live remittance UI will be reintroduced behind
// FeloEnv.enableLiveRemittance once the backend integration ships.
