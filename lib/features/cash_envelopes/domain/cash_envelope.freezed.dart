// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_envelope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CashEnvelope {

 String get id; String get name; String get category; String get currency; int get budgetMinor; int get spentMinor; String get period; bool get isActive; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of CashEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashEnvelopeCopyWith<CashEnvelope> get copyWith => _$CashEnvelopeCopyWithImpl<CashEnvelope>(this as CashEnvelope, _$identity);

  /// Serializes this CashEnvelope to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashEnvelope&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.budgetMinor, budgetMinor) || other.budgetMinor == budgetMinor)&&(identical(other.spentMinor, spentMinor) || other.spentMinor == spentMinor)&&(identical(other.period, period) || other.period == period)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,currency,budgetMinor,spentMinor,period,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'CashEnvelope(id: $id, name: $name, category: $category, currency: $currency, budgetMinor: $budgetMinor, spentMinor: $spentMinor, period: $period, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CashEnvelopeCopyWith<$Res>  {
  factory $CashEnvelopeCopyWith(CashEnvelope value, $Res Function(CashEnvelope) _then) = _$CashEnvelopeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String currency, int budgetMinor, int spentMinor, String period, bool isActive, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CashEnvelopeCopyWithImpl<$Res>
    implements $CashEnvelopeCopyWith<$Res> {
  _$CashEnvelopeCopyWithImpl(this._self, this._then);

  final CashEnvelope _self;
  final $Res Function(CashEnvelope) _then;

/// Create a copy of CashEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? currency = null,Object? budgetMinor = null,Object? spentMinor = null,Object? period = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budgetMinor: null == budgetMinor ? _self.budgetMinor : budgetMinor // ignore: cast_nullable_to_non_nullable
as int,spentMinor: null == spentMinor ? _self.spentMinor : spentMinor // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashEnvelope].
extension CashEnvelopePatterns on CashEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashEnvelope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashEnvelope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashEnvelope value)  $default,){
final _that = this;
switch (_that) {
case _CashEnvelope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashEnvelope value)?  $default,){
final _that = this;
switch (_that) {
case _CashEnvelope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String currency,  int budgetMinor,  int spentMinor,  String period,  bool isActive,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashEnvelope() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.currency,_that.budgetMinor,_that.spentMinor,_that.period,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String currency,  int budgetMinor,  int spentMinor,  String period,  bool isActive,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CashEnvelope():
return $default(_that.id,_that.name,_that.category,_that.currency,_that.budgetMinor,_that.spentMinor,_that.period,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String currency,  int budgetMinor,  int spentMinor,  String period,  bool isActive,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CashEnvelope() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.currency,_that.budgetMinor,_that.spentMinor,_that.period,_that.isActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashEnvelope implements CashEnvelope {
  const _CashEnvelope({required this.id, required this.name, required this.category, required this.currency, required this.budgetMinor, required this.spentMinor, required this.period, required this.isActive, required this.createdAt, this.updatedAt});
  factory _CashEnvelope.fromJson(Map<String, dynamic> json) => _$CashEnvelopeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override final  String currency;
@override final  int budgetMinor;
@override final  int spentMinor;
@override final  String period;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CashEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashEnvelopeCopyWith<_CashEnvelope> get copyWith => __$CashEnvelopeCopyWithImpl<_CashEnvelope>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashEnvelopeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashEnvelope&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.budgetMinor, budgetMinor) || other.budgetMinor == budgetMinor)&&(identical(other.spentMinor, spentMinor) || other.spentMinor == spentMinor)&&(identical(other.period, period) || other.period == period)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,currency,budgetMinor,spentMinor,period,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'CashEnvelope(id: $id, name: $name, category: $category, currency: $currency, budgetMinor: $budgetMinor, spentMinor: $spentMinor, period: $period, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CashEnvelopeCopyWith<$Res> implements $CashEnvelopeCopyWith<$Res> {
  factory _$CashEnvelopeCopyWith(_CashEnvelope value, $Res Function(_CashEnvelope) _then) = __$CashEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String currency, int budgetMinor, int spentMinor, String period, bool isActive, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CashEnvelopeCopyWithImpl<$Res>
    implements _$CashEnvelopeCopyWith<$Res> {
  __$CashEnvelopeCopyWithImpl(this._self, this._then);

  final _CashEnvelope _self;
  final $Res Function(_CashEnvelope) _then;

/// Create a copy of CashEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? currency = null,Object? budgetMinor = null,Object? spentMinor = null,Object? period = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_CashEnvelope(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budgetMinor: null == budgetMinor ? _self.budgetMinor : budgetMinor // ignore: cast_nullable_to_non_nullable
as int,spentMinor: null == spentMinor ? _self.spentMinor : spentMinor // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
