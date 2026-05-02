// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remittance_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemittanceEntry {

 String get id; String get recipientName; String? get recipientCountry; String? get relationship; String get provider; String get sourceCurrency; String? get targetCurrency; int get sourceAmountMinor; int? get targetAmountMinor; int? get feeMinor; double? get fxRate; String? get deliveryMethod; String? get deliveryTime; String get status; String? get plannedDate; DateTime? get sentAt; DateTime? get receivedAt; String? get confirmationMethod; String? get notes; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of RemittanceEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemittanceEntryCopyWith<RemittanceEntry> get copyWith => _$RemittanceEntryCopyWithImpl<RemittanceEntry>(this as RemittanceEntry, _$identity);

  /// Serializes this RemittanceEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemittanceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.recipientCountry, recipientCountry) || other.recipientCountry == recipientCountry)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.sourceCurrency, sourceCurrency) || other.sourceCurrency == sourceCurrency)&&(identical(other.targetCurrency, targetCurrency) || other.targetCurrency == targetCurrency)&&(identical(other.sourceAmountMinor, sourceAmountMinor) || other.sourceAmountMinor == sourceAmountMinor)&&(identical(other.targetAmountMinor, targetAmountMinor) || other.targetAmountMinor == targetAmountMinor)&&(identical(other.feeMinor, feeMinor) || other.feeMinor == feeMinor)&&(identical(other.fxRate, fxRate) || other.fxRate == fxRate)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.plannedDate, plannedDate) || other.plannedDate == plannedDate)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.confirmationMethod, confirmationMethod) || other.confirmationMethod == confirmationMethod)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,recipientName,recipientCountry,relationship,provider,sourceCurrency,targetCurrency,sourceAmountMinor,targetAmountMinor,feeMinor,fxRate,deliveryMethod,deliveryTime,status,plannedDate,sentAt,receivedAt,confirmationMethod,notes,createdAt,updatedAt]);

