// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'felo_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
FeloNotification _$FeloNotificationFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'budgetAlert':
          return BudgetAlertNotification.fromJson(
            json
          );
                case 'goalMilestone':
          return GoalMilestoneNotification.fromJson(
            json
          );
                case 'smsParserEvent':
          return SmsParserEventNotification.fromJson(
            json
          );
                case 'familyActivity':
          return FamilyActivityNotification.fromJson(
            json
          );
                case 'systemMessage':
          return SystemMessageNotification.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'FeloNotification',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$FeloNotification {

 String get id; DateTime get createdAt; bool get isRead; bool get archived;
/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeloNotificationCopyWith<FeloNotification> get copyWith => _$FeloNotificationCopyWithImpl<FeloNotification>(this as FeloNotification, _$identity);

  /// Serializes this FeloNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeloNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,isRead,archived);

@override
String toString() {
  return 'FeloNotification(id: $id, createdAt: $createdAt, isRead: $isRead, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $FeloNotificationCopyWith<$Res>  {
  factory $FeloNotificationCopyWith(FeloNotification value, $Res Function(FeloNotification) _then) = _$FeloNotificationCopyWithImpl;
@useResult
$Res call({
 String id, DateTime createdAt, bool isRead, bool archived
});




}
/// @nodoc
class _$FeloNotificationCopyWithImpl<$Res>
    implements $FeloNotificationCopyWith<$Res> {
  _$FeloNotificationCopyWithImpl(this._self, this._then);

  final FeloNotification _self;
  final $Res Function(FeloNotification) _then;

/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? isRead = null,Object? archived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeloNotification].
extension FeloNotificationPatterns on FeloNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BudgetAlertNotification value)?  budgetAlert,TResult Function( GoalMilestoneNotification value)?  goalMilestone,TResult Function( SmsParserEventNotification value)?  smsParserEvent,TResult Function( FamilyActivityNotification value)?  familyActivity,TResult Function( SystemMessageNotification value)?  systemMessage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BudgetAlertNotification() when budgetAlert != null:
return budgetAlert(_that);case GoalMilestoneNotification() when goalMilestone != null:
return goalMilestone(_that);case SmsParserEventNotification() when smsParserEvent != null:
return smsParserEvent(_that);case FamilyActivityNotification() when familyActivity != null:
return familyActivity(_that);case SystemMessageNotification() when systemMessage != null:
return systemMessage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BudgetAlertNotification value)  budgetAlert,required TResult Function( GoalMilestoneNotification value)  goalMilestone,required TResult Function( SmsParserEventNotification value)  smsParserEvent,required TResult Function( FamilyActivityNotification value)  familyActivity,required TResult Function( SystemMessageNotification value)  systemMessage,}){
final _that = this;
switch (_that) {
case BudgetAlertNotification():
return budgetAlert(_that);case GoalMilestoneNotification():
return goalMilestone(_that);case SmsParserEventNotification():
return smsParserEvent(_that);case FamilyActivityNotification():
return familyActivity(_that);case SystemMessageNotification():
return systemMessage(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BudgetAlertNotification value)?  budgetAlert,TResult? Function( GoalMilestoneNotification value)?  goalMilestone,TResult? Function( SmsParserEventNotification value)?  smsParserEvent,TResult? Function( FamilyActivityNotification value)?  familyActivity,TResult? Function( SystemMessageNotification value)?  systemMessage,}){
final _that = this;
switch (_that) {
case BudgetAlertNotification() when budgetAlert != null:
return budgetAlert(_that);case GoalMilestoneNotification() when goalMilestone != null:
return goalMilestone(_that);case SmsParserEventNotification() when smsParserEvent != null:
return smsParserEvent(_that);case FamilyActivityNotification() when familyActivity != null:
return familyActivity(_that);case SystemMessageNotification() when systemMessage != null:
return systemMessage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  DateTime createdAt,  String budgetId,  int thresholdPercent,  bool isRead,  bool archived)?  budgetAlert,TResult Function( String id,  DateTime createdAt,  String goalId,  int progressPercent,  bool isRead,  bool archived)?  goalMilestone,TResult Function( String id,  DateTime createdAt,  String parsedSmsId,  int confidencePercent,  bool isRead,  bool archived)?  smsParserEvent,TResult Function( String id,  DateTime createdAt,  String memberId,  bool isRead,  bool archived)?  familyActivity,TResult Function( String id,  DateTime createdAt,  bool isRead,  bool archived)?  systemMessage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BudgetAlertNotification() when budgetAlert != null:
return budgetAlert(_that.id,_that.createdAt,_that.budgetId,_that.thresholdPercent,_that.isRead,_that.archived);case GoalMilestoneNotification() when goalMilestone != null:
return goalMilestone(_that.id,_that.createdAt,_that.goalId,_that.progressPercent,_that.isRead,_that.archived);case SmsParserEventNotification() when smsParserEvent != null:
return smsParserEvent(_that.id,_that.createdAt,_that.parsedSmsId,_that.confidencePercent,_that.isRead,_that.archived);case FamilyActivityNotification() when familyActivity != null:
return familyActivity(_that.id,_that.createdAt,_that.memberId,_that.isRead,_that.archived);case SystemMessageNotification() when systemMessage != null:
return systemMessage(_that.id,_that.createdAt,_that.isRead,_that.archived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  DateTime createdAt,  String budgetId,  int thresholdPercent,  bool isRead,  bool archived)  budgetAlert,required TResult Function( String id,  DateTime createdAt,  String goalId,  int progressPercent,  bool isRead,  bool archived)  goalMilestone,required TResult Function( String id,  DateTime createdAt,  String parsedSmsId,  int confidencePercent,  bool isRead,  bool archived)  smsParserEvent,required TResult Function( String id,  DateTime createdAt,  String memberId,  bool isRead,  bool archived)  familyActivity,required TResult Function( String id,  DateTime createdAt,  bool isRead,  bool archived)  systemMessage,}) {final _that = this;
switch (_that) {
case BudgetAlertNotification():
return budgetAlert(_that.id,_that.createdAt,_that.budgetId,_that.thresholdPercent,_that.isRead,_that.archived);case GoalMilestoneNotification():
return goalMilestone(_that.id,_that.createdAt,_that.goalId,_that.progressPercent,_that.isRead,_that.archived);case SmsParserEventNotification():
return smsParserEvent(_that.id,_that.createdAt,_that.parsedSmsId,_that.confidencePercent,_that.isRead,_that.archived);case FamilyActivityNotification():
return familyActivity(_that.id,_that.createdAt,_that.memberId,_that.isRead,_that.archived);case SystemMessageNotification():
return systemMessage(_that.id,_that.createdAt,_that.isRead,_that.archived);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  DateTime createdAt,  String budgetId,  int thresholdPercent,  bool isRead,  bool archived)?  budgetAlert,TResult? Function( String id,  DateTime createdAt,  String goalId,  int progressPercent,  bool isRead,  bool archived)?  goalMilestone,TResult? Function( String id,  DateTime createdAt,  String parsedSmsId,  int confidencePercent,  bool isRead,  bool archived)?  smsParserEvent,TResult? Function( String id,  DateTime createdAt,  String memberId,  bool isRead,  bool archived)?  familyActivity,TResult? Function( String id,  DateTime createdAt,  bool isRead,  bool archived)?  systemMessage,}) {final _that = this;
switch (_that) {
case BudgetAlertNotification() when budgetAlert != null:
return budgetAlert(_that.id,_that.createdAt,_that.budgetId,_that.thresholdPercent,_that.isRead,_that.archived);case GoalMilestoneNotification() when goalMilestone != null:
return goalMilestone(_that.id,_that.createdAt,_that.goalId,_that.progressPercent,_that.isRead,_that.archived);case SmsParserEventNotification() when smsParserEvent != null:
return smsParserEvent(_that.id,_that.createdAt,_that.parsedSmsId,_that.confidencePercent,_that.isRead,_that.archived);case FamilyActivityNotification() when familyActivity != null:
return familyActivity(_that.id,_that.createdAt,_that.memberId,_that.isRead,_that.archived);case SystemMessageNotification() when systemMessage != null:
return systemMessage(_that.id,_that.createdAt,_that.isRead,_that.archived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class BudgetAlertNotification extends FeloNotification {
  const BudgetAlertNotification({required this.id, required this.createdAt, required this.budgetId, required this.thresholdPercent, this.isRead = false, this.archived = false, final  String? $type}): $type = $type ?? 'budgetAlert',super._();
  factory BudgetAlertNotification.fromJson(Map<String, dynamic> json) => _$BudgetAlertNotificationFromJson(json);

@override final  String id;
@override final  DateTime createdAt;
 final  String budgetId;
 final  int thresholdPercent;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  bool archived;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetAlertNotificationCopyWith<BudgetAlertNotification> get copyWith => _$BudgetAlertNotificationCopyWithImpl<BudgetAlertNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetAlertNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetAlertNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.thresholdPercent, thresholdPercent) || other.thresholdPercent == thresholdPercent)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,budgetId,thresholdPercent,isRead,archived);

@override
String toString() {
  return 'FeloNotification.budgetAlert(id: $id, createdAt: $createdAt, budgetId: $budgetId, thresholdPercent: $thresholdPercent, isRead: $isRead, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $BudgetAlertNotificationCopyWith<$Res> implements $FeloNotificationCopyWith<$Res> {
  factory $BudgetAlertNotificationCopyWith(BudgetAlertNotification value, $Res Function(BudgetAlertNotification) _then) = _$BudgetAlertNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, String budgetId, int thresholdPercent, bool isRead, bool archived
});




}
/// @nodoc
class _$BudgetAlertNotificationCopyWithImpl<$Res>
    implements $BudgetAlertNotificationCopyWith<$Res> {
  _$BudgetAlertNotificationCopyWithImpl(this._self, this._then);

  final BudgetAlertNotification _self;
  final $Res Function(BudgetAlertNotification) _then;

/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? budgetId = null,Object? thresholdPercent = null,Object? isRead = null,Object? archived = null,}) {
  return _then(BudgetAlertNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,budgetId: null == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as String,thresholdPercent: null == thresholdPercent ? _self.thresholdPercent : thresholdPercent // ignore: cast_nullable_to_non_nullable
as int,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class GoalMilestoneNotification extends FeloNotification {
  const GoalMilestoneNotification({required this.id, required this.createdAt, required this.goalId, required this.progressPercent, this.isRead = false, this.archived = false, final  String? $type}): $type = $type ?? 'goalMilestone',super._();
  factory GoalMilestoneNotification.fromJson(Map<String, dynamic> json) => _$GoalMilestoneNotificationFromJson(json);

@override final  String id;
@override final  DateTime createdAt;
 final  String goalId;
 final  int progressPercent;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  bool archived;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalMilestoneNotificationCopyWith<GoalMilestoneNotification> get copyWith => _$GoalMilestoneNotificationCopyWithImpl<GoalMilestoneNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalMilestoneNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalMilestoneNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,goalId,progressPercent,isRead,archived);

@override
String toString() {
  return 'FeloNotification.goalMilestone(id: $id, createdAt: $createdAt, goalId: $goalId, progressPercent: $progressPercent, isRead: $isRead, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $GoalMilestoneNotificationCopyWith<$Res> implements $FeloNotificationCopyWith<$Res> {
  factory $GoalMilestoneNotificationCopyWith(GoalMilestoneNotification value, $Res Function(GoalMilestoneNotification) _then) = _$GoalMilestoneNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, String goalId, int progressPercent, bool isRead, bool archived
});




}
/// @nodoc
class _$GoalMilestoneNotificationCopyWithImpl<$Res>
    implements $GoalMilestoneNotificationCopyWith<$Res> {
  _$GoalMilestoneNotificationCopyWithImpl(this._self, this._then);

  final GoalMilestoneNotification _self;
  final $Res Function(GoalMilestoneNotification) _then;

/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? goalId = null,Object? progressPercent = null,Object? isRead = null,Object? archived = null,}) {
  return _then(GoalMilestoneNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SmsParserEventNotification extends FeloNotification {
  const SmsParserEventNotification({required this.id, required this.createdAt, required this.parsedSmsId, required this.confidencePercent, this.isRead = false, this.archived = false, final  String? $type}): $type = $type ?? 'smsParserEvent',super._();
  factory SmsParserEventNotification.fromJson(Map<String, dynamic> json) => _$SmsParserEventNotificationFromJson(json);

@override final  String id;
@override final  DateTime createdAt;
 final  String parsedSmsId;
 final  int confidencePercent;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  bool archived;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmsParserEventNotificationCopyWith<SmsParserEventNotification> get copyWith => _$SmsParserEventNotificationCopyWithImpl<SmsParserEventNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmsParserEventNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmsParserEventNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.parsedSmsId, parsedSmsId) || other.parsedSmsId == parsedSmsId)&&(identical(other.confidencePercent, confidencePercent) || other.confidencePercent == confidencePercent)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,parsedSmsId,confidencePercent,isRead,archived);

