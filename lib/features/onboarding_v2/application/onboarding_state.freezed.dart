// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingState {

/// Anonymous device id pre-Phase-1 — promoted to Supabase UUID
/// after auth.
 String? get deviceId; String? get userId; String? get sessionId;// Phase 2 — Context
 String? get primaryRegion; List<String> get secondaryRegions; String? get name; String? get ipCountry;// Phase 3 — Permissions
 bool? get smsGranted; bool? get notificationsGranted; bool? get locationGranted; bool? get contactsAck;// Phase 4 — Financial profile
 List<String> get earningTypes; String? get earningTypeCustom; List<OnboardingAccount> get accounts; bool get accountsDeferred; bool? get invests; List<String> get investmentTypes;// Phase 5 — Intent
 int? get budgetTotalMinor; String? get budgetCurrency; List<OnboardingBudgetCategory> get budgetCategories; List<OnboardingGoal> get goals;// Phase 6 — Remittance
 List<String> get remittanceOptions; List<String> get sendsTo; List<String> get receivesFrom;// Cross-cutting — D-009
 String? get lastCompletedStep; DateTime? get lastUpdatedAt;
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateCopyWith<OnboardingState> get copyWith => _$OnboardingStateCopyWithImpl<OnboardingState>(this as OnboardingState, _$identity);

  /// Serializes this OnboardingState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.primaryRegion, primaryRegion) || other.primaryRegion == primaryRegion)&&const DeepCollectionEquality().equals(other.secondaryRegions, secondaryRegions)&&(identical(other.name, name) || other.name == name)&&(identical(other.ipCountry, ipCountry) || other.ipCountry == ipCountry)&&(identical(other.smsGranted, smsGranted) || other.smsGranted == smsGranted)&&(identical(other.notificationsGranted, notificationsGranted) || other.notificationsGranted == notificationsGranted)&&(identical(other.locationGranted, locationGranted) || other.locationGranted == locationGranted)&&(identical(other.contactsAck, contactsAck) || other.contactsAck == contactsAck)&&const DeepCollectionEquality().equals(other.earningTypes, earningTypes)&&(identical(other.earningTypeCustom, earningTypeCustom) || other.earningTypeCustom == earningTypeCustom)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&(identical(other.accountsDeferred, accountsDeferred) || other.accountsDeferred == accountsDeferred)&&(identical(other.invests, invests) || other.invests == invests)&&const DeepCollectionEquality().equals(other.investmentTypes, investmentTypes)&&(identical(other.budgetTotalMinor, budgetTotalMinor) || other.budgetTotalMinor == budgetTotalMinor)&&(identical(other.budgetCurrency, budgetCurrency) || other.budgetCurrency == budgetCurrency)&&const DeepCollectionEquality().equals(other.budgetCategories, budgetCategories)&&const DeepCollectionEquality().equals(other.goals, goals)&&const DeepCollectionEquality().equals(other.remittanceOptions, remittanceOptions)&&const DeepCollectionEquality().equals(other.sendsTo, sendsTo)&&const DeepCollectionEquality().equals(other.receivesFrom, receivesFrom)&&(identical(other.lastCompletedStep, lastCompletedStep) || other.lastCompletedStep == lastCompletedStep)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,deviceId,userId,sessionId,primaryRegion,const DeepCollectionEquality().hash(secondaryRegions),name,ipCountry,smsGranted,notificationsGranted,locationGranted,contactsAck,const DeepCollectionEquality().hash(earningTypes),earningTypeCustom,const DeepCollectionEquality().hash(accounts),accountsDeferred,invests,const DeepCollectionEquality().hash(investmentTypes),budgetTotalMinor,budgetCurrency,const DeepCollectionEquality().hash(budgetCategories),const DeepCollectionEquality().hash(goals),const DeepCollectionEquality().hash(remittanceOptions),const DeepCollectionEquality().hash(sendsTo),const DeepCollectionEquality().hash(receivesFrom),lastCompletedStep,lastUpdatedAt]);

