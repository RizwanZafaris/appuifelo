// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_money.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SendRecipient {

 String get id; String get displayName; String get phoneMasked; String get countryCode;
/// Create a copy of SendRecipient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendRecipientCopyWith<SendRecipient> get copyWith => _$SendRecipientCopyWithImpl<SendRecipient>(this as SendRecipient, _$identity);

  /// Serializes this SendRecipient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendRecipient&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.phoneMasked, phoneMasked) || other.phoneMasked == phoneMasked)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,phoneMasked,countryCode);

@override
String toString() {
  return 'SendRecipient(id: $id, displayName: $displayName, phoneMasked: $phoneMasked, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class $SendRecipientCopyWith<$Res>  {
  factory $SendRecipientCopyWith(SendRecipient value, $Res Function(SendRecipient) _then) = _$SendRecipientCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String phoneMasked, String countryCode
});




}
/// @nodoc
class _$SendRecipientCopyWithImpl<$Res>
    implements $SendRecipientCopyWith<$Res> {
  _$SendRecipientCopyWithImpl(this._self, this._then);

  final SendRecipient _self;
  final $Res Function(SendRecipient) _then;

/// Create a copy of SendRecipient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? phoneMasked = null,Object? countryCode = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,phoneMasked: null == phoneMasked ? _self.phoneMasked : phoneMasked // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SendRecipient].
extension SendRecipientPatterns on SendRecipient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendRecipient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendRecipient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendRecipient value)  $default,){
final _that = this;
switch (_that) {
case _SendRecipient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendRecipient value)?  $default,){
final _that = this;
switch (_that) {
case _SendRecipient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String phoneMasked,  String countryCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendRecipient() when $default != null:
return $default(_that.id,_that.displayName,_that.phoneMasked,_that.countryCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String phoneMasked,  String countryCode)  $default,) {final _that = this;
switch (_that) {
case _SendRecipient():
return $default(_that.id,_that.displayName,_that.phoneMasked,_that.countryCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String phoneMasked,  String countryCode)?  $default,) {final _that = this;
switch (_that) {
case _SendRecipient() when $default != null:
return $default(_that.id,_that.displayName,_that.phoneMasked,_that.countryCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendRecipient implements SendRecipient {
  const _SendRecipient({required this.id, required this.displayName, required this.phoneMasked, required this.countryCode});
  factory _SendRecipient.fromJson(Map<String, dynamic> json) => _$SendRecipientFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String phoneMasked;
@override final  String countryCode;

/// Create a copy of SendRecipient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendRecipientCopyWith<_SendRecipient> get copyWith => __$SendRecipientCopyWithImpl<_SendRecipient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendRecipientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendRecipient&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.phoneMasked, phoneMasked) || other.phoneMasked == phoneMasked)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,phoneMasked,countryCode);

@override
String toString() {
  return 'SendRecipient(id: $id, displayName: $displayName, phoneMasked: $phoneMasked, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$SendRecipientCopyWith<$Res> implements $SendRecipientCopyWith<$Res> {
  factory _$SendRecipientCopyWith(_SendRecipient value, $Res Function(_SendRecipient) _then) = __$SendRecipientCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String phoneMasked, String countryCode
});




}
/// @nodoc
class __$SendRecipientCopyWithImpl<$Res>
    implements _$SendRecipientCopyWith<$Res> {
  __$SendRecipientCopyWithImpl(this._self, this._then);

  final _SendRecipient _self;
  final $Res Function(_SendRecipient) _then;

/// Create a copy of SendRecipient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? phoneMasked = null,Object? countryCode = null,}) {
  return _then(_SendRecipient(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,phoneMasked: null == phoneMasked ? _self.phoneMasked : phoneMasked // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SendMoneyQuote {

 String get sourceCurrency; String get targetCurrency; int get sourceAmountMinor; int get targetAmountMinor; double get rate;
/// Create a copy of SendMoneyQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMoneyQuoteCopyWith<SendMoneyQuote> get copyWith => _$SendMoneyQuoteCopyWithImpl<SendMoneyQuote>(this as SendMoneyQuote, _$identity);

  /// Serializes this SendMoneyQuote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMoneyQuote&&(identical(other.sourceCurrency, sourceCurrency) || other.sourceCurrency == sourceCurrency)&&(identical(other.targetCurrency, targetCurrency) || other.targetCurrency == targetCurrency)&&(identical(other.sourceAmountMinor, sourceAmountMinor) || other.sourceAmountMinor == sourceAmountMinor)&&(identical(other.targetAmountMinor, targetAmountMinor) || other.targetAmountMinor == targetAmountMinor)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceCurrency,targetCurrency,sourceAmountMinor,targetAmountMinor,rate);

@override
String toString() {
  return 'SendMoneyQuote(sourceCurrency: $sourceCurrency, targetCurrency: $targetCurrency, sourceAmountMinor: $sourceAmountMinor, targetAmountMinor: $targetAmountMinor, rate: $rate)';
}


}

/// @nodoc
abstract mixin class $SendMoneyQuoteCopyWith<$Res>  {
  factory $SendMoneyQuoteCopyWith(SendMoneyQuote value, $Res Function(SendMoneyQuote) _then) = _$SendMoneyQuoteCopyWithImpl;
@useResult
$Res call({
 String sourceCurrency, String targetCurrency, int sourceAmountMinor, int targetAmountMinor, double rate
});




}
/// @nodoc
class _$SendMoneyQuoteCopyWithImpl<$Res>
    implements $SendMoneyQuoteCopyWith<$Res> {
  _$SendMoneyQuoteCopyWithImpl(this._self, this._then);

  final SendMoneyQuote _self;
  final $Res Function(SendMoneyQuote) _then;

/// Create a copy of SendMoneyQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceCurrency = null,Object? targetCurrency = null,Object? sourceAmountMinor = null,Object? targetAmountMinor = null,Object? rate = null,}) {
  return _then(_self.copyWith(
sourceCurrency: null == sourceCurrency ? _self.sourceCurrency : sourceCurrency // ignore: cast_nullable_to_non_nullable
as String,targetCurrency: null == targetCurrency ? _self.targetCurrency : targetCurrency // ignore: cast_nullable_to_non_nullable
as String,sourceAmountMinor: null == sourceAmountMinor ? _self.sourceAmountMinor : sourceAmountMinor // ignore: cast_nullable_to_non_nullable
as int,targetAmountMinor: null == targetAmountMinor ? _self.targetAmountMinor : targetAmountMinor // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SendMoneyQuote].
extension SendMoneyQuotePatterns on SendMoneyQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendMoneyQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendMoneyQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendMoneyQuote value)  $default,){
final _that = this;
switch (_that) {
case _SendMoneyQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendMoneyQuote value)?  $default,){
final _that = this;
switch (_that) {
case _SendMoneyQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceCurrency,  String targetCurrency,  int sourceAmountMinor,  int targetAmountMinor,  double rate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendMoneyQuote() when $default != null:
return $default(_that.sourceCurrency,_that.targetCurrency,_that.sourceAmountMinor,_that.targetAmountMinor,_that.rate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceCurrency,  String targetCurrency,  int sourceAmountMinor,  int targetAmountMinor,  double rate)  $default,) {final _that = this;
switch (_that) {
case _SendMoneyQuote():
return $default(_that.sourceCurrency,_that.targetCurrency,_that.sourceAmountMinor,_that.targetAmountMinor,_that.rate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceCurrency,  String targetCurrency,  int sourceAmountMinor,  int targetAmountMinor,  double rate)?  $default,) {final _that = this;
switch (_that) {
case _SendMoneyQuote() when $default != null:
return $default(_that.sourceCurrency,_that.targetCurrency,_that.sourceAmountMinor,_that.targetAmountMinor,_that.rate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendMoneyQuote implements SendMoneyQuote {
  const _SendMoneyQuote({required this.sourceCurrency, required this.targetCurrency, required this.sourceAmountMinor, required this.targetAmountMinor, required this.rate});
  factory _SendMoneyQuote.fromJson(Map<String, dynamic> json) => _$SendMoneyQuoteFromJson(json);

@override final  String sourceCurrency;
@override final  String targetCurrency;
@override final  int sourceAmountMinor;
@override final  int targetAmountMinor;
@override final  double rate;

/// Create a copy of SendMoneyQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendMoneyQuoteCopyWith<_SendMoneyQuote> get copyWith => __$SendMoneyQuoteCopyWithImpl<_SendMoneyQuote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMoneyQuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendMoneyQuote&&(identical(other.sourceCurrency, sourceCurrency) || other.sourceCurrency == sourceCurrency)&&(identical(other.targetCurrency, targetCurrency) || other.targetCurrency == targetCurrency)&&(identical(other.sourceAmountMinor, sourceAmountMinor) || other.sourceAmountMinor == sourceAmountMinor)&&(identical(other.targetAmountMinor, targetAmountMinor) || other.targetAmountMinor == targetAmountMinor)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceCurrency,targetCurrency,sourceAmountMinor,targetAmountMinor,rate);

@override
String toString() {
  return 'SendMoneyQuote(sourceCurrency: $sourceCurrency, targetCurrency: $targetCurrency, sourceAmountMinor: $sourceAmountMinor, targetAmountMinor: $targetAmountMinor, rate: $rate)';
}


}

/// @nodoc
abstract mixin class _$SendMoneyQuoteCopyWith<$Res> implements $SendMoneyQuoteCopyWith<$Res> {
  factory _$SendMoneyQuoteCopyWith(_SendMoneyQuote value, $Res Function(_SendMoneyQuote) _then) = __$SendMoneyQuoteCopyWithImpl;
@override @useResult
$Res call({
 String sourceCurrency, String targetCurrency, int sourceAmountMinor, int targetAmountMinor, double rate
});




}
/// @nodoc
class __$SendMoneyQuoteCopyWithImpl<$Res>
    implements _$SendMoneyQuoteCopyWith<$Res> {
  __$SendMoneyQuoteCopyWithImpl(this._self, this._then);

  final _SendMoneyQuote _self;
  final $Res Function(_SendMoneyQuote) _then;

/// Create a copy of SendMoneyQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceCurrency = null,Object? targetCurrency = null,Object? sourceAmountMinor = null,Object? targetAmountMinor = null,Object? rate = null,}) {
  return _then(_SendMoneyQuote(
sourceCurrency: null == sourceCurrency ? _self.sourceCurrency : sourceCurrency // ignore: cast_nullable_to_non_nullable
as String,targetCurrency: null == targetCurrency ? _self.targetCurrency : targetCurrency // ignore: cast_nullable_to_non_nullable
as String,sourceAmountMinor: null == sourceAmountMinor ? _self.sourceAmountMinor : sourceAmountMinor // ignore: cast_nullable_to_non_nullable
as int,targetAmountMinor: null == targetAmountMinor ? _self.targetAmountMinor : targetAmountMinor // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SendMoneyDraft {

 SendRecipient? get recipient; SendMoneyQuote? get quote; String? get referenceId;
/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMoneyDraftCopyWith<SendMoneyDraft> get copyWith => _$SendMoneyDraftCopyWithImpl<SendMoneyDraft>(this as SendMoneyDraft, _$identity);

  /// Serializes this SendMoneyDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMoneyDraft&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipient,quote,referenceId);

@override
String toString() {
  return 'SendMoneyDraft(recipient: $recipient, quote: $quote, referenceId: $referenceId)';
}


}

/// @nodoc
abstract mixin class $SendMoneyDraftCopyWith<$Res>  {
  factory $SendMoneyDraftCopyWith(SendMoneyDraft value, $Res Function(SendMoneyDraft) _then) = _$SendMoneyDraftCopyWithImpl;
@useResult
$Res call({
 SendRecipient? recipient, SendMoneyQuote? quote, String? referenceId
});


$SendRecipientCopyWith<$Res>? get recipient;$SendMoneyQuoteCopyWith<$Res>? get quote;

}
/// @nodoc
class _$SendMoneyDraftCopyWithImpl<$Res>
    implements $SendMoneyDraftCopyWith<$Res> {
  _$SendMoneyDraftCopyWithImpl(this._self, this._then);

  final SendMoneyDraft _self;
  final $Res Function(SendMoneyDraft) _then;

/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recipient = freezed,Object? quote = freezed,Object? referenceId = freezed,}) {
  return _then(_self.copyWith(
recipient: freezed == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as SendRecipient?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as SendMoneyQuote?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SendRecipientCopyWith<$Res>? get recipient {
    if (_self.recipient == null) {
    return null;
  }

  return $SendRecipientCopyWith<$Res>(_self.recipient!, (value) {
    return _then(_self.copyWith(recipient: value));
  });
}/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SendMoneyQuoteCopyWith<$Res>? get quote {
    if (_self.quote == null) {
    return null;
  }

  return $SendMoneyQuoteCopyWith<$Res>(_self.quote!, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}


/// Adds pattern-matching-related methods to [SendMoneyDraft].
extension SendMoneyDraftPatterns on SendMoneyDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendMoneyDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendMoneyDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendMoneyDraft value)  $default,){
final _that = this;
switch (_that) {
case _SendMoneyDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendMoneyDraft value)?  $default,){
final _that = this;
switch (_that) {
case _SendMoneyDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SendRecipient? recipient,  SendMoneyQuote? quote,  String? referenceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendMoneyDraft() when $default != null:
return $default(_that.recipient,_that.quote,_that.referenceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SendRecipient? recipient,  SendMoneyQuote? quote,  String? referenceId)  $default,) {final _that = this;
switch (_that) {
case _SendMoneyDraft():
return $default(_that.recipient,_that.quote,_that.referenceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SendRecipient? recipient,  SendMoneyQuote? quote,  String? referenceId)?  $default,) {final _that = this;
switch (_that) {
case _SendMoneyDraft() when $default != null:
return $default(_that.recipient,_that.quote,_that.referenceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendMoneyDraft implements SendMoneyDraft {
  const _SendMoneyDraft({this.recipient, this.quote, this.referenceId});
  factory _SendMoneyDraft.fromJson(Map<String, dynamic> json) => _$SendMoneyDraftFromJson(json);

@override final  SendRecipient? recipient;
@override final  SendMoneyQuote? quote;
@override final  String? referenceId;

/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendMoneyDraftCopyWith<_SendMoneyDraft> get copyWith => __$SendMoneyDraftCopyWithImpl<_SendMoneyDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMoneyDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendMoneyDraft&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipient,quote,referenceId);

@override
String toString() {
  return 'SendMoneyDraft(recipient: $recipient, quote: $quote, referenceId: $referenceId)';
}


}

/// @nodoc
abstract mixin class _$SendMoneyDraftCopyWith<$Res> implements $SendMoneyDraftCopyWith<$Res> {
  factory _$SendMoneyDraftCopyWith(_SendMoneyDraft value, $Res Function(_SendMoneyDraft) _then) = __$SendMoneyDraftCopyWithImpl;
@override @useResult
$Res call({
 SendRecipient? recipient, SendMoneyQuote? quote, String? referenceId
});


@override $SendRecipientCopyWith<$Res>? get recipient;@override $SendMoneyQuoteCopyWith<$Res>? get quote;

}
/// @nodoc
class __$SendMoneyDraftCopyWithImpl<$Res>
    implements _$SendMoneyDraftCopyWith<$Res> {
  __$SendMoneyDraftCopyWithImpl(this._self, this._then);

  final _SendMoneyDraft _self;
  final $Res Function(_SendMoneyDraft) _then;

/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recipient = freezed,Object? quote = freezed,Object? referenceId = freezed,}) {
  return _then(_SendMoneyDraft(
recipient: freezed == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as SendRecipient?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as SendMoneyQuote?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SendRecipientCopyWith<$Res>? get recipient {
    if (_self.recipient == null) {
    return null;
  }

  return $SendRecipientCopyWith<$Res>(_self.recipient!, (value) {
    return _then(_self.copyWith(recipient: value));
  });
}/// Create a copy of SendMoneyDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SendMoneyQuoteCopyWith<$Res>? get quote {
    if (_self.quote == null) {
    return null;
  }

  return $SendMoneyQuoteCopyWith<$Res>(_self.quote!, (value) {
    return _then(_self.copyWith(quote: value));
  });
}
}

// dart format on
