import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/features/accounts/data/accounts_repository.dart';
import 'package:felo/features/accounts/domain/felo_account.dart';
import 'package:felo/features/auth/domain/app_user.dart';
import 'package:felo/features/bills/data/bills_repository.dart';
import 'package:felo/features/bills/domain/bill.dart';
import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/features/coach/domain/coach_message.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/features/notifications/data/notifications_repository.dart';
import 'package:felo/features/notifications/domain/felo_notification.dart';
import 'package:felo/features/profile/domain/profile_settings.dart';
import 'package:felo/features/receipt_capture/data/receipt_capture_repository.dart';
import 'package:felo/features/receipt_capture/domain/receipt_capture.dart';
import 'package:felo/features/remittance_stub/domain/remittance_waitlist.dart';
import 'package:felo/features/send_money/data/send_money_repository.dart';
import 'package:felo/features/send_money/domain/send_money.dart';
import 'package:felo/features/sms_parser/domain/parsed_sms.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';

part 'fake_repositories.g.dart';

class AuthRepository {
  AppUser currentUser() {
    return AppUser(
      id: 'user_rizwan',
      displayName: 'Rizwan Zafar',
      email: 'rizwan@example.com',
      corridor: UserCorridor.canada,
      languageCode: 'en',
      createdAt: DateTime(2026, 4, 24),
    );
  }
}

class BudgetRepository {
  List<Budget> listBudgets() {
    return const [
      Budget(
        id: 'budget_groceries',
        category: 'Groceries',
        currency: 'CAD',
        limitMinor: 90000,
        spentMinor: 62400,
        period: BudgetPeriod.monthly,
        rolloverEnabled: true,
        alertThresholdPercent: 80,
      ),
      Budget(
        id: 'budget_family',
        category: 'Family support',
        currency: 'CAD',
        limitMinor: 120000,
        spentMinor: 83000,
        period: BudgetPeriod.monthly,
        rolloverEnabled: false,
        alertThresholdPercent: 85,
      ),
      Budget(
        id: 'budget_transport',
        category: 'Transport',
        currency: 'CAD',
        limitMinor: 45000,
        spentMinor: 31800,
        period: BudgetPeriod.monthly,
        rolloverEnabled: true,
        alertThresholdPercent: 75,
      ),
    ];
  }
}

class GoalRepository {
  List<Goal> listGoals() {
    return [
      Goal(
        id: 'goal_trip',
        name: 'Trip to Pakistan',
        currency: 'CAD',
        targetMinor: 520000,
        savedMinor: 318000,
        targetDate: DateTime(2026, 12, 15),
        shared: true,
        cadence: GoalCadence.weekly,
        contributorNames: const ['Rizwan', 'Amina'],
      ),
      Goal(
        id: 'goal_emergency',
        name: 'Emergency buffer',
        currency: 'CAD',
        targetMinor: 300000,
        savedMinor: 122000,
        targetDate: DateTime(2026, 9, 30),
        shared: false,
        cadence: GoalCadence.manual,
        contributorNames: const ['Rizwan'],
      ),
    ];
  }
}

class TransactionRepository {
  List<FeloTransaction> listTransactions() {
    return [
      FeloTransaction(
        id: 'txn_001',
        accountId: 'acct_td_chequing',
        merchant: 'Imtiaz Super Market',
        category: 'Groceries',
        currency: 'PKR',
        amountMinor: 485000,
        direction: TransactionDirection.debit,
        source: TransactionSource.sms,
        parserConfidence: 0.88,
        bookedAt: DateTime(2026, 4, 22, 12, 20),
      ),
      FeloTransaction(
        id: 'txn_002',
        accountId: 'acct_rbc_mastercard',
        merchant: 'No Frills',
        category: 'Groceries',
        currency: 'CAD',
        amountMinor: 8422,
        direction: TransactionDirection.debit,
        source: TransactionSource.manual,
        parserConfidence: 1,
        bookedAt: DateTime(2026, 4, 21, 18, 4),
      ),
      FeloTransaction(
        id: 'txn_003',
        accountId: 'acct_td_chequing',
        merchant: 'Payroll deposit',
        category: 'Income',
        currency: 'CAD',
        amountMinor: 420000,
        direction: TransactionDirection.credit,
        source: TransactionSource.bankAlert,
        parserConfidence: 0.96,
        bookedAt: DateTime(2026, 4, 19, 9, 0),
      ),
    ];
  }
}

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

