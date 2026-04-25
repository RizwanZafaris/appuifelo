// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_sms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParsedSms {

 String get id; String get source; String get body; int get amount; String get currency; String get merchant; String get category; double get confidence; DateTime get parsedAt;
/// Create a copy of ParsedSms
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedSmsCopyWith<ParsedSms> get copyWith => _$ParsedSmsCopyWithImpl<ParsedSms>(this as ParsedSms, _$identity);

  /// Serializes this ParsedSms to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedSms&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.body, body) || other.body == body)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.category, category) || other.category == category)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.parsedAt, parsedAt) || other.parsedAt == parsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,body,amount,currency,merchant,category,confidence,parsedAt);

@override
String toString() {
  return 'ParsedSms(id: $id, source: $source, body: $body, amount: $amount, currency: $currency, merchant: $merchant, category: $category, confidence: $confidence, parsedAt: $parsedAt)';
}


}

/// @nodoc
abstract mixin class $ParsedSmsCopyWith<$Res>  {
  factory $ParsedSmsCopyWith(ParsedSms value, $Res Function(ParsedSms) _then) = _$ParsedSmsCopyWithImpl;
@useResult
$Res call({
 String id, String source, String body, int amount, String currency, String merchant, String category, double confidence, DateTime parsedAt
});




}
/// @nodoc
class _$ParsedSmsCopyWithImpl<$Res>
    implements $ParsedSmsCopyWith<$Res> {
  _$ParsedSmsCopyWithImpl(this._self, this._then);

  final ParsedSms _self;
  final $Res Function(ParsedSms) _then;

/// Create a copy of ParsedSms
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? body = null,Object? amount = null,Object? currency = null,Object? merchant = null,Object? category = null,Object? confidence = null,Object? parsedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,parsedAt: null == parsedAt ? _self.parsedAt : parsedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ParsedSms].
extension ParsedSmsPatterns on ParsedSms {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParsedSms value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParsedSms() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParsedSms value)  $default,){
final _that = this;
switch (_that) {
case _ParsedSms():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParsedSms value)?  $default,){
final _that = this;
switch (_that) {
case _ParsedSms() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String source,  String body,  int amount,  String currency,  String merchant,  String category,  double confidence,  DateTime parsedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParsedSms() when $default != null:
return $default(_that.id,_that.source,_that.body,_that.amount,_that.currency,_that.merchant,_that.category,_that.confidence,_that.parsedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String source,  String body,  int amount,  String currency,  String merchant,  String category,  double confidence,  DateTime parsedAt)  $default,) {final _that = this;
switch (_that) {
case _ParsedSms():
return $default(_that.id,_that.source,_that.body,_that.amount,_that.currency,_that.merchant,_that.category,_that.confidence,_that.parsedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String source,  String body,  int amount,  String currency,  String merchant,  String category,  double confidence,  DateTime parsedAt)?  $default,) {final _that = this;
switch (_that) {
case _ParsedSms() when $default != null:
return $default(_that.id,_that.source,_that.body,_that.amount,_that.currency,_that.merchant,_that.category,_that.confidence,_that.parsedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParsedSms implements ParsedSms {
  const _ParsedSms({required this.id, required this.source, required this.body, required this.amount, required this.currency, required this.merchant, required this.category, required this.confidence, required this.parsedAt});
  factory _ParsedSms.fromJson(Map<String, dynamic> json) => _$ParsedSmsFromJson(json);

@override final  String id;
@override final  String source;
@override final  String body;
@override final  int amount;
@override final  String currency;
@override final  String merchant;
@override final  String category;
@override final  double confidence;
@override final  DateTime parsedAt;

/// Create a copy of ParsedSms
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParsedSmsCopyWith<_ParsedSms> get copyWith => __$ParsedSmsCopyWithImpl<_ParsedSms>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParsedSmsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParsedSms&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.body, body) || other.body == body)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.category, category) || other.category == category)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.parsedAt, parsedAt) || other.parsedAt == parsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,body,amount,currency,merchant,category,confidence,parsedAt);

@override
String toString() {
  return 'ParsedSms(id: $id, source: $source, body: $body, amount: $amount, currency: $currency, merchant: $merchant, category: $category, confidence: $confidence, parsedAt: $parsedAt)';
}


}

/// @nodoc
abstract mixin class _$ParsedSmsCopyWith<$Res> implements $ParsedSmsCopyWith<$Res> {
  factory _$ParsedSmsCopyWith(_ParsedSms value, $Res Function(_ParsedSms) _then) = __$ParsedSmsCopyWithImpl;
@override @useResult
$Res call({
 String id, String source, String body, int amount, String currency, String merchant, String category, double confidence, DateTime parsedAt
});




}
/// @nodoc
class __$ParsedSmsCopyWithImpl<$Res>
    implements _$ParsedSmsCopyWith<$Res> {
  __$ParsedSmsCopyWithImpl(this._self, this._then);

  final _ParsedSms _self;
  final $Res Function(_ParsedSms) _then;

/// Create a copy of ParsedSms
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? body = null,Object? amount = null,Object? currency = null,Object? merchant = null,Object? category = null,Object? confidence = null,Object? parsedAt = null,}) {
  return _then(_ParsedSms(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,parsedAt: null == parsedAt ? _self.parsedAt : parsedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