@override
String toString() {
  return 'RemittanceEntry(id: $id, recipientName: $recipientName, recipientCountry: $recipientCountry, relationship: $relationship, provider: $provider, sourceCurrency: $sourceCurrency, targetCurrency: $targetCurrency, sourceAmountMinor: $sourceAmountMinor, targetAmountMinor: $targetAmountMinor, feeMinor: $feeMinor, fxRate: $fxRate, deliveryMethod: $deliveryMethod, deliveryTime: $deliveryTime, status: $status, plannedDate: $plannedDate, sentAt: $sentAt, receivedAt: $receivedAt, confirmationMethod: $confirmationMethod, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RemittanceEntryCopyWith<$Res>  {
  factory $RemittanceEntryCopyWith(RemittanceEntry value, $Res Function(RemittanceEntry) _then) = _$RemittanceEntryCopyWithImpl;
@useResult
$Res call({
 String id, String recipientName, String? recipientCountry, String? relationship, String provider, String sourceCurrency, String? targetCurrency, int sourceAmountMinor, int? targetAmountMinor, int? feeMinor, double? fxRate, String? deliveryMethod, String? deliveryTime, String status, String? plannedDate, DateTime? sentAt, DateTime? receivedAt, String? confirmationMethod, String? notes, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$RemittanceEntryCopyWithImpl<$Res>
    implements $RemittanceEntryCopyWith<$Res> {
  _$RemittanceEntryCopyWithImpl(this._self, this._then);

  final RemittanceEntry _self;
  final $Res Function(RemittanceEntry) _then;

/// Create a copy of RemittanceEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? recipientName = null,Object? recipientCountry = freezed,Object? relationship = freezed,Object? provider = null,Object? sourceCurrency = null,Object? targetCurrency = freezed,Object? sourceAmountMinor = null,Object? targetAmountMinor = freezed,Object? feeMinor = freezed,Object? fxRate = freezed,Object? deliveryMethod = freezed,Object? deliveryTime = freezed,Object? status = null,Object? plannedDate = freezed,Object? sentAt = freezed,Object? receivedAt = freezed,Object? confirmationMethod = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,recipientCountry: freezed == recipientCountry ? _self.recipientCountry : recipientCountry // ignore: cast_nullable_to_non_nullable
as String?,relationship: freezed == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String?,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,sourceCurrency: null == sourceCurrency ? _self.sourceCurrency : sourceCurrency // ignore: cast_nullable_to_non_nullable
as String,targetCurrency: freezed == targetCurrency ? _self.targetCurrency : targetCurrency // ignore: cast_nullable_to_non_nullable
as String?,sourceAmountMinor: null == sourceAmountMinor ? _self.sourceAmountMinor : sourceAmountMinor // ignore: cast_nullable_to_non_nullable
as int,targetAmountMinor: freezed == targetAmountMinor ? _self.targetAmountMinor : targetAmountMinor // ignore: cast_nullable_to_non_nullable
as int?,feeMinor: freezed == feeMinor ? _self.feeMinor : feeMinor // ignore: cast_nullable_to_non_nullable
as int?,fxRate: freezed == fxRate ? _self.fxRate : fxRate // ignore: cast_nullable_to_non_nullable
as double?,deliveryMethod: freezed == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as String?,deliveryTime: freezed == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,plannedDate: freezed == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confirmationMethod: freezed == confirmationMethod ? _self.confirmationMethod : confirmationMethod // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RemittanceEntry].
extension RemittanceEntryPatterns on RemittanceEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemittanceEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemittanceEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemittanceEntry value)  $default,){
final _that = this;
switch (_that) {
case _RemittanceEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemittanceEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RemittanceEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String recipientName,  String? recipientCountry,  String? relationship,  String provider,  String sourceCurrency,  String? targetCurrency,  int sourceAmountMinor,  int? targetAmountMinor,  int? feeMinor,  double? fxRate,  String? deliveryMethod,  String? deliveryTime,  String status,  String? plannedDate,  DateTime? sentAt,  DateTime? receivedAt,  String? confirmationMethod,  String? notes,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemittanceEntry() when $default != null:
return $default(_that.id,_that.recipientName,_that.recipientCountry,_that.relationship,_that.provider,_that.sourceCurrency,_that.targetCurrency,_that.sourceAmountMinor,_that.targetAmountMinor,_that.feeMinor,_that.fxRate,_that.deliveryMethod,_that.deliveryTime,_that.status,_that.plannedDate,_that.sentAt,_that.receivedAt,_that.confirmationMethod,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String recipientName,  String? recipientCountry,  String? relationship,  String provider,  String sourceCurrency,  String? targetCurrency,  int sourceAmountMinor,  int? targetAmountMinor,  int? feeMinor,  double? fxRate,  String? deliveryMethod,  String? deliveryTime,  String status,  String? plannedDate,  DateTime? sentAt,  DateTime? receivedAt,  String? confirmationMethod,  String? notes,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RemittanceEntry():
return $default(_that.id,_that.recipientName,_that.recipientCountry,_that.relationship,_that.provider,_that.sourceCurrency,_that.targetCurrency,_that.sourceAmountMinor,_that.targetAmountMinor,_that.feeMinor,_that.fxRate,_that.deliveryMethod,_that.deliveryTime,_that.status,_that.plannedDate,_that.sentAt,_that.receivedAt,_that.confirmationMethod,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String recipientName,  String? recipientCountry,  String? relationship,  String provider,  String sourceCurrency,  String? targetCurrency,  int sourceAmountMinor,  int? targetAmountMinor,  int? feeMinor,  double? fxRate,  String? deliveryMethod,  String? deliveryTime,  String status,  String? plannedDate,  DateTime? sentAt,  DateTime? receivedAt,  String? confirmationMethod,  String? notes,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RemittanceEntry() when $default != null:
return $default(_that.id,_that.recipientName,_that.recipientCountry,_that.relationship,_that.provider,_that.sourceCurrency,_that.targetCurrency,_that.sourceAmountMinor,_that.targetAmountMinor,_that.feeMinor,_that.fxRate,_that.deliveryMethod,_that.deliveryTime,_that.status,_that.plannedDate,_that.sentAt,_that.receivedAt,_that.confirmationMethod,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemittanceEntry implements RemittanceEntry {
  const _RemittanceEntry({required this.id, required this.recipientName, this.recipientCountry, this.relationship, required this.provider, required this.sourceCurrency, this.targetCurrency, required this.sourceAmountMinor, this.targetAmountMinor, this.feeMinor, this.fxRate, this.deliveryMethod, this.deliveryTime, required this.status, this.plannedDate, this.sentAt, this.receivedAt, this.confirmationMethod, this.notes, required this.createdAt, this.updatedAt});
  factory _RemittanceEntry.fromJson(Map<String, dynamic> json) => _$RemittanceEntryFromJson(json);

@override final  String id;
@override final  String recipientName;
@override final  String? recipientCountry;
@override final  String? relationship;
@override final  String provider;
@override final  String sourceCurrency;
@override final  String? targetCurrency;
@override final  int sourceAmountMinor;
@override final  int? targetAmountMinor;
@override final  int? feeMinor;
@override final  double? fxRate;
@override final  String? deliveryMethod;
@override final  String? deliveryTime;
@override final  String status;
@override final  String? plannedDate;
@override final  DateTime? sentAt;
@override final  DateTime? receivedAt;
@override final  String? confirmationMethod;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of RemittanceEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemittanceEntryCopyWith<_RemittanceEntry> get copyWith => __$RemittanceEntryCopyWithImpl<_RemittanceEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemittanceEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemittanceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.recipientCountry, recipientCountry) || other.recipientCountry == recipientCountry)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.sourceCurrency, sourceCurrency) || other.sourceCurrency == sourceCurrency)&&(identical(other.targetCurrency, targetCurrency) || other.targetCurrency == targetCurrency)&&(identical(other.sourceAmountMinor, sourceAmountMinor) || other.sourceAmountMinor == sourceAmountMinor)&&(identical(other.targetAmountMinor, targetAmountMinor) || other.targetAmountMinor == targetAmountMinor)&&(identical(other.feeMinor, feeMinor) || other.feeMinor == feeMinor)&&(identical(other.fxRate, fxRate) || other.fxRate == fxRate)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.plannedDate, plannedDate) || other.plannedDate == plannedDate)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.confirmationMethod, confirmationMethod) || other.confirmationMethod == confirmationMethod)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,recipientName,recipientCountry,relationship,provider,sourceCurrency,targetCurrency,sourceAmountMinor,targetAmountMinor,feeMinor,fxRate,deliveryMethod,deliveryTime,status,plannedDate,sentAt,receivedAt,confirmationMethod,notes,createdAt,updatedAt]);