class FakeAccountsRepository implements AccountsRepository {
  @override
  List<FeloAccount> seedAccounts() {
    return [
      FeloAccount(
        id: 'acct_td_chequing',
        provider: FeloAccountProvider.td,
        type: FeloAccountType.bank,
        displayName: 'TD Chequing',
        currency: 'CAD',
        balanceMinor: 428000,
        lastSyncedAt: DateTime(2026, 4, 25, 8, 45),
        syncStatus: FeloAccountSyncStatus.synced,
      ),
      FeloAccount(
        id: 'acct_rbc_mastercard',
        provider: FeloAccountProvider.rbc,
        type: FeloAccountType.card,
        displayName: 'RBC Mastercard',
        currency: 'CAD',
        balanceMinor: -8422,
        lastSyncedAt: DateTime(2026, 4, 24, 21, 10),
        syncStatus: FeloAccountSyncStatus.needsReview,
      ),
      FeloAccount(
        id: 'acct_easypaisa',
        provider: FeloAccountProvider.easypaisa,
        type: FeloAccountType.wallet,
        displayName: 'Easypaisa wallet',
        currency: 'PKR',
        balanceMinor: 1865000,
        lastSyncedAt: DateTime(2026, 4, 24, 15, 45),
        syncStatus: FeloAccountSyncStatus.syncing,
      ),
    ];
  }

  @override
  FeloAccount connectedAccountFor({
    required FeloAccountProvider provider,
    required int sequence,
  }) {
    final now = DateTime(2026, 4, 25, 10, 30);
    return switch (provider) {
      FeloAccountProvider.td => FeloAccount(
        id: 'acct_td_connected_$sequence',
        provider: provider,
        type: FeloAccountType.bank,
        displayName: 'TD Canada Trust',
        currency: 'CAD',
        balanceMinor: 215000,
        lastSyncedAt: now,
        syncStatus: FeloAccountSyncStatus.synced,
      ),
      FeloAccountProvider.rbc => FeloAccount(
        id: 'acct_rbc_connected_$sequence',
        provider: provider,
        type: FeloAccountType.card,
        displayName: 'RBC card',
        currency: 'CAD',
        balanceMinor: -32450,
        lastSyncedAt: now,
        syncStatus: FeloAccountSyncStatus.synced,
      ),
      FeloAccountProvider.easypaisa => FeloAccount(
        id: 'acct_easypaisa_connected_$sequence',
        provider: provider,
        type: FeloAccountType.wallet,
        displayName: 'Easypaisa wallet',
        currency: 'PKR',
        balanceMinor: 920000,
        lastSyncedAt: now,
        syncStatus: FeloAccountSyncStatus.synced,
      ),
      FeloAccountProvider.jazzcash => FeloAccount(
        id: 'acct_jazzcash_connected_$sequence',
        provider: provider,
        type: FeloAccountType.wallet,
        displayName: 'JazzCash wallet',
        currency: 'PKR',
        balanceMinor: 610000,
        lastSyncedAt: now,
        syncStatus: FeloAccountSyncStatus.synced,
      ),
      FeloAccountProvider.manual => FeloAccount(
        id: 'acct_manual_connected_$sequence',
        provider: provider,
        type: FeloAccountType.bank,
        displayName: 'Manual account',
        currency: 'CAD',
        balanceMinor: 0,
        lastSyncedAt: now,
        syncStatus: FeloAccountSyncStatus.synced,
      ),
    };
  }
}

