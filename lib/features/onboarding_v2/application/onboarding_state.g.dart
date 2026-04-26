// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingState _$OnboardingStateFromJson(
  Map<String, dynamic> json,
) => _OnboardingState(
  deviceId: json['deviceId'] as String?,
  userId: json['userId'] as String?,
  sessionId: json['sessionId'] as String?,
  primaryRegion: json['primaryRegion'] as String?,
  secondaryRegions:
      (json['secondaryRegions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  name: json['name'] as String?,
  ipCountry: json['ipCountry'] as String?,
  smsGranted: json['smsGranted'] as bool?,
  notificationsGranted: json['notificationsGranted'] as bool?,
  locationGranted: json['locationGranted'] as bool?,
  contactsAck: json['contactsAck'] as bool?,
  earningTypes:
      (json['earningTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  earningTypeCustom: json['earningTypeCustom'] as String?,
  accounts:
      (json['accounts'] as List<dynamic>?)
          ?.map((e) => OnboardingAccount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OnboardingAccount>[],
  accountsDeferred: json['accountsDeferred'] as bool? ?? false,
  invests: json['invests'] as bool?,
  investmentTypes:
      (json['investmentTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  budgetTotalMinor: (json['budgetTotalMinor'] as num?)?.toInt(),
  budgetCurrency: json['budgetCurrency'] as String?,
  budgetCategories:
      (json['budgetCategories'] as List<dynamic>?)
          ?.map(
            (e) => OnboardingBudgetCategory.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <OnboardingBudgetCategory>[],
  goals:
      (json['goals'] as List<dynamic>?)
          ?.map((e) => OnboardingGoal.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OnboardingGoal>[],
  remittanceOptions:
      (json['remittanceOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  sendsTo:
      (json['sendsTo'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  receivesFrom:
      (json['receivesFrom'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  lastCompletedStep: json['lastCompletedStep'] as String?,
  lastUpdatedAt: json['lastUpdatedAt'] == null
      ? null
      : DateTime.parse(json['lastUpdatedAt'] as String),
);

Map<String, dynamic> _$OnboardingStateToJson(_OnboardingState instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'userId': instance.userId,
      'sessionId': instance.sessionId,
      'primaryRegion': instance.primaryRegion,
      'secondaryRegions': instance.secondaryRegions,
      'name': instance.name,
      'ipCountry': instance.ipCountry,
      'smsGranted': instance.smsGranted,
      'notificationsGranted': instance.notificationsGranted,
      'locationGranted': instance.locationGranted,
      'contactsAck': instance.contactsAck,
      'earningTypes': instance.earningTypes,
      'earningTypeCustom': instance.earningTypeCustom,
      'accounts': instance.accounts,
      'accountsDeferred': instance.accountsDeferred,
      'invests': instance.invests,
      'investmentTypes': instance.investmentTypes,
      'budgetTotalMinor': instance.budgetTotalMinor,
      'budgetCurrency': instance.budgetCurrency,
      'budgetCategories': instance.budgetCategories,
      'goals': instance.goals,
      'remittanceOptions': instance.remittanceOptions,
      'sendsTo': instance.sendsTo,
      'receivesFrom': instance.receivesFrom,
      'lastCompletedStep': instance.lastCompletedStep,
      'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
    };

_OnboardingAccount _$OnboardingAccountFromJson(Map<String, dynamic> json) =>
    _OnboardingAccount(
      accountKind: json['accountKind'] as String,
      providerSlug: json['providerSlug'] as String,
      regionIso2: json['regionIso2'] as String,
    );

Map<String, dynamic> _$OnboardingAccountToJson(_OnboardingAccount instance) =>
    <String, dynamic>{
      'accountKind': instance.accountKind,
      'providerSlug': instance.providerSlug,
      'regionIso2': instance.regionIso2,
    };

_OnboardingBudgetCategory _$OnboardingBudgetCategoryFromJson(
  Map<String, dynamic> json,
) => _OnboardingBudgetCategory(
  categorySlug: json['categorySlug'] as String,
  amountMinor: (json['amountMinor'] as num).toInt(),
  semantic: json['semantic'] as String,
);

Map<String, dynamic> _$OnboardingBudgetCategoryToJson(
  _OnboardingBudgetCategory instance,
) => <String, dynamic>{
  'categorySlug': instance.categorySlug,
  'amountMinor': instance.amountMinor,
  'semantic': instance.semantic,
};

_OnboardingGoal _$OnboardingGoalFromJson(Map<String, dynamic> json) =>
    _OnboardingGoal(
      slot: (json['slot'] as num).toInt(),
      templateSlug: json['templateSlug'] as String,
      customLabel: json['customLabel'] as String?,
      targetAmountMinor: (json['targetAmountMinor'] as num).toInt(),
      currency: json['currency'] as String,
      targetDate: DateTime.parse(json['targetDate'] as String),
    );

Map<String, dynamic> _$OnboardingGoalToJson(_OnboardingGoal instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'templateSlug': instance.templateSlug,
      'customLabel': instance.customLabel,
      'targetAmountMinor': instance.targetAmountMinor,
      'currency': instance.currency,
      'targetDate': instance.targetDate.toIso8601String(),
    };