@override
String toString() {
  return 'OnboardingState(deviceId: $deviceId, userId: $userId, sessionId: $sessionId, primaryRegion: $primaryRegion, secondaryRegions: $secondaryRegions, name: $name, ipCountry: $ipCountry, smsGranted: $smsGranted, notificationsGranted: $notificationsGranted, locationGranted: $locationGranted, contactsAck: $contactsAck, earningTypes: $earningTypes, earningTypeCustom: $earningTypeCustom, accounts: $accounts, accountsDeferred: $accountsDeferred, invests: $invests, investmentTypes: $investmentTypes, budgetTotalMinor: $budgetTotalMinor, budgetCurrency: $budgetCurrency, budgetCategories: $budgetCategories, goals: $goals, remittanceOptions: $remittanceOptions, sendsTo: $sendsTo, receivesFrom: $receivesFrom, lastCompletedStep: $lastCompletedStep, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res>  {
  factory $OnboardingStateCopyWith(OnboardingState value, $Res Function(OnboardingState) _then) = _$OnboardingStateCopyWithImpl;
@useResult
$Res call({
 String? deviceId, String? userId, String? sessionId, String? primaryRegion, List<String> secondaryRegions, String? name, String? ipCountry, bool? smsGranted, bool? notificationsGranted, bool? locationGranted, bool? contactsAck, List<String> earningTypes, String? earningTypeCustom, List<OnboardingAccount> accounts, bool accountsDeferred, bool? invests, List<String> investmentTypes, int? budgetTotalMinor, String? budgetCurrency, List<OnboardingBudgetCategory> budgetCategories, List<OnboardingGoal> goals, List<String> remittanceOptions, List<String> sendsTo, List<String> receivesFrom, String? lastCompletedStep, DateTime? lastUpdatedAt
});




}
/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._self, this._then);

  final OnboardingState _self;
  final $Res Function(OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = freezed,Object? userId = freezed,Object? sessionId = freezed,Object? primaryRegion = freezed,Object? secondaryRegions = null,Object? name = freezed,Object? ipCountry = freezed,Object? smsGranted = freezed,Object? notificationsGranted = freezed,Object? locationGranted = freezed,Object? contactsAck = freezed,Object? earningTypes = null,Object? earningTypeCustom = freezed,Object? accounts = null,Object? accountsDeferred = null,Object? invests = freezed,Object? investmentTypes = null,Object? budgetTotalMinor = freezed,Object? budgetCurrency = freezed,Object? budgetCategories = null,Object? goals = null,Object? remittanceOptions = null,Object? sendsTo = null,Object? receivesFrom = null,Object? lastCompletedStep = freezed,Object? lastUpdatedAt = freezed,}) {
  return _then(_self.copyWith(
deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,primaryRegion: freezed == primaryRegion ? _self.primaryRegion : primaryRegion // ignore: cast_nullable_to_non_nullable
as String?,secondaryRegions: null == secondaryRegions ? _self.secondaryRegions : secondaryRegions // ignore: cast_nullable_to_non_nullable
as List<String>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,ipCountry: freezed == ipCountry ? _self.ipCountry : ipCountry // ignore: cast_nullable_to_non_nullable
as String?,smsGranted: freezed == smsGranted ? _self.smsGranted : smsGranted // ignore: cast_nullable_to_non_nullable
as bool?,notificationsGranted: freezed == notificationsGranted ? _self.notificationsGranted : notificationsGranted // ignore: cast_nullable_to_non_nullable
as bool?,locationGranted: freezed == locationGranted ? _self.locationGranted : locationGranted // ignore: cast_nullable_to_non_nullable
as bool?,contactsAck: freezed == contactsAck ? _self.contactsAck : contactsAck // ignore: cast_nullable_to_non_nullable
as bool?,earningTypes: null == earningTypes ? _self.earningTypes : earningTypes // ignore: cast_nullable_to_non_nullable
as List<String>,earningTypeCustom: freezed == earningTypeCustom ? _self.earningTypeCustom : earningTypeCustom // ignore: cast_nullable_to_non_nullable
as String?,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<OnboardingAccount>,accountsDeferred: null == accountsDeferred ? _self.accountsDeferred : accountsDeferred // ignore: cast_nullable_to_non_nullable
as bool,invests: freezed == invests ? _self.invests : invests // ignore: cast_nullable_to_non_nullable
as bool?,investmentTypes: null == investmentTypes ? _self.investmentTypes : investmentTypes // ignore: cast_nullable_to_non_nullable
as List<String>,budgetTotalMinor: freezed == budgetTotalMinor ? _self.budgetTotalMinor : budgetTotalMinor // ignore: cast_nullable_to_non_nullable
as int?,budgetCurrency: freezed == budgetCurrency ? _self.budgetCurrency : budgetCurrency // ignore: cast_nullable_to_non_nullable
as String?,budgetCategories: null == budgetCategories ? _self.budgetCategories : budgetCategories // ignore: cast_nullable_to_non_nullable
as List<OnboardingBudgetCategory>,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<OnboardingGoal>,remittanceOptions: null == remittanceOptions ? _self.remittanceOptions : remittanceOptions // ignore: cast_nullable_to_non_nullable
as List<String>,sendsTo: null == sendsTo ? _self.sendsTo : sendsTo // ignore: cast_nullable_to_non_nullable
as List<String>,receivesFrom: null == receivesFrom ? _self.receivesFrom : receivesFrom // ignore: cast_nullable_to_non_nullable
as List<String>,lastCompletedStep: freezed == lastCompletedStep ? _self.lastCompletedStep : lastCompletedStep // ignore: cast_nullable_to_non_nullable
as String?,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? deviceId,  String? userId,  String? sessionId,  String? primaryRegion,  List<String> secondaryRegions,  String? name,  String? ipCountry,  bool? smsGranted,  bool? notificationsGranted,  bool? locationGranted,  bool? contactsAck,  List<String> earningTypes,  String? earningTypeCustom,  List<OnboardingAccount> accounts,  bool accountsDeferred,  bool? invests,  List<String> investmentTypes,  int? budgetTotalMinor,  String? budgetCurrency,  List<OnboardingBudgetCategory> budgetCategories,  List<OnboardingGoal> goals,  List<String> remittanceOptions,  List<String> sendsTo,  List<String> receivesFrom,  String? lastCompletedStep,  DateTime? lastUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.deviceId,_that.userId,_that.sessionId,_that.primaryRegion,_that.secondaryRegions,_that.name,_that.ipCountry,_that.smsGranted,_that.notificationsGranted,_that.locationGranted,_that.contactsAck,_that.earningTypes,_that.earningTypeCustom,_that.accounts,_that.accountsDeferred,_that.invests,_that.investmentTypes,_that.budgetTotalMinor,_that.budgetCurrency,_that.budgetCategories,_that.goals,_that.remittanceOptions,_that.sendsTo,_that.receivesFrom,_that.lastCompletedStep,_that.lastUpdatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? deviceId,  String? userId,  String? sessionId,  String? primaryRegion,  List<String> secondaryRegions,  String? name,  String? ipCountry,  bool? smsGranted,  bool? notificationsGranted,  bool? locationGranted,  bool? contactsAck,  List<String> earningTypes,  String? earningTypeCustom,  List<OnboardingAccount> accounts,  bool accountsDeferred,  bool? invests,  List<String> investmentTypes,  int? budgetTotalMinor,  String? budgetCurrency,  List<OnboardingBudgetCategory> budgetCategories,  List<OnboardingGoal> goals,  List<String> remittanceOptions,  List<String> sendsTo,  List<String> receivesFrom,  String? lastCompletedStep,  DateTime? lastUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _OnboardingState():
return $default(_that.deviceId,_that.userId,_that.sessionId,_that.primaryRegion,_that.secondaryRegions,_that.name,_that.ipCountry,_that.smsGranted,_that.notificationsGranted,_that.locationGranted,_that.contactsAck,_that.earningTypes,_that.earningTypeCustom,_that.accounts,_that.accountsDeferred,_that.invests,_that.investmentTypes,_that.budgetTotalMinor,_that.budgetCurrency,_that.budgetCategories,_that.goals,_that.remittanceOptions,_that.sendsTo,_that.receivesFrom,_that.lastCompletedStep,_that.lastUpdatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? deviceId,  String? userId,  String? sessionId,  String? primaryRegion,  List<String> secondaryRegions,  String? name,  String? ipCountry,  bool? smsGranted,  bool? notificationsGranted,  bool? locationGranted,  bool? contactsAck,  List<String> earningTypes,  String? earningTypeCustom,  List<OnboardingAccount> accounts,  bool accountsDeferred,  bool? invests,  List<String> investmentTypes,  int? budgetTotalMinor,  String? budgetCurrency,  List<OnboardingBudgetCategory> budgetCategories,  List<OnboardingGoal> goals,  List<String> remittanceOptions,  List<String> sendsTo,  List<String> receivesFrom,  String? lastCompletedStep,  DateTime? lastUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.deviceId,_that.userId,_that.sessionId,_that.primaryRegion,_that.secondaryRegions,_that.name,_that.ipCountry,_that.smsGranted,_that.notificationsGranted,_that.locationGranted,_that.contactsAck,_that.earningTypes,_that.earningTypeCustom,_that.accounts,_that.accountsDeferred,_that.invests,_that.investmentTypes,_that.budgetTotalMinor,_that.budgetCurrency,_that.budgetCategories,_that.goals,_that.remittanceOptions,_that.sendsTo,_that.receivesFrom,_that.lastCompletedStep,_that.lastUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingState implements OnboardingState {
  const _OnboardingState({this.deviceId, this.userId, this.sessionId, this.primaryRegion, final  List<String> secondaryRegions = const <String>[], this.name, this.ipCountry, this.smsGranted, this.notificationsGranted, this.locationGranted, this.contactsAck, final  List<String> earningTypes = const <String>[], this.earningTypeCustom, final  List<OnboardingAccount> accounts = const <OnboardingAccount>[], this.accountsDeferred = false, this.invests, final  List<String> investmentTypes = const <String>[], this.budgetTotalMinor, this.budgetCurrency, final  List<OnboardingBudgetCategory> budgetCategories = const <OnboardingBudgetCategory>[], final  List<OnboardingGoal> goals = const <OnboardingGoal>[], final  List<String> remittanceOptions = const <String>[], final  List<String> sendsTo = const <String>[], final  List<String> receivesFrom = const <String>[], this.lastCompletedStep, this.lastUpdatedAt}): _secondaryRegions = secondaryRegions,_earningTypes = earningTypes,_accounts = accounts,_investmentTypes = investmentTypes,_budgetCategories = budgetCategories,_goals = goals,_remittanceOptions = remittanceOptions,_sendsTo = sendsTo,_receivesFrom = receivesFrom;
  factory _OnboardingState.fromJson(Map<String, dynamic> json) => _$OnboardingStateFromJson(json);

/// Anonymous device id pre-Phase-1 — promoted to Supabase UUID
/// after auth.
@override final  String? deviceId;
@override final  String? userId;
@override final  String? sessionId;
// Phase 2 — Context
@override final  String? primaryRegion;
 final  List<String> _secondaryRegions;
@override@JsonKey() List<String> get secondaryRegions {
  if (_secondaryRegions is EqualUnmodifiableListView) return _secondaryRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryRegions);
}

@override final  String? name;
@override final  String? ipCountry;
// Phase 3 — Permissions
@override final  bool? smsGranted;
@override final  bool? notificationsGranted;
@override final  bool? locationGranted;
@override final  bool? contactsAck;
// Phase 4 — Financial profile
 final  List<String> _earningTypes;
// Phase 4 — Financial profile
@override@JsonKey() List<String> get earningTypes {
  if (_earningTypes is EqualUnmodifiableListView) return _earningTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earningTypes);
}

@override final  String? earningTypeCustom;
 final  List<OnboardingAccount> _accounts;
@override@JsonKey() List<OnboardingAccount> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

@override@JsonKey() final  bool accountsDeferred;
@override final  bool? invests;
 final  List<String> _investmentTypes;
@override@JsonKey() List<String> get investmentTypes {
  if (_investmentTypes is EqualUnmodifiableListView) return _investmentTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_investmentTypes);
}

// Phase 5 — Intent
@override final  int? budgetTotalMinor;
@override final  String? budgetCurrency;
 final  List<OnboardingBudgetCategory> _budgetCategories;
@override@JsonKey() List<OnboardingBudgetCategory> get budgetCategories {
  if (_budgetCategories is EqualUnmodifiableListView) return _budgetCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_budgetCategories);
}

 final  List<OnboardingGoal> _goals;
@override@JsonKey() List<OnboardingGoal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

// Phase 6 — Remittance
 final  List<String> _remittanceOptions;
// Phase 6 — Remittance
@override@JsonKey() List<String> get remittanceOptions {
  if (_remittanceOptions is EqualUnmodifiableListView) return _remittanceOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_remittanceOptions);
}

 final  List<String> _sendsTo;