class FakeBillsRepository implements BillsRepository {
  @override
  List<Bill> seedBills() {
    return [
      Bill(
        id: 'bill_k_electric',
        name: 'K-Electric',
        category: BillCategory.utility,
        dueDate: DateTime(2026, 4, 28),
        currency: 'PKR',
        amountMinor: 124000,
        autoPayEnabled: false,
        source: BillSource.sms,
        status: BillStatus.upcoming,
      ),
      Bill(
        id: 'bill_mobile',
        name: 'Mobile plan',
        category: BillCategory.telecom,
        dueDate: DateTime(2026, 5, 2),
        currency: 'CAD',
        amountMinor: 5800,
        autoPayEnabled: true,
        source: BillSource.manual,
        status: BillStatus.upcoming,
      ),
      Bill(
        id: 'bill_rent',
        name: 'Rent',
        category: BillCategory.rent,
        dueDate: DateTime(2026, 5, 1),
        currency: 'CAD',
        amountMinor: 210000,
        autoPayEnabled: false,
        source: BillSource.manual,
        status: BillStatus.upcoming,
      ),
      Bill(
        id: 'bill_streaming',
        name: 'Streaming',
        category: BillCategory.subscription,
        dueDate: DateTime(2026, 4, 24),
        currency: 'CAD',
        amountMinor: 1699,
        autoPayEnabled: true,
        source: BillSource.manual,
        status: BillStatus.paid,
      ),
    ];
  }

  @override
  Bill createManualBill({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
  }) {
    return Bill(
      id: 'bill_manual_${name.hashCode.abs()}',
      name: name,
      category: BillCategory.subscription,
      dueDate: dueDate,
      currency: 'CAD',
      amountMinor: amountMinor,
      autoPayEnabled: false,
      source: BillSource.manual,
      status: BillStatus.upcoming,
    );
  }
}

class FakeSendMoneyRepository implements SendMoneyRepository {
  static const double _mockCadToPkrRate = 205.5;

  @override
  List<SendRecipient> savedRecipients() {
    return const [
      SendRecipient(
        id: 'recipient_ali',
        displayName: 'Ali Reza',
        phoneMasked: '+92 300 *** 4412',
        countryCode: 'PK',
      ),
      SendRecipient(
        id: 'recipient_sara',
        displayName: 'Sara Khan',
        phoneMasked: '+92 321 *** 8821',
        countryCode: 'PK',
      ),
    ];
  }

  @override
  SendMoneyQuote quoteForAmountMinor(int sourceAmountMinor) {
    final sourceMajor = sourceAmountMinor / 100;
    return SendMoneyQuote(
      sourceCurrency: 'CAD',
      targetCurrency: 'PKR',
      sourceAmountMinor: sourceAmountMinor,
      targetAmountMinor: (sourceMajor * _mockCadToPkrRate * 100).round(),
      rate: _mockCadToPkrRate,
    );
  }

  @override
  String referenceFor(SendMoneyDraft draft) {
    final recipientId = draft.recipient?.id.hashCode.abs() ?? 0;
    final amount = draft.quote?.sourceAmountMinor ?? 0;
    return 'FLO-${recipientId % 10000}-${amount % 100000}';
  }
}

class SmsParserRepository {
  List<ParsedSms> recentParses() {
    return [
      ParsedSms(
        id: 'sms_001',
        source: 'Easypaisa',
        body: 'Amount Rs. 2,500 sent to Ali Reza.',
        amount: 2500,
        currency: 'PKR',
        merchant: 'Ali Reza',
        category: 'Family',
        confidence: 0.94,
        parsedAt: DateTime(2026, 4, 24, 15, 45),
      ),
      ParsedSms(
        id: 'sms_002',
        source: 'JazzCash',
        body: 'You paid Rs. 1,240 to K-Electric.',
        amount: 1240,
        currency: 'PKR',
        merchant: 'K-Electric',
        category: 'Bills',
        confidence: 0.91,
        parsedAt: DateTime(2026, 4, 23, 19, 12),
      ),
    ];
  }
}

