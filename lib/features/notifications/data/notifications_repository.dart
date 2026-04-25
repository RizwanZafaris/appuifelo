import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/features/notifications/domain/felo_notification.dart';
import 'package:felo/features/sms_parser/domain/parsed_sms.dart';

abstract class NotificationsRepository {
  List<FeloNotification> seedNotifications({
    required List<Budget> budgets,
    required List<Goal> goals,
    required List<ParsedSms> parsedSmsMessages,
    required List<FamilyMember> familyMembers,
  });
}