@override
String toString() {
  return 'FeloNotification.smsParserEvent(id: $id, createdAt: $createdAt, parsedSmsId: $parsedSmsId, confidencePercent: $confidencePercent, isRead: $isRead, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $SmsParserEventNotificationCopyWith<$Res> implements $FeloNotificationCopyWith<$Res> {
  factory $SmsParserEventNotificationCopyWith(SmsParserEventNotification value, $Res Function(SmsParserEventNotification) _then) = _$SmsParserEventNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, String parsedSmsId, int confidencePercent, bool isRead, bool archived
});




}
/// @nodoc
class _$SmsParserEventNotificationCopyWithImpl<$Res>
    implements $SmsParserEventNotificationCopyWith<$Res> {
  _$SmsParserEventNotificationCopyWithImpl(this._self, this._then);

  final SmsParserEventNotification _self;
  final $Res Function(SmsParserEventNotification) _then;

/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? parsedSmsId = null,Object? confidencePercent = null,Object? isRead = null,Object? archived = null,}) {
  return _then(SmsParserEventNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,parsedSmsId: null == parsedSmsId ? _self.parsedSmsId : parsedSmsId // ignore: cast_nullable_to_non_nullable
as String,confidencePercent: null == confidencePercent ? _self.confidencePercent : confidencePercent // ignore: cast_nullable_to_non_nullable
as int,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FamilyActivityNotification extends FeloNotification {
  const FamilyActivityNotification({required this.id, required this.createdAt, required this.memberId, this.isRead = false, this.archived = false, final  String? $type}): $type = $type ?? 'familyActivity',super._();
  factory FamilyActivityNotification.fromJson(Map<String, dynamic> json) => _$FamilyActivityNotificationFromJson(json);

@override final  String id;
@override final  DateTime createdAt;
 final  String memberId;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  bool archived;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyActivityNotificationCopyWith<FamilyActivityNotification> get copyWith => _$FamilyActivityNotificationCopyWithImpl<FamilyActivityNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyActivityNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyActivityNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,memberId,isRead,archived);

@override
String toString() {
  return 'FeloNotification.familyActivity(id: $id, createdAt: $createdAt, memberId: $memberId, isRead: $isRead, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $FamilyActivityNotificationCopyWith<$Res> implements $FeloNotificationCopyWith<$Res> {
  factory $FamilyActivityNotificationCopyWith(FamilyActivityNotification value, $Res Function(FamilyActivityNotification) _then) = _$FamilyActivityNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, String memberId, bool isRead, bool archived
});




}
/// @nodoc
class _$FamilyActivityNotificationCopyWithImpl<$Res>
    implements $FamilyActivityNotificationCopyWith<$Res> {
  _$FamilyActivityNotificationCopyWithImpl(this._self, this._then);

  final FamilyActivityNotification _self;
  final $Res Function(FamilyActivityNotification) _then;

/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? memberId = null,Object? isRead = null,Object? archived = null,}) {
  return _then(FamilyActivityNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SystemMessageNotification extends FeloNotification {
  const SystemMessageNotification({required this.id, required this.createdAt, this.isRead = false, this.archived = false, final  String? $type}): $type = $type ?? 'systemMessage',super._();
  factory SystemMessageNotification.fromJson(Map<String, dynamic> json) => _$SystemMessageNotificationFromJson(json);

@override final  String id;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  bool archived;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemMessageNotificationCopyWith<SystemMessageNotification> get copyWith => _$SystemMessageNotificationCopyWithImpl<SystemMessageNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemMessageNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemMessageNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,isRead,archived);

@override
String toString() {
  return 'FeloNotification.systemMessage(id: $id, createdAt: $createdAt, isRead: $isRead, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $SystemMessageNotificationCopyWith<$Res> implements $FeloNotificationCopyWith<$Res> {
  factory $SystemMessageNotificationCopyWith(SystemMessageNotification value, $Res Function(SystemMessageNotification) _then) = _$SystemMessageNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime createdAt, bool isRead, bool archived
});




}
/// @nodoc
class _$SystemMessageNotificationCopyWithImpl<$Res>
    implements $SystemMessageNotificationCopyWith<$Res> {
  _$SystemMessageNotificationCopyWithImpl(this._self, this._then);

  final SystemMessageNotification _self;
  final $Res Function(SystemMessageNotification) _then;

/// Create a copy of FeloNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? isRead = null,Object? archived = null,}) {
  return _then(SystemMessageNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
