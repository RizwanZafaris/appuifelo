// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'felo_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetAlertNotification _$BudgetAlertNotificationFromJson(
  Map<String, dynamic> json,
) => BudgetAlertNotification(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  budgetId: json['budgetId'] as String,
  thresholdPercent: (json['thresholdPercent'] as num).toInt(),
  isRead: json['isRead'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$BudgetAlertNotificationToJson(
  BudgetAlertNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'budgetId': instance.budgetId,
  'thresholdPercent': instance.thresholdPercent,
  'isRead': instance.isRead,
  'archived': instance.archived,
  'type': instance.$type,
};

GoalMilestoneNotification _$GoalMilestoneNotificationFromJson(
  Map<String, dynamic> json,
) => GoalMilestoneNotification(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  goalId: json['goalId'] as String,
  progressPercent: (json['progressPercent'] as num).toInt(),
  isRead: json['isRead'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$GoalMilestoneNotificationToJson(
  GoalMilestoneNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'goalId': instance.goalId,
  'progressPercent': instance.progressPercent,
  'isRead': instance.isRead,
  'archived': instance.archived,
  'type': instance.$type,
};

SmsParserEventNotification _$SmsParserEventNotificationFromJson(
  Map<String, dynamic> json,
) => SmsParserEventNotification(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  parsedSmsId: json['parsedSmsId'] as String,
  confidencePercent: (json['confidencePercent'] as num).toInt(),
  isRead: json['isRead'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SmsParserEventNotificationToJson(
  SmsParserEventNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'parsedSmsId': instance.parsedSmsId,
  'confidencePercent': instance.confidencePercent,
  'isRead': instance.isRead,
  'archived': instance.archived,
  'type': instance.$type,
};

FamilyActivityNotification _$FamilyActivityNotificationFromJson(
  Map<String, dynamic> json,
) => FamilyActivityNotification(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  memberId: json['memberId'] as String,
  isRead: json['isRead'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$FamilyActivityNotificationToJson(
  FamilyActivityNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'memberId': instance.memberId,
  'isRead': instance.isRead,
  'archived': instance.archived,
  'type': instance.$type,
};

SystemMessageNotification _$SystemMessageNotificationFromJson(
  Map<String, dynamic> json,
) => SystemMessageNotification(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isRead: json['isRead'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SystemMessageNotificationToJson(
  SystemMessageNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'isRead': instance.isRead,
  'archived': instance.archived,
  'type': instance.$type,
};
