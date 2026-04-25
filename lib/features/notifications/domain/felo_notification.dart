import 'package:freezed_annotation/freezed_annotation.dart';

part 'felo_notification.freezed.dart';
part 'felo_notification.g.dart';

enum FeloNotificationCategory { budgets, goals, family, system }

enum FeloNotificationFilter { all, budgets, goals, family, system }

@Freezed(unionKey: 'type')
sealed class FeloNotification with _$FeloNotification {
  const FeloNotification._();

  const factory FeloNotification.budgetAlert({
    required String id,
    required DateTime createdAt,
    required String budgetId,
    required int thresholdPercent,
    @Default(false) bool isRead,
    @Default(false) bool archived,
  }) = BudgetAlertNotification;

  const factory FeloNotification.goalMilestone({
    required String id,
    required DateTime createdAt,
    required String goalId,
    required int progressPercent,
    @Default(false) bool isRead,
    @Default(false) bool archived,
  }) = GoalMilestoneNotification;

  const factory FeloNotification.smsParserEvent({
    required String id,
    required DateTime createdAt,
    required String parsedSmsId,
    required int confidencePercent,
    @Default(false) bool isRead,
    @Default(false) bool archived,
  }) = SmsParserEventNotification;

  const factory FeloNotification.familyActivity({
    required String id,
    required DateTime createdAt,
    required String memberId,
    @Default(false) bool isRead,
    @Default(false) bool archived,
  }) = FamilyActivityNotification;

  const factory FeloNotification.systemMessage({
    required String id,
    required DateTime createdAt,
    @Default(false) bool isRead,
    @Default(false) bool archived,
  }) = SystemMessageNotification;

  factory FeloNotification.fromJson(Map<String, Object?> json) =>
      _$FeloNotificationFromJson(json);

  FeloNotificationCategory get category {
    return switch (this) {
      BudgetAlertNotification() => FeloNotificationCategory.budgets,
      GoalMilestoneNotification() => FeloNotificationCategory.goals,
      FamilyActivityNotification() => FeloNotificationCategory.family,
      SmsParserEventNotification() ||
      SystemMessageNotification() => FeloNotificationCategory.system,
    };
  }

  bool matches(FeloNotificationFilter filter) {
    return switch (filter) {
      FeloNotificationFilter.all => true,
      FeloNotificationFilter.budgets =>
        category == FeloNotificationCategory.budgets,
      FeloNotificationFilter.goals =>
        category == FeloNotificationCategory.goals,
      FeloNotificationFilter.family =>
        category == FeloNotificationCategory.family,
      FeloNotificationFilter.system =>
        category == FeloNotificationCategory.system,
    };
  }
}
