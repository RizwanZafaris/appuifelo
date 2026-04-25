import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/features/auth/domain/app_user.dart';
import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/features/coach/domain/coach_message.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/features/profile/domain/profile_settings.dart';
import 'package:felo/features/remittance_stub/domain/remittance_waitlist.dart';
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
        text: 'Groceries are 8% lower than last month. Your family support budget is still on pace.',
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

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository();

@riverpod
AppUser currentUser(CurrentUserRef ref) => ref.watch(authRepositoryProvider).currentUser();

@riverpod
BudgetRepository budgetRepository(BudgetRepositoryRef ref) => BudgetRepository();

@riverpod
List<Budget> budgets(BudgetsRef ref) => ref.watch(budgetRepositoryProvider).listBudgets();

@riverpod
GoalRepository goalRepository(GoalRepositoryRef ref) => GoalRepository();

@riverpod
List<Goal> goals(GoalsRef ref) => ref.watch(goalRepositoryProvider).listGoals();

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  return TransactionRepository();
}

@riverpod
List<FeloTransaction> transactions(TransactionsRef ref) {
  return ref.watch(transactionRepositoryProvider).listTransactions();
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
FamilyRepository familyRepository(FamilyRepositoryRef ref) => FamilyRepository();

@riverpod
List<FamilyMember> familyMembers(FamilyMembersRef ref) {
  return ref.watch(familyRepositoryProvider).members();
}

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) => ProfileRepository();

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