class CoachRepository {
  List<CoachMessage> seedMessages() {
    return [
      CoachMessage(
        id: 'coach_system',
        author: CoachMessageAuthor.system,
        text: 'Education only. I can explain patterns, not give advice.',
        createdAt: DateTime(2026, 4, 24, 8),
        adviceBoundaryVisible: true,
      ),
      CoachMessage(
        id: 'coach_001',
        author: CoachMessageAuthor.coach,
        text:
            'Groceries are 8% lower than last month. Your family support budget is still on pace.',
        createdAt: DateTime(2026, 4, 24, 8, 1),
        adviceBoundaryVisible: true,
      ),
    ];
  }
}

class FamilyRepository {
  List<FamilyMember> members() {
    return const [
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
    ];
  }
}

class ProfileRepository {
  ProfileSettings settings() {
    return const ProfileSettings(
      languageCode: 'en',
      themeMode: FeloThemeMode.dark,
      operationalNotifications: true,
      marketingConsent: false,
      smsParserEnabled: true,
    );
  }
}

class RemittanceRepository {
  RemittanceWaitlist waitlist() {
    return RemittanceWaitlist(
      id: 'waitlist_ca_pk',
      corridor: 'CA to PK',
      joined: false,
      updatedAt: DateTime(2026, 4, 24),
    );
  }
}

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
AppUser currentUser(CurrentUserRef ref) =>
    ref.watch(authRepositoryProvider).currentUser();

@riverpod
BudgetRepository budgetRepository(BudgetRepositoryRef ref) =>
    BudgetRepository();

@riverpod
List<Budget> budgets(BudgetsRef ref) =>
    ref.watch(budgetRepositoryProvider).listBudgets();

@riverpod
GoalRepository goalRepository(GoalRepositoryRef ref) => GoalRepository();

@riverpod
List<Goal> goals(GoalsRef ref) => ref.watch(goalRepositoryProvider).listGoals();

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  return TransactionRepository();
}

@riverpod
class Transactions extends _$Transactions {
  @override
  List<FeloTransaction> build() {
    return ref.watch(transactionRepositoryProvider).listTransactions();
  }

  void attachReceipt({
    required String transactionId,
    required String receiptId,
  }) {
    state = [
      for (final transaction in state)
        if (transaction.id == transactionId)
          transaction.copyWith(receiptId: receiptId)
        else
          transaction,
    ];
  }
}

@riverpod
SmsParserRepository smsParserRepository(SmsParserRepositoryRef ref) {
  return SmsParserRepository();
}

@riverpod
List<ParsedSms> parsedSmsMessages(ParsedSmsMessagesRef ref) {
  return ref.watch(smsParserRepositoryProvider).recentParses();
}

@riverpod
CoachRepository coachRepository(CoachRepositoryRef ref) => CoachRepository();

@riverpod
List<CoachMessage> coachMessages(CoachMessagesRef ref) {
  return ref.watch(coachRepositoryProvider).seedMessages();
}

@riverpod
FamilyRepository familyRepository(FamilyRepositoryRef ref) =>
    FamilyRepository();

@riverpod
List<FamilyMember> familyMembers(FamilyMembersRef ref) {
  return ref.watch(familyRepositoryProvider).members();
}

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) =>
    ProfileRepository();

@riverpod
ProfileSettings profileSettings(ProfileSettingsRef ref) {
  return ref.watch(profileRepositoryProvider).settings();
}

@riverpod
RemittanceRepository remittanceRepository(RemittanceRepositoryRef ref) {
  return RemittanceRepository();
}

@riverpod
RemittanceWaitlist remittanceWaitlist(RemittanceWaitlistRef ref) {
  return ref.watch(remittanceRepositoryProvider).waitlist();
}

@riverpod
NotificationsRepository notificationsRepository(
  NotificationsRepositoryRef ref,
) {
  return FakeNotificationsRepository();
}

@riverpod
class NotificationInbox extends _$NotificationInbox {
  @override
  List<FeloNotification> build() {
    return ref
        .watch(notificationsRepositoryProvider)
        .seedNotifications(
          budgets: ref.watch(budgetsProvider),
          goals: ref.watch(goalsProvider),
          parsedSmsMessages: ref.watch(parsedSmsMessagesProvider),
          familyMembers: ref.watch(familyMembersProvider),
        );
  }

