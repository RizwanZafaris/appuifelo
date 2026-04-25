// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_capture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiptLineItem {

 String get name; int get amountMinor;
/// Create a copy of ReceiptLineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptLineItemCopyWith<ReceiptLineItem> get copyWith => _$ReceiptLineItemCopyWithImpl<ReceiptLineItem>(this as ReceiptLineItem, _$identity);

  /// Serializes this ReceiptLineItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptLineItem&&(identical(other.name, name) || other.name == name)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amountMinor);

@override
String toString() {
  return 'ReceiptLineItem(name: $name, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class $ReceiptLineItemCopyWith<$Res>  {
  factory $ReceiptLineItemCopyWith(ReceiptLineItem value, $Res Function(ReceiptLineItem) _then) = _$ReceiptLineItemCopyWithImpl;
@useResult
$Res call({
 String name, int amountMinor
});




}
/// @nodoc
class _$ReceiptLineItemCopyWithImpl<$Res>
    implements $ReceiptLineItemCopyWith<$Res> {
  _$ReceiptLineItemCopyWithImpl(this._self, this._then);

  final ReceiptLineItem _self;
  final $Res Function(ReceiptLineItem) _then;

/// Create a copy of ReceiptLineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? amountMinor = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiptLineItem].
extension ReceiptLineItemPatterns on ReceiptLineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiptLineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiptLineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiptLineItem value)  $default,){
final _that = this;
switch (_that) {
case _ReceiptLineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiptLineItem value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiptLineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int amountMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiptLineItem() when $default != null:
return $default(_that.name,_that.amountMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int amountMinor)  $default,) {final _that = this;
switch (_that) {
case _ReceiptLineItem():
return $default(_that.name,_that.amountMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int amountMinor)?  $default,) {final _that = this;
switch (_that) {
case _ReceiptLineItem() when $default != null:
return $default(_that.name,_that.amountMinor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReceiptLineItem implements ReceiptLineItem {
  const _ReceiptLineItem({required this.name, required this.amountMinor});
  factory _ReceiptLineItem.fromJson(Map<String, dynamic> json) => _$ReceiptLineItemFromJson(json);

@override final  String name;
@override final  int amountMinor;

/// Create a copy of ReceiptLineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptLineItemCopyWith<_ReceiptLineItem> get copyWith => __$ReceiptLineItemCopyWithImpl<_ReceiptLineItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiptLineItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptLineItem&&(identical(other.name, name) || other.name == name)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amountMinor);

@override
String toString() {
  return 'ReceiptLineItem(name: $name, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class _$ReceiptLineItemCopyWith<$Res> implements $ReceiptLineItemCopyWith<$Res> {
  factory _$ReceiptLineItemCopyWith(_ReceiptLineItem value, $Res Function(_ReceiptLineItem) _then) = __$ReceiptLineItemCopyWithImpl;
@override @useResult
$Res call({
 String name, int amountMinor
});




}
/// @nodoc
class __$ReceiptLineItemCopyWithImpl<$Res>
    implements _$ReceiptLineItemCopyWith<$Res> {
  __$ReceiptLineItemCopyWithImpl(this._self, this._then);

  final _ReceiptLineItem _self;
  final $Res Function(_ReceiptLineItem) _then;

/// Create a copy of ReceiptLineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? amountMinor = null,}) {
  return _then(_ReceiptLineItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReceiptOcrResult {

 String get id; String get transactionId; String get merchant; DateTime get purchasedAt; String get currency; int get totalMinor; List<ReceiptLineItem> get lineItems; double get confidence;
/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptOcrResultCopyWith<ReceiptOcrResult> get copyWith => _$ReceiptOcrResultCopyWithImpl<ReceiptOcrResult>(this as ReceiptOcrResult, _$identity);

  /// Serializes this ReceiptOcrResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptOcrResult&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.purchasedAt, purchasedAt) || other.purchasedAt == purchasedAt)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&const DeepCollectionEquality().equals(other.lineItems, lineItems)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,merchant,purchasedAt,currency,totalMinor,const DeepCollectionEquality().hash(lineItems),confidence);

@override
String toString() {
  return 'ReceiptOcrResult(id: $id, transactionId: $transactionId, merchant: $merchant, purchasedAt: $purchasedAt, currency: $currency, totalMinor: $totalMinor, lineItems: $lineItems, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $ReceiptOcrResultCopyWith<$Res>  {
  factory $ReceiptOcrResultCopyWith(ReceiptOcrResult value, $Res Function(ReceiptOcrResult) _then) = _$ReceiptOcrResultCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String merchant, DateTime purchasedAt, String currency, int totalMinor, List<ReceiptLineItem> lineItems, double confidence
});




}
/// @nodoc
class _$ReceiptOcrResultCopyWithImpl<$Res>
    implements $ReceiptOcrResultCopyWith<$Res> {
  _$ReceiptOcrResultCopyWithImpl(this._self, this._then);

  final ReceiptOcrResult _self;
  final $Res Function(ReceiptOcrResult) _then;

/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? merchant = null,Object? purchasedAt = null,Object? currency = null,Object? totalMinor = null,Object? lineItems = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,purchasedAt: null == purchasedAt ? _self.purchasedAt : purchasedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,lineItems: null == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<ReceiptLineItem>,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiptOcrResult].
extension ReceiptOcrResultPatterns on ReceiptOcrResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiptOcrResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiptOcrResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiptOcrResult value)  $default,){
final _that = this;
switch (_that) {
case _ReceiptOcrResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiptOcrResult value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiptOcrResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String transactionId,  String merchant,  DateTime purchasedAt,  String currency,  int totalMinor,  List<ReceiptLineItem> lineItems,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiptOcrResult() when $default != null:
return $default(_that.id,_that.transactionId,_that.merchant,_that.purchasedAt,_that.currency,_that.totalMinor,_that.lineItems,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String transactionId,  String merchant,  DateTime purchasedAt,  String currency,  int totalMinor,  List<ReceiptLineItem> lineItems,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _ReceiptOcrResult():
return $default(_that.id,_that.transactionId,_that.merchant,_that.purchasedAt,_that.currency,_that.totalMinor,_that.lineItems,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String transactionId,  String merchant,  DateTime purchasedAt,  String currency,  int totalMinor,  List<ReceiptLineItem> lineItems,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _ReceiptOcrResult() when $default != null:
return $default(_that.id,_that.transactionId,_that.merchant,_that.purchasedAt,_that.currency,_that.totalMinor,_that.lineItems,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReceiptOcrResult implements ReceiptOcrResult {
  const _ReceiptOcrResult({required this.id, required this.transactionId, required this.merchant, required this.purchasedAt, required this.currency, required this.totalMinor, required final  List<ReceiptLineItem> lineItems, required this.confidence}): _lineItems = lineItems;
  factory _ReceiptOcrResult.fromJson(Map<String, dynamic> json) => _$ReceiptOcrResultFromJson(json);

@override final  String id;
@override final  String transactionId;
@override final  String merchant;
@override final  DateTime purchasedAt;
@override final  String currency;
@override final  int totalMinor;
 final  List<ReceiptLineItem> _lineItems;
@override List<ReceiptLineItem> get lineItems {
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineItems);
}

@override final  double confidence;

/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptOcrResultCopyWith<_ReceiptOcrResult> get copyWith => __$ReceiptOcrResultCopyWithImpl<_ReceiptOcrResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiptOcrResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptOcrResult&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.purchasedAt, purchasedAt) || other.purchasedAt == purchasedAt)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&const DeepCollectionEquality().equals(other._lineItems, _lineItems)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,merchant,purchasedAt,currency,totalMinor,const DeepCollectionEquality().hash(_lineItems),confidence);

@override
String toString() {
  return 'ReceiptOcrResult(id: $id, transactionId: $transactionId, merchant: $merchant, purchasedAt: $purchasedAt, currency: $currency, totalMinor: $totalMinor, lineItems: $lineItems, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ReceiptOcrResultCopyWith<$Res> implements $ReceiptOcrResultCopyWith<$Res> {
  factory _$ReceiptOcrResultCopyWith(_ReceiptOcrResult value, $Res Function(_ReceiptOcrResult) _then) = __$ReceiptOcrResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String merchant, DateTime purchasedAt, String currency, int totalMinor, List<ReceiptLineItem> lineItems, double confidence
});




}
/// @nodoc
class __$ReceiptOcrResultCopyWithImpl<$Res>
    implements _$ReceiptOcrResultCopyWith<$Res> {
  __$ReceiptOcrResultCopyWithImpl(this._self, this._then);

  final _ReceiptOcrResult _self;
  final $Res Function(_ReceiptOcrResult) _then;

/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? merchant = null,Object? purchasedAt = null,Object? currency = null,Object? totalMinor = null,Object? lineItems = null,Object? confidence = null,}) {
  return _then(_ReceiptOcrResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,purchasedAt: null == purchasedAt ? _self.purchasedAt : purchasedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,lineItems: null == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<ReceiptLineItem>,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ReceiptCaptureState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptCaptureState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReceiptCaptureState()';
}


}

/// @nodoc
class $ReceiptCaptureStateCopyWith<$Res>  {
$ReceiptCaptureStateCopyWith(ReceiptCaptureState _, $Res Function(ReceiptCaptureState) __);
}


/// Adds pattern-matching-related methods to [ReceiptCaptureState].
extension ReceiptCaptureStatePatterns on ReceiptCaptureState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReceiptCaptureIdle value)?  idle,TResult Function( ReceiptCaptureProcessing value)?  processing,TResult Function( ReceiptCaptureReady value)?  ready,TResult Function( ReceiptCaptureConfirmed value)?  confirmed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReceiptCaptureIdle() when idle != null:
return idle(_that);case ReceiptCaptureProcessing() when processing != null:
return processing(_that);case ReceiptCaptureReady() when ready != null:
return ready(_that);case ReceiptCaptureConfirmed() when confirmed != null:
return confirmed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReceiptCaptureIdle value)  idle,required TResult Function( ReceiptCaptureProcessing value)  processing,required TResult Function( ReceiptCaptureReady value)  ready,required TResult Function( ReceiptCaptureConfirmed value)  confirmed,}){
final _that = this;
switch (_that) {
case ReceiptCaptureIdle():
return idle(_that);case ReceiptCaptureProcessing():
return processing(_that);case ReceiptCaptureReady():
return ready(_that);case ReceiptCaptureConfirmed():
return confirmed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReceiptCaptureIdle value)?  idle,TResult? Function( ReceiptCaptureProcessing value)?  processing,TResult? Function( ReceiptCaptureReady value)?  ready,TResult? Function( ReceiptCaptureConfirmed value)?  confirmed,}){
final _that = this;
switch (_that) {
case ReceiptCaptureIdle() when idle != null:
return idle(_that);case ReceiptCaptureProcessing() when processing != null:
return processing(_that);case ReceiptCaptureReady() when ready != null:
return ready(_that);case ReceiptCaptureConfirmed() when confirmed != null:
return confirmed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( ReceiptCaptureSource source)?  processing,TResult Function( ReceiptOcrResult result,  bool editing)?  ready,TResult Function( ReceiptOcrResult result)?  confirmed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReceiptCaptureIdle() when idle != null:
return idle();case ReceiptCaptureProcessing() when processing != null:
return processing(_that.source);case ReceiptCaptureReady() when ready != null:
return ready(_that.result,_that.editing);case ReceiptCaptureConfirmed() when confirmed != null:
return confirmed(_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( ReceiptCaptureSource source)  processing,required TResult Function( ReceiptOcrResult result,  bool editing)  ready,required TResult Function( ReceiptOcrResult result)  confirmed,}) {final _that = this;
switch (_that) {
case ReceiptCaptureIdle():
return idle();case ReceiptCaptureProcessing():
return processing(_that.source);case ReceiptCaptureReady():
return ready(_that.result,_that.editing);case ReceiptCaptureConfirmed():
return confirmed(_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( ReceiptCaptureSource source)?  processing,TResult? Function( ReceiptOcrResult result,  bool editing)?  ready,TResult? Function( ReceiptOcrResult result)?  confirmed,}) {final _that = this;
switch (_that) {
case ReceiptCaptureIdle() when idle != null:
return idle();case ReceiptCaptureProcessing() when processing != null:
return processing(_that.source);case ReceiptCaptureReady() when ready != null:
return ready(_that.result,_that.editing);case ReceiptCaptureConfirmed() when confirmed != null:
return confirmed(_that.result);case _:
  return null;

}
}

}

/// @nodoc


class ReceiptCaptureIdle implements ReceiptCaptureState {
  const ReceiptCaptureIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptCaptureIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReceiptCaptureState.idle()';
}


}