@override@JsonKey() List<String> get sendsTo {
  if (_sendsTo is EqualUnmodifiableListView) return _sendsTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sendsTo);
}

 final  List<String> _receivesFrom;
@override@JsonKey() List<String> get receivesFrom {
  if (_receivesFrom is EqualUnmodifiableListView) return _receivesFrom;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receivesFrom);
}

// Cross-cutting — D-009
@override final  String? lastCompletedStep;
@override final  DateTime? lastUpdatedAt;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateCopyWith<_OnboardingState> get copyWith => __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.primaryRegion, primaryRegion) || other.primaryRegion == primaryRegion)&&const DeepCollectionEquality().equals(other._secondaryRegions, _secondaryRegions)&&(identical(other.name, name) || other.name == name)&&(identical(other.ipCountry, ipCountry) || other.ipCountry == ipCountry)&&(identical(other.smsGranted, smsGranted) || other.smsGranted == smsGranted)&&(identical(other.notificationsGranted, notificationsGranted) || other.notificationsGranted == notificationsGranted)&&(identical(other.locationGranted, locationGranted) || other.locationGranted == locationGranted)&&(identical(other.contactsAck, contactsAck) || other.contactsAck == contactsAck)&&const DeepCollectionEquality().equals(other._earningTypes, _earningTypes)&&(identical(other.earningTypeCustom, earningTypeCustom) || other.earningTypeCustom == earningTypeCustom)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&(identical(other.accountsDeferred, accountsDeferred) || other.accountsDeferred == accountsDeferred)&&(identical(other.invests, invests) || other.invests == invests)&&const DeepCollectionEquality().equals(other._investmentTypes, _investmentTypes)&&(identical(other.budgetTotalMinor, budgetTotalMinor) || other.budgetTotalMinor == budgetTotalMinor)&&(identical(other.budgetCurrency, budgetCurrency) || other.budgetCurrency == budgetCurrency)&&const DeepCollectionEquality().equals(other._budgetCategories, _budgetCategories)&&const DeepCollectionEquality().equals(other._goals, _goals)&&const DeepCollectionEquality().equals(other._remittanceOptions, _remittanceOptions)&&const DeepCollectionEquality().equals(other._sendsTo, _sendsTo)&&const DeepCollectionEquality().equals(other._receivesFrom, _receivesFrom)&&(identical(other.lastCompletedStep, lastCompletedStep) || other.lastCompletedStep == lastCompletedStep)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,deviceId,userId,sessionId,primaryRegion,const DeepCollectionEquality().hash(_secondaryRegions),name,ipCountry,smsGranted,notificationsGranted,locationGranted,contactsAck,const DeepCollectionEquality().hash(_earningTypes),earningTypeCustom,const DeepCollectionEquality().hash(_accounts),accountsDeferred,invests,const DeepCollectionEquality().hash(_investmentTypes),budgetTotalMinor,budgetCurrency,const DeepCollectionEquality().hash(_budgetCategories),const DeepCollectionEquality().hash(_goals),const DeepCollectionEquality().hash(_remittanceOptions),const DeepCollectionEquality().hash(_sendsTo),const DeepCollectionEquality().hash(_receivesFrom),lastCompletedStep,lastUpdatedAt]);