@override
String toString() {
  return 'RemittanceEntry(id: $id, recipientName: $recipientName, recipientCountry: $recipientCountry, relationship: $relationship, provider: $provider, sourceCurrency: $sourceCurrency, targetCurrency: $targetCurrency, sourceAmountMinor: $sourceAmountMinor, targetAmountMinor: $targetAmountMinor, feeMinor: $feeMinor, fxRate: $fxRate, deliveryMethod: $deliveryMethod, deliveryTime: $deliveryTime, status: $status, plannedDate: $plannedDate, sentAt: $sentAt, receivedAt: $receivedAt, confirmationMethod: $confirmationMethod, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RemittanceEntryCopyWith<$Res> implements $RemittanceEntryCopyWith<$Res> {
  factory _$RemittanceEntryCopyWith(_RemittanceEntry value, $Res Function(_RemittanceEntry) _then) = __$RemittanceEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String recipientName, String? recipientCountry, String? relationship, String provider, String sourceCurrency, String? targetCurrency, int sourceAmountMinor, int? targetAmountMinor, int? feeMinor, double? fxRate, String? deliveryMethod, String? deliveryTime, String status, String? plannedDate, DateTime? sentAt, DateTime? receivedAt, String? confirmationMethod, String? notes, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$RemittanceEntryCopyWithImpl<$Res>
    implements _$RemittanceEntryCopyWith<$Res> {
  __$RemittanceEntryCopyWithImpl(this._self, this._then);

  final _RemittanceEntry _self;
  final $Res Function(_RemittanceEntry) _then;

/// Create a copy of RemittanceEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? recipientName = null,Object? recipientCountry = freezed,Object? relationship = freezed,Object? provider = null,Object? sourceCurrency = null,Object? targetCurrency = freezed,Object? sourceAmountMinor = null,Object? targetAmountMinor = freezed,Object? feeMinor = freezed,Object? fxRate = freezed,Object? deliveryMethod = freezed,Object? deliveryTime = freezed,Object? status = null,Object? plannedDate = freezed,Object? sentAt = freezed,Object? receivedAt = freezed,Object? confirmationMethod = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_RemittanceEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,recipientCountry: freezed == recipientCountry ? _self.recipientCountry : recipientCountry // ignore: cast_nullable_to_non_nullable
as String?,relationship: freezed == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String?,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,sourceCurrency: null == sourceCurrency ? _self.sourceCurrency : sourceCurrency // ignore: cast_nullable_to_non_nullable
as String,targetCurrency: freezed == targetCurrency ? _self.targetCurrency : targetCurrency // ignore: cast_nullable_to_non_nullable
as String?,sourceAmountMinor: null == sourceAmountMinor ? _self.sourceAmountMinor : sourceAmountMinor // ignore: cast_nullable_to_non_nullable
as int,targetAmountMinor: freezed == targetAmountMinor ? _self.targetAmountMinor : targetAmountMinor // ignore: cast_nullable_to_non_nullable
as int?,feeMinor: freezed == feeMinor ? _self.feeMinor : feeMinor // ignore: cast_nullable_to_non_nullable
as int?,fxRate: freezed == fxRate ? _self.fxRate : fxRate // ignore: cast_nullable_to_non_nullable
as double?,deliveryMethod: freezed == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as String?,deliveryTime: freezed == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,plannedDate: freezed == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confirmationMethod: freezed == confirmationMethod ? _self.confirmationMethod : confirmationMethod // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$RemittanceSummary {

 int get totalSentThisYear; int get totalPlanned; double get averageFxRate; Map<String, int> get countByProvider;
/// Create a copy of RemittanceSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemittanceSummaryCopyWith<RemittanceSummary> get copyWith => _$RemittanceSummaryCopyWithImpl<RemittanceSummary>(this as RemittanceSummary, _$identity);

  /// Serializes this RemittanceSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemittanceSummary&&(identical(other.totalSentThisYear, totalSentThisYear) || other.totalSentThisYear == totalSentThisYear)&&(identical(other.totalPlanned, totalPlanned) || other.totalPlanned == totalPlanned)&&(identical(other.averageFxRate, averageFxRate) || other.averageFxRate == averageFxRate)&&const DeepCollectionEquality().equals(other.countByProvider, countByProvider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSentThisYear,totalPlanned,averageFxRate,const DeepCollectionEquality().hash(countByProvider));

@override
String toString() {
  return 'RemittanceSummary(totalSentThisYear: $totalSentThisYear, totalPlanned: $totalPlanned, averageFxRate: $averageFxRate, countByProvider: $countByProvider)';
}


}

/// @nodoc
abstract mixin class $RemittanceSummaryCopyWith<$Res>  {
  factory $RemittanceSummaryCopyWith(RemittanceSummary value, $Res Function(RemittanceSummary) _then) = _$RemittanceSummaryCopyWithImpl;
@useResult
$Res call({
 int totalSentThisYear, int totalPlanned, double averageFxRate, Map<String, int> countByProvider
});




}
/// @nodoc
class _$RemittanceSummaryCopyWithImpl<$Res>
    implements $RemittanceSummaryCopyWith<$Res> {
  _$RemittanceSummaryCopyWithImpl(this._self, this._then);

  final RemittanceSummary _self;
  final $Res Function(RemittanceSummary) _then;

/// Create a copy of RemittanceSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSentThisYear = null,Object? totalPlanned = null,Object? averageFxRate = null,Object? countByProvider = null,}) {
  return _then(_self.copyWith(
totalSentThisYear: null == totalSentThisYear ? _self.totalSentThisYear : totalSentThisYear // ignore: cast_nullable_to_non_nullable
as int,totalPlanned: null == totalPlanned ? _self.totalPlanned : totalPlanned // ignore: cast_nullable_to_non_nullable
as int,averageFxRate: null == averageFxRate ? _self.averageFxRate : averageFxRate // ignore: cast_nullable_to_non_nullable
as double,countByProvider: null == countByProvider ? _self.countByProvider : countByProvider // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [RemittanceSummary].
extension RemittanceSummaryPatterns on RemittanceSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemittanceSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemittanceSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemittanceSummary value)  $default,){
final _that = this;
switch (_that) {
case _RemittanceSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemittanceSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RemittanceSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSentThisYear,  int totalPlanned,  double averageFxRate,  Map<String, int> countByProvider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemittanceSummary() when $default != null:
return $default(_that.totalSentThisYear,_that.totalPlanned,_that.averageFxRate,_that.countByProvider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSentThisYear,  int totalPlanned,  double averageFxRate,  Map<String, int> countByProvider)  $default,) {final _that = this;
switch (_that) {
case _RemittanceSummary():
return $default(_that.totalSentThisYear,_that.totalPlanned,_that.averageFxRate,_that.countByProvider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSentThisYear,  int totalPlanned,  double averageFxRate,  Map<String, int> countByProvider)?  $default,) {final _that = this;
switch (_that) {
case _RemittanceSummary() when $default != null:
return $default(_that.totalSentThisYear,_that.totalPlanned,_that.averageFxRate,_that.countByProvider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemittanceSummary implements RemittanceSummary {
  const _RemittanceSummary({required this.totalSentThisYear, required this.totalPlanned, required this.averageFxRate, required final  Map<String, int> countByProvider}): _countByProvider = countByProvider;
  factory _RemittanceSummary.fromJson(Map<String, dynamic> json) => _$RemittanceSummaryFromJson(json);

@override final  int totalSentThisYear;
@override final  int totalPlanned;
@override final  double averageFxRate;
 final  Map<String, int> _countByProvider;
@override Map<String, int> get countByProvider {
  if (_countByProvider is EqualUnmodifiableMapView) return _countByProvider;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_countByProvider);
}


/// Create a copy of RemittanceSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemittanceSummaryCopyWith<_RemittanceSummary> get copyWith => __$RemittanceSummaryCopyWithImpl<_RemittanceSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemittanceSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemittanceSummary&&(identical(other.totalSentThisYear, totalSentThisYear) || other.totalSentThisYear == totalSentThisYear)&&(identical(other.totalPlanned, totalPlanned) || other.totalPlanned == totalPlanned)&&(identical(other.averageFxRate, averageFxRate) || other.averageFxRate == averageFxRate)&&const DeepCollectionEquality().equals(other._countByProvider, _countByProvider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSentThisYear,totalPlanned,averageFxRate,const DeepCollectionEquality().hash(_countByProvider));

@override
String toString() {
  return 'RemittanceSummary(totalSentThisYear: $totalSentThisYear, totalPlanned: $totalPlanned, averageFxRate: $averageFxRate, countByProvider: $countByProvider)';
}


}

/// @nodoc
abstract mixin class _$RemittanceSummaryCopyWith<$Res> implements $RemittanceSummaryCopyWith<$Res> {
  factory _$RemittanceSummaryCopyWith(_RemittanceSummary value, $Res Function(_RemittanceSummary) _then) = __$RemittanceSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalSentThisYear, int totalPlanned, double averageFxRate, Map<String, int> countByProvider
});




}
/// @nodoc
class __$RemittanceSummaryCopyWithImpl<$Res>
    implements _$RemittanceSummaryCopyWith<$Res> {
  __$RemittanceSummaryCopyWithImpl(this._self, this._then);

  final _RemittanceSummary _self;
  final $Res Function(_RemittanceSummary) _then;

/// Create a copy of RemittanceSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSentThisYear = null,Object? totalPlanned = null,Object? averageFxRate = null,Object? countByProvider = null,}) {
  return _then(_RemittanceSummary(
totalSentThisYear: null == totalSentThisYear ? _self.totalSentThisYear : totalSentThisYear // ignore: cast_nullable_to_non_nullable
as int,totalPlanned: null == totalPlanned ? _self.totalPlanned : totalPlanned // ignore: cast_nullable_to_non_nullable
as int,averageFxRate: null == averageFxRate ? _self.averageFxRate : averageFxRate // ignore: cast_nullable_to_non_nullable
as double,countByProvider: null == countByProvider ? _self._countByProvider : countByProvider // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