/// @nodoc


class ReceiptCaptureProcessing implements ReceiptCaptureState {
  const ReceiptCaptureProcessing({required this.source});
  

 final  ReceiptCaptureSource source;

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptCaptureProcessingCopyWith<ReceiptCaptureProcessing> get copyWith => _$ReceiptCaptureProcessingCopyWithImpl<ReceiptCaptureProcessing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptCaptureProcessing&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'ReceiptCaptureState.processing(source: $source)';
}


}

/// @nodoc
abstract mixin class $ReceiptCaptureProcessingCopyWith<$Res> implements $ReceiptCaptureStateCopyWith<$Res> {
  factory $ReceiptCaptureProcessingCopyWith(ReceiptCaptureProcessing value, $Res Function(ReceiptCaptureProcessing) _then) = _$ReceiptCaptureProcessingCopyWithImpl;
@useResult
$Res call({
 ReceiptCaptureSource source
});




}
/// @nodoc
class _$ReceiptCaptureProcessingCopyWithImpl<$Res>
    implements $ReceiptCaptureProcessingCopyWith<$Res> {
  _$ReceiptCaptureProcessingCopyWithImpl(this._self, this._then);

  final ReceiptCaptureProcessing _self;
  final $Res Function(ReceiptCaptureProcessing) _then;

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(ReceiptCaptureProcessing(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ReceiptCaptureSource,
  ));
}


}