@override
String toString() {
  return 'OnboardingState(deviceId: $deviceId, userId: $userId, sessionId: $sessionId, primaryRegion: $primaryRegion, secondaryRegions: $secondaryRegions, name: $name, ipCountry: $ipCountry, smsGranted: $smsGranted, notificationsGranted: $notificationsGranted, locationGranted: $locationGranted, contactsAck: $contactsAck, earningTypes: $earningTypes, earningTypeCustom: $earningTypeCustom, accounts: $accounts, accountsDeferred: $accountsDeferred, invests: $invests, investmentTypes: $investmentTypes, budgetTotalMinor: $budgetTotalMinor, budgetCurrency: $budgetCurrency, budgetCategories: $budgetCategories, goals: $goals, remittanceOptions: $remittanceOptions, sendsTo: $sendsTo, receivesFrom: $receivesFrom, lastCompletedStep: $lastCompletedStep, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(_OnboardingState value, $Res Function(_OnboardingState) _then) = __$OnboardingStateCopyWithImpl;
@override @useResult
$Res call({
 String? deviceId, String? userId, String? sessionId, String? primaryRegion, List<String> secondaryRegions, String? name, String? ipCountry, bool? smsGranted, bool? notificationsGranted, bool? locationGranted, bool? contactsAck, List<String> earningTypes, String? earningTypeCustom, List<OnboardingAccount> accounts, bool accountsDeferred, bool? invests, List<String> investmentTypes, int? budgetTotalMinor, String? budgetCurrency, List<OnboardingBudgetCategory> budgetCategories, List<OnboardingGoal> goals, List<String> remittanceOptions, List<String> sendsTo, List<String> receivesFrom, String? lastCompletedStep, DateTime? lastUpdatedAt
});




}
/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = freezed,Object? userId = freezed,Object? sessionId = freezed,Object? primaryRegion = freezed,Object? secondaryRegions = null,Object? name = freezed,Object? ipCountry = freezed,Object? smsGranted = freezed,Object? notificationsGranted = freezed,Object? locationGranted = freezed,Object? contactsAck = freezed,Object? earningTypes = null,Object? earningTypeCustom = freezed,Object? accounts = null,Object? accountsDeferred = null,Object? invests = freezed,Object? investmentTypes = null,Object? budgetTotalMinor = freezed,Object? budgetCurrency = freezed,Object? budgetCategories = null,Object? goals = null,Object? remittanceOptions = null,Object? sendsTo = null,Object? receivesFrom = null,Object? lastCompletedStep = freezed,Object? lastUpdatedAt = freezed,}) {
  return _then(_OnboardingState(
deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,primaryRegion: freezed == primaryRegion ? _self.primaryRegion : primaryRegion // ignore: cast_nullable_to_non_nullable
as String?,secondaryRegions: null == secondaryRegions ? _self._secondaryRegions : secondaryRegions // ignore: cast_nullable_to_non_nullable
as List<String>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,ipCountry: freezed == ipCountry ? _self.ipCountry : ipCountry // ignore: cast_nullable_to_non_nullable
as String?,smsGranted: freezed == smsGranted ? _self.smsGranted : smsGranted // ignore: cast_nullable_to_non_nullable
as bool?,notificationsGranted: freezed == notificationsGranted ? _self.notificationsGranted : notificationsGranted // ignore: cast_nullable_to_non_nullable
as bool?,locationGranted: freezed == locationGranted ? _self.locationGranted : locationGranted // ignore: cast_nullable_to_non_nullable
as bool?,contactsAck: freezed == contactsAck ? _self.contactsAck : contactsAck // ignore: cast_nullable_to_non_nullable
as bool?,earningTypes: null == earningTypes ? _self._earningTypes : earningTypes // ignore: cast_nullable_to_non_nullable
as List<String>,earningTypeCustom: freezed == earningTypeCustom ? _self.earningTypeCustom : earningTypeCustom // ignore: cast_nullable_to_non_nullable
as String?,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<OnboardingAccount>,accountsDeferred: null == accountsDeferred ? _self.accountsDeferred : accountsDeferred // ignore: cast_nullable_to_non_nullable
as bool,invests: freezed == invests ? _self.invests : invests // ignore: cast_nullable_to_non_nullable
as bool?,investmentTypes: null == investmentTypes ? _self._investmentTypes : investmentTypes // ignore: cast_nullable_to_non_nullable
as List<String>,budgetTotalMinor: freezed == budgetTotalMinor ? _self.budgetTotalMinor : budgetTotalMinor // ignore: cast_nullable_to_non_nullable
as int?,budgetCurrency: freezed == budgetCurrency ? _self.budgetCurrency : budgetCurrency // ignore: cast_nullable_to_non_nullable
as String?,budgetCategories: null == budgetCategories ? _self._budgetCategories : budgetCategories // ignore: cast_nullable_to_non_nullable
as List<OnboardingBudgetCategory>,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<OnboardingGoal>,remittanceOptions: null == remittanceOptions ? _self._remittanceOptions : remittanceOptions // ignore: cast_nullable_to_non_nullable
as List<String>,sendsTo: null == sendsTo ? _self._sendsTo : sendsTo // ignore: cast_nullable_to_non_nullable
as List<String>,receivesFrom: null == receivesFrom ? _self._receivesFrom : receivesFrom // ignore: cast_nullable_to_non_nullable
as List<String>,lastCompletedStep: freezed == lastCompletedStep ? _self.lastCompletedStep : lastCompletedStep // ignore: cast_nullable_to_non_nullable
as String?,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$OnboardingAccount {

 String get accountKind;// 'bank' | 'wallet'
 String get providerSlug; String get regionIso2;
/// Create a copy of OnboardingAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingAccountCopyWith<OnboardingAccount> get copyWith => _$OnboardingAccountCopyWithImpl<OnboardingAccount>(this as OnboardingAccount, _$identity);

  /// Serializes this OnboardingAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingAccount&&(identical(other.accountKind, accountKind) || other.accountKind == accountKind)&&(identical(other.providerSlug, providerSlug) || other.providerSlug == providerSlug)&&(identical(other.regionIso2, regionIso2) || other.regionIso2 == regionIso2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountKind,providerSlug,regionIso2);

@override
String toString() {
  return 'OnboardingAccount(accountKind: $accountKind, providerSlug: $providerSlug, regionIso2: $regionIso2)';
}


}

/// @nodoc
abstract mixin class $OnboardingAccountCopyWith<$Res>  {
  factory $OnboardingAccountCopyWith(OnboardingAccount value, $Res Function(OnboardingAccount) _then) = _$OnboardingAccountCopyWithImpl;
@useResult
$Res call({
 String accountKind, String providerSlug, String regionIso2
});




}
/// @nodoc
class _$OnboardingAccountCopyWithImpl<$Res>
    implements $OnboardingAccountCopyWith<$Res> {
  _$OnboardingAccountCopyWithImpl(this._self, this._then);

  final OnboardingAccount _self;
  final $Res Function(OnboardingAccount) _then;

/// Create a copy of OnboardingAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountKind = null,Object? providerSlug = null,Object? regionIso2 = null,}) {
  return _then(_self.copyWith(
accountKind: null == accountKind ? _self.accountKind : accountKind // ignore: cast_nullable_to_non_nullable
as String,providerSlug: null == providerSlug ? _self.providerSlug : providerSlug // ignore: cast_nullable_to_non_nullable
as String,regionIso2: null == regionIso2 ? _self.regionIso2 : regionIso2 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingAccount].
extension OnboardingAccountPatterns on OnboardingAccount {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingAccount() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingAccount value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingAccount():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingAccount value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingAccount() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountKind,  String providerSlug,  String regionIso2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingAccount() when $default != null:
return $default(_that.accountKind,_that.providerSlug,_that.regionIso2);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountKind,  String providerSlug,  String regionIso2)  $default,) {final _that = this;
switch (_that) {
case _OnboardingAccount():
return $default(_that.accountKind,_that.providerSlug,_that.regionIso2);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountKind,  String providerSlug,  String regionIso2)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingAccount() when $default != null:
return $default(_that.accountKind,_that.providerSlug,_that.regionIso2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingAccount implements OnboardingAccount {
  const _OnboardingAccount({required this.accountKind, required this.providerSlug, required this.regionIso2});
  factory _OnboardingAccount.fromJson(Map<String, dynamic> json) => _$OnboardingAccountFromJson(json);

@override final  String accountKind;
// 'bank' | 'wallet'
@override final  String providerSlug;
@override final  String regionIso2;

/// Create a copy of OnboardingAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingAccountCopyWith<_OnboardingAccount> get copyWith => __$OnboardingAccountCopyWithImpl<_OnboardingAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingAccount&&(identical(other.accountKind, accountKind) || other.accountKind == accountKind)&&(identical(other.providerSlug, providerSlug) || other.providerSlug == providerSlug)&&(identical(other.regionIso2, regionIso2) || other.regionIso2 == regionIso2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountKind,providerSlug,regionIso2);

@override
String toString() {
  return 'OnboardingAccount(accountKind: $accountKind, providerSlug: $providerSlug, regionIso2: $regionIso2)';
}


}

/// @nodoc
abstract mixin class _$OnboardingAccountCopyWith<$Res> implements $OnboardingAccountCopyWith<$Res> {
  factory _$OnboardingAccountCopyWith(_OnboardingAccount value, $Res Function(_OnboardingAccount) _then) = __$OnboardingAccountCopyWithImpl;
@override @useResult
$Res call({
 String accountKind, String providerSlug, String regionIso2
});




}
/// @nodoc
class __$OnboardingAccountCopyWithImpl<$Res>
    implements _$OnboardingAccountCopyWith<$Res> {
  __$OnboardingAccountCopyWithImpl(this._self, this._then);

  final _OnboardingAccount _self;
  final $Res Function(_OnboardingAccount) _then;

/// Create a copy of OnboardingAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountKind = null,Object? providerSlug = null,Object? regionIso2 = null,}) {
  return _then(_OnboardingAccount(
accountKind: null == accountKind ? _self.accountKind : accountKind // ignore: cast_nullable_to_non_nullable
as String,providerSlug: null == providerSlug ? _self.providerSlug : providerSlug // ignore: cast_nullable_to_non_nullable
as String,regionIso2: null == regionIso2 ? _self.regionIso2 : regionIso2 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OnboardingBudgetCategory {

 String get categorySlug; int get amountMinor; String get semantic;
/// Create a copy of OnboardingBudgetCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingBudgetCategoryCopyWith<OnboardingBudgetCategory> get copyWith => _$OnboardingBudgetCategoryCopyWithImpl<OnboardingBudgetCategory>(this as OnboardingBudgetCategory, _$identity);

  /// Serializes this OnboardingBudgetCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingBudgetCategory&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.semantic, semantic) || other.semantic == semantic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categorySlug,amountMinor,semantic);

@override
String toString() {
  return 'OnboardingBudgetCategory(categorySlug: $categorySlug, amountMinor: $amountMinor, semantic: $semantic)';
}


}

/// @nodoc
abstract mixin class $OnboardingBudgetCategoryCopyWith<$Res>  {
  factory $OnboardingBudgetCategoryCopyWith(OnboardingBudgetCategory value, $Res Function(OnboardingBudgetCategory) _then) = _$OnboardingBudgetCategoryCopyWithImpl;
@useResult
$Res call({
 String categorySlug, int amountMinor, String semantic
});




}
/// @nodoc
class _$OnboardingBudgetCategoryCopyWithImpl<$Res>
    implements $OnboardingBudgetCategoryCopyWith<$Res> {
  _$OnboardingBudgetCategoryCopyWithImpl(this._self, this._then);

  final OnboardingBudgetCategory _self;
  final $Res Function(OnboardingBudgetCategory) _then;

/// Create a copy of OnboardingBudgetCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categorySlug = null,Object? amountMinor = null,Object? semantic = null,}) {
  return _then(_self.copyWith(
categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,semantic: null == semantic ? _self.semantic : semantic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingBudgetCategory].
extension OnboardingBudgetCategoryPatterns on OnboardingBudgetCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingBudgetCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingBudgetCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingBudgetCategory value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingBudgetCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingBudgetCategory value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingBudgetCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categorySlug,  int amountMinor,  String semantic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingBudgetCategory() when $default != null:
return $default(_that.categorySlug,_that.amountMinor,_that.semantic);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categorySlug,  int amountMinor,  String semantic)  $default,) {final _that = this;
switch (_that) {
case _OnboardingBudgetCategory():
return $default(_that.categorySlug,_that.amountMinor,_that.semantic);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categorySlug,  int amountMinor,  String semantic)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingBudgetCategory() when $default != null:
return $default(_that.categorySlug,_that.amountMinor,_that.semantic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingBudgetCategory implements OnboardingBudgetCategory {
  const _OnboardingBudgetCategory({required this.categorySlug, required this.amountMinor, required this.semantic});
  factory _OnboardingBudgetCategory.fromJson(Map<String, dynamic> json) => _$OnboardingBudgetCategoryFromJson(json);

@override final  String categorySlug;
@override final  int amountMinor;
@override final  String semantic;

/// Create a copy of OnboardingBudgetCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingBudgetCategoryCopyWith<_OnboardingBudgetCategory> get copyWith => __$OnboardingBudgetCategoryCopyWithImpl<_OnboardingBudgetCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingBudgetCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingBudgetCategory&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.semantic, semantic) || other.semantic == semantic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categorySlug,amountMinor,semantic);

@override
String toString() {
  return 'OnboardingBudgetCategory(categorySlug: $categorySlug, amountMinor: $amountMinor, semantic: $semantic)';
}


}

/// @nodoc
abstract mixin class _$OnboardingBudgetCategoryCopyWith<$Res> implements $OnboardingBudgetCategoryCopyWith<$Res> {
  factory _$OnboardingBudgetCategoryCopyWith(_OnboardingBudgetCategory value, $Res Function(_OnboardingBudgetCategory) _then) = __$OnboardingBudgetCategoryCopyWithImpl;
@override @useResult
$Res call({
 String categorySlug, int amountMinor, String semantic
});




}
/// @nodoc
class __$OnboardingBudgetCategoryCopyWithImpl<$Res>
    implements _$OnboardingBudgetCategoryCopyWith<$Res> {
  __$OnboardingBudgetCategoryCopyWithImpl(this._self, this._then);

  final _OnboardingBudgetCategory _self;
  final $Res Function(_OnboardingBudgetCategory) _then;

/// Create a copy of OnboardingBudgetCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categorySlug = null,Object? amountMinor = null,Object? semantic = null,}) {
  return _then(_OnboardingBudgetCategory(
categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,semantic: null == semantic ? _self.semantic : semantic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OnboardingGoal {

 int get slot;// 1 or 2 (D-008 hard limit)
 String get templateSlug; String? get customLabel; int get targetAmountMinor; String get currency;// multi-currency per D-021
 DateTime get targetDate;
/// Create a copy of OnboardingGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingGoalCopyWith<OnboardingGoal> get copyWith => _$OnboardingGoalCopyWithImpl<OnboardingGoal>(this as OnboardingGoal, _$identity);

  /// Serializes this OnboardingGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingGoal&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.templateSlug, templateSlug) || other.templateSlug == templateSlug)&&(identical(other.customLabel, customLabel) || other.customLabel == customLabel)&&(identical(other.targetAmountMinor, targetAmountMinor) || other.targetAmountMinor == targetAmountMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slot,templateSlug,customLabel,targetAmountMinor,currency,targetDate);

@override
String toString() {
  return 'OnboardingGoal(slot: $slot, templateSlug: $templateSlug, customLabel: $customLabel, targetAmountMinor: $targetAmountMinor, currency: $currency, targetDate: $targetDate)';
}


}

/// @nodoc
abstract mixin class $OnboardingGoalCopyWith<$Res>  {
  factory $OnboardingGoalCopyWith(OnboardingGoal value, $Res Function(OnboardingGoal) _then) = _$OnboardingGoalCopyWithImpl;
@useResult
$Res call({
 int slot, String templateSlug, String? customLabel, int targetAmountMinor, String currency, DateTime targetDate
});




}
/// @nodoc
class _$OnboardingGoalCopyWithImpl<$Res>
    implements $OnboardingGoalCopyWith<$Res> {
  _$OnboardingGoalCopyWithImpl(this._self, this._then);

  final OnboardingGoal _self;
  final $Res Function(OnboardingGoal) _then;

/// Create a copy of OnboardingGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slot = null,Object? templateSlug = null,Object? customLabel = freezed,Object? targetAmountMinor = null,Object? currency = null,Object? targetDate = null,}) {
  return _then(_self.copyWith(
slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,templateSlug: null == templateSlug ? _self.templateSlug : templateSlug // ignore: cast_nullable_to_non_nullable
as String,customLabel: freezed == customLabel ? _self.customLabel : customLabel // ignore: cast_nullable_to_non_nullable
as String?,targetAmountMinor: null == targetAmountMinor ? _self.targetAmountMinor : targetAmountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,targetDate: null == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingGoal].
extension OnboardingGoalPatterns on OnboardingGoal {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingGoal() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingGoal value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingGoal():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingGoal value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingGoal() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int slot,  String templateSlug,  String? customLabel,  int targetAmountMinor,  String currency,  DateTime targetDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingGoal() when $default != null:
return $default(_that.slot,_that.templateSlug,_that.customLabel,_that.targetAmountMinor,_that.currency,_that.targetDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int slot,  String templateSlug,  String? customLabel,  int targetAmountMinor,  String currency,  DateTime targetDate)  $default,) {final _that = this;
switch (_that) {
case _OnboardingGoal():
return $default(_that.slot,_that.templateSlug,_that.customLabel,_that.targetAmountMinor,_that.currency,_that.targetDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int slot,  String templateSlug,  String? customLabel,  int targetAmountMinor,  String currency,  DateTime targetDate)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingGoal() when $default != null:
return $default(_that.slot,_that.templateSlug,_that.customLabel,_that.targetAmountMinor,_that.currency,_that.targetDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingGoal implements OnboardingGoal {
  const _OnboardingGoal({required this.slot, required this.templateSlug, this.customLabel, required this.targetAmountMinor, required this.currency, required this.targetDate});
  factory _OnboardingGoal.fromJson(Map<String, dynamic> json) => _$OnboardingGoalFromJson(json);

@override final  int slot;
// 1 or 2 (D-008 hard limit)
@override final  String templateSlug;
@override final  String? customLabel;
@override final  int targetAmountMinor;
@override final  String currency;
// multi-currency per D-021
@override final  DateTime targetDate;

/// Create a copy of OnboardingGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingGoalCopyWith<_OnboardingGoal> get copyWith => __$OnboardingGoalCopyWithImpl<_OnboardingGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingGoal&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.templateSlug, templateSlug) || other.templateSlug == templateSlug)&&(identical(other.customLabel, customLabel) || other.customLabel == customLabel)&&(identical(other.targetAmountMinor, targetAmountMinor) || other.targetAmountMinor == targetAmountMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slot,templateSlug,customLabel,targetAmountMinor,currency,targetDate);

@override
String toString() {
  return 'OnboardingGoal(slot: $slot, templateSlug: $templateSlug, customLabel: $customLabel, targetAmountMinor: $targetAmountMinor, currency: $currency, targetDate: $targetDate)';
}


}

/// @nodoc
abstract mixin class _$OnboardingGoalCopyWith<$Res> implements $OnboardingGoalCopyWith<$Res> {
  factory _$OnboardingGoalCopyWith(_OnboardingGoal value, $Res Function(_OnboardingGoal) _then) = __$OnboardingGoalCopyWithImpl;
@override @useResult
$Res call({
 int slot, String templateSlug, String? customLabel, int targetAmountMinor, String currency, DateTime targetDate
});




}
/// @nodoc
class __$OnboardingGoalCopyWithImpl<$Res>
    implements _$OnboardingGoalCopyWith<$Res> {
  __$OnboardingGoalCopyWithImpl(this._self, this._then);

  final _OnboardingGoal _self;
  final $Res Function(_OnboardingGoal) _then;

/// Create a copy of OnboardingGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slot = null,Object? templateSlug = null,Object? customLabel = freezed,Object? targetAmountMinor = null,Object? currency = null,Object? targetDate = null,}) {
  return _then(_OnboardingGoal(
slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,templateSlug: null == templateSlug ? _self.templateSlug : templateSlug // ignore: cast_nullable_to_non_nullable
as String,customLabel: freezed == customLabel ? _self.customLabel : customLabel // ignore: cast_nullable_to_non_nullable
as String?,targetAmountMinor: null == targetAmountMinor ? _self.targetAmountMinor : targetAmountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,targetDate: null == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