  void markAsRead(String notificationId) {
    state = [
      for (final notification in state)
        if (notification.id == notificationId)
          notification.copyWith(isRead: true)
        else
          notification,
    ];
  }

  void markAllRead() {
    state = [
      for (final notification in state) notification.copyWith(isRead: true),
    ];
  }

  void archive(String notificationId) {
    state = [
      for (final notification in state)
        if (notification.id == notificationId)
          notification.copyWith(archived: true)
        else
          notification,
    ];
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
    final transaction = ref
        .read(transactionsProvider)
        .firstWhere((item) => item.id == transactionId);
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

  void confirm() {
    final current = state;
    if (current is! ReceiptCaptureReady) {
      return;
    }

    ref
        .read(transactionsProvider.notifier)
        .attachReceipt(
          transactionId: current.result.transactionId,
          receiptId: current.result.id,
        );
    state = ReceiptCaptureState.confirmed(result: current.result);
  }
}

@riverpod
AccountsRepository accountsRepository(AccountsRepositoryRef ref) {
  return FakeAccountsRepository();
}

@riverpod
class Accounts extends _$Accounts {
  @override
  List<FeloAccount> build() {
    return ref.watch(accountsRepositoryProvider).seedAccounts();
  }

  FeloAccount connect(FeloAccountProvider provider) {
    final account = ref
        .read(accountsRepositoryProvider)
        .connectedAccountFor(provider: provider, sequence: state.length + 1);
    state = [account, ...state];
    return account;
  }

  void disconnect(String accountId) {
    state = [
      for (final account in state)
        if (account.id != accountId) account,
    ];
  }
}

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

  void complete() {
    final current = state;
    if (current is! AccountConnectOAuth) {
      return;
    }

    final account = ref
        .read(accountsProvider.notifier)
        .connect(current.provider);
    state = AccountConnectState.success(account: account);
  }
}

@riverpod
BillsRepository billsRepository(BillsRepositoryRef ref) {
  return FakeBillsRepository();
}

@riverpod
class Bills extends _$Bills {
  @override
  List<Bill> build() => ref.watch(billsRepositoryProvider).seedBills();

  void addManualBill({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
  }) {
    final bill = ref
        .read(billsRepositoryProvider)
        .createManualBill(
          name: name,
          amountMinor: amountMinor,
          dueDate: dueDate,
        );
    state = [bill, ...state];
  }

  void markPaid(String billId) {
    state = [
      for (final bill in state)
        if (bill.id == billId) bill.copyWith(status: BillStatus.paid) else bill,
    ];
  }
}

@riverpod
SendMoneyRepository sendMoneyRepository(SendMoneyRepositoryRef ref) {
  return FakeSendMoneyRepository();
}

@riverpod
List<SendRecipient> sendRecipients(SendRecipientsRef ref) {
  return ref.watch(sendMoneyRepositoryProvider).savedRecipients();
}

@riverpod
class SendMoneyFlow extends _$SendMoneyFlow {
  @override
  SendMoneyDraft build() => const SendMoneyDraft();

  void selectRecipient(SendRecipient recipient) {
    state = state.copyWith(recipient: recipient);
  }

  SendRecipient addRecipient({
    required String displayName,
    required String phoneMasked,
  }) {
    final recipient = SendRecipient(
      id: 'recipient_manual_${displayName.hashCode.abs()}',
      displayName: displayName,
      phoneMasked: phoneMasked,
      countryCode: 'PK',
    );
    state = state.copyWith(recipient: recipient);
    return recipient;
  }

  void setAmountMinor(int amountMinor) {
    final quote = ref.read(sendMoneyRepositoryProvider).quoteForAmountMinor(
          amountMinor,
        );
    state = state.copyWith(quote: quote);
  }

  void completePreview() {
    final referenceId = ref.read(sendMoneyRepositoryProvider).referenceFor(state);
    state = state.copyWith(referenceId: referenceId);
  }

  void reset() {
    state = const SendMoneyDraft();
  }
}