/// @nodoc


class ReceiptCaptureReady implements ReceiptCaptureState {
  const ReceiptCaptureReady({required this.result, this.editing = false});
  

 final  ReceiptOcrResult result;
@JsonKey() final  bool editing;

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptCaptureReadyCopyWith<ReceiptCaptureReady> get copyWith => _$ReceiptCaptureReadyCopyWithImpl<ReceiptCaptureReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptCaptureReady&&(identical(other.result, result) || other.result == result)&&(identical(other.editing, editing) || other.editing == editing));
}


@override
int get hashCode => Object.hash(runtimeType,result,editing);

@override
String toString() {
  return 'ReceiptCaptureState.ready(result: $result, editing: $editing)';
}


}

/// @nodoc
abstract mixin class $ReceiptCaptureReadyCopyWith<$Res> implements $ReceiptCaptureStateCopyWith<$Res> {
  factory $ReceiptCaptureReadyCopyWith(ReceiptCaptureReady value, $Res Function(ReceiptCaptureReady) _then) = _$ReceiptCaptureReadyCopyWithImpl;
@useResult
$Res call({
 ReceiptOcrResult result, bool editing
});


$ReceiptOcrResultCopyWith<$Res> get result;

}
/// @nodoc
class _$ReceiptCaptureReadyCopyWithImpl<$Res>
    implements $ReceiptCaptureReadyCopyWith<$Res> {
  _$ReceiptCaptureReadyCopyWithImpl(this._self, this._then);

  final ReceiptCaptureReady _self;
  final $Res Function(ReceiptCaptureReady) _then;

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,Object? editing = null,}) {
  return _then(ReceiptCaptureReady(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ReceiptOcrResult,editing: null == editing ? _self.editing : editing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReceiptOcrResultCopyWith<$Res> get result {
  
  return $ReceiptOcrResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class ReceiptCaptureConfirmed implements ReceiptCaptureState {
  const ReceiptCaptureConfirmed({required this.result});
  

 final  ReceiptOcrResult result;

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptCaptureConfirmedCopyWith<ReceiptCaptureConfirmed> get copyWith => _$ReceiptCaptureConfirmedCopyWithImpl<ReceiptCaptureConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptCaptureConfirmed&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ReceiptCaptureState.confirmed(result: $result)';
}


}

/// @nodoc
abstract mixin class $ReceiptCaptureConfirmedCopyWith<$Res> implements $ReceiptCaptureStateCopyWith<$Res> {
  factory $ReceiptCaptureConfirmedCopyWith(ReceiptCaptureConfirmed value, $Res Function(ReceiptCaptureConfirmed) _then) = _$ReceiptCaptureConfirmedCopyWithImpl;
@useResult
$Res call({
 ReceiptOcrResult result
});


$ReceiptOcrResultCopyWith<$Res> get result;

}
/// @nodoc
class _$ReceiptCaptureConfirmedCopyWithImpl<$Res>
    implements $ReceiptCaptureConfirmedCopyWith<$Res> {
  _$ReceiptCaptureConfirmedCopyWithImpl(this._self, this._then);

  final ReceiptCaptureConfirmed _self;
  final $Res Function(ReceiptCaptureConfirmed) _then;

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(ReceiptCaptureConfirmed(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ReceiptOcrResult,
  ));
}

/// Create a copy of ReceiptCaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReceiptOcrResultCopyWith<$Res> get result {
  
  return $ReceiptOcrResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
