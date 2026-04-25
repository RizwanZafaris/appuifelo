// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'felo_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeloTransaction {

 String get id; String get accountId; String get merchant; String get category; String get currency; int get amountMinor; TransactionDirection get direction; TransactionSource get source; double get parserConfidence; DateTime get bookedAt; String? get note;
/// Create a copy of FeloTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeloTransactionCopyWith<FeloTransaction> get copyWith => _$FeloTransactionCopyWithImpl<FeloTransaction>(this as FeloTransaction, _$identity);

  /// Serializes this FeloTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeloTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.category, category) || other.category == category)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.source, source) || other.source == source)&&(identical(other.parserConfidence, parserConfidence) || other.parserConfidence == parserConfidence)&&(identical(other.bookedAt, bookedAt) || other.bookedAt == bookedAt)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,merchant,category,currency,amountMinor,direction,source,parserConfidence,bookedAt,note);

@override
String toString() {
  return 'FeloTransaction(id: $id, accountId: $accountId, merchant: $merchant, category: $category, currency: $currency, amountMinor: $amountMinor, direction: $direction, source: $source, parserConfidence: $parserConfidence, bookedAt: $bookedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class $FeloTransactionCopyWith<$Res>  {
  factory $FeloTransactionCopyWith(FeloTransaction value, $Res Function(FeloTransaction) _then) = _$FeloTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, String merchant, String category, String currency, int amountMinor, TransactionDirection direction, TransactionSource source, double parserConfidence, DateTime bookedAt, String? note
});




}
/// @nodoc
class _$FeloTransactionCopyWithImpl<$Res>
    implements $FeloTransactionCopyWith<$Res> {
  _$FeloTransactionCopyWithImpl(this._self, this._then);

  final FeloTransaction _self;
  final $Res Function(FeloTransaction) _then;

/// Create a copy of FeloTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? merchant = null,Object? category = null,Object? currency = null,Object? amountMinor = null,Object? direction = null,Object? source = null,Object? parserConfidence = null,Object? bookedAt = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TransactionDirection,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TransactionSource,parserConfidence: null == parserConfidence ? _self.parserConfidence : parserConfidence // ignore: cast_nullable_to_non_nullable
as double,bookedAt: null == bookedAt ? _self.bookedAt : bookedAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeloTransaction].
extension FeloTransactionPatterns on FeloTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeloTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeloTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeloTransaction value)  $default,){
final _that = this;
switch (_that) {
case _FeloTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeloTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _FeloTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  String merchant,  String category,  String currency,  int amountMinor,  TransactionDirection direction,  TransactionSource source,  double parserConfidence,  DateTime bookedAt,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeloTransaction() when $default != null:
return $default(_that.id,_that.accountId,_that.merchant,_that.category,_that.currency,_that.amountMinor,_that.direction,_that.source,_that.parserConfidence,_that.bookedAt,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  String merchant,  String category,  String currency,  int amountMinor,  TransactionDirection direction,  TransactionSource source,  double parserConfidence,  DateTime bookedAt,  String? note)  $default,) {final _that = this;
switch (_that) {
case _FeloTransaction():
return $default(_that.id,_that.accountId,_that.merchant,_that.category,_that.currency,_that.amountMinor,_that.direction,_that.source,_that.parserConfidence,_that.bookedAt,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  String merchant,  String category,  String currency,  int amountMinor,  TransactionDirection direction,  TransactionSource source,  double parserConfidence,  DateTime bookedAt,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _FeloTransaction() when $default != null:
return $default(_that.id,_that.accountId,_that.merchant,_that.category,_that.currency,_that.amountMinor,_that.direction,_that.source,_that.parserConfidence,_that.bookedAt,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeloTransaction implements FeloTransaction {
  const _FeloTransaction({required this.id, required this.accountId, required this.merchant, required this.category, required this.currency, required this.amountMinor, required this.direction, required this.source, required this.parserConfidence, required this.bookedAt, this.note});
  factory _FeloTransaction.fromJson(Map<String, dynamic> json) => _$FeloTransactionFromJson(json);

@override final  String id;
@override final  String accountId;
@override final  String merchant;
@override final  String category;
@override final  String currency;
@override final  int amountMinor;
@override final  TransactionDirection direction;
@override final  TransactionSource source;
@override final  double parserConfidence;
@override final  DateTime bookedAt;
@override final  String? note;

/// Create a copy of FeloTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeloTransactionCopyWith<_FeloTransaction> get copyWith => __$FeloTransactionCopyWithImpl<_FeloTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeloTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeloTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.category, category) || other.category == category)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.source, source) || other.source == source)&&(identical(other.parserConfidence, parserConfidence) || other.parserConfidence == parserConfidence)&&(identical(other.bookedAt, bookedAt) || other.bookedAt == bookedAt)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,merchant,category,currency,amountMinor,direction,source,parserConfidence,bookedAt,note);

@override
String toString() {
  return 'FeloTransaction(id: $id, accountId: $accountId, merchant: $merchant, category: $category, currency: $currency, amountMinor: $amountMinor, direction: $direction, source: $source, parserConfidence: $parserConfidence, bookedAt: $bookedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class _$FeloTransactionCopyWith<$Res> implements $FeloTransactionCopyWith<$Res> {
  factory _$FeloTransactionCopyWith(_FeloTransaction value, $Res Function(_FeloTransaction) _then) = __$FeloTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, String merchant, String category, String currency, int amountMinor, TransactionDirection direction, TransactionSource source, double parserConfidence, DateTime bookedAt, String? note
});




}
/// @nodoc
class __$FeloTransactionCopyWithImpl<$Res>
    implements _$FeloTransactionCopyWith<$Res> {
  __$FeloTransactionCopyWithImpl(this._self, this._then);

  final _FeloTransaction _self;
  final $Res Function(_FeloTransaction) _then;

/// Create a copy of FeloTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? merchant = null,Object? category = null,Object? currency = null,Object? amountMinor = null,Object? direction = null,Object? source = null,Object? parserConfidence = null,Object? bookedAt = null,Object? note = freezed,}) {
  return _then(_FeloTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TransactionDirection,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TransactionSource,parserConfidence: null == parserConfidence ? _self.parserConfidence : parserConfidence // ignore: cast_nullable_to_non_nullable
as double,bookedAt: null == bookedAt ? _self.bookedAt : bookedAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
