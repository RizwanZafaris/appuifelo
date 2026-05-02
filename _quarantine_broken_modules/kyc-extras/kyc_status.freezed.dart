// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KycStatus {

 String get id; KycState get state; String? get idType; DateTime? get submittedAt; DateTime? get reviewedAt; String? get rejectionReason; bool get documentsUploaded; bool get selfieUploaded;
/// Create a copy of KycStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycStatusCopyWith<KycStatus> get copyWith => _$KycStatusCopyWithImpl<KycStatus>(this as KycStatus, _$identity);

  /// Serializes this KycStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.state, state) || other.state == state)&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.documentsUploaded, documentsUploaded) || other.documentsUploaded == documentsUploaded)&&(identical(other.selfieUploaded, selfieUploaded) || other.selfieUploaded == selfieUploaded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,state,idType,submittedAt,reviewedAt,rejectionReason,documentsUploaded,selfieUploaded);

@override
String toString() {
  return 'KycStatus(id: $id, state: $state, idType: $idType, submittedAt: $submittedAt, reviewedAt: $reviewedAt, rejectionReason: $rejectionReason, documentsUploaded: $documentsUploaded, selfieUploaded: $selfieUploaded)';
}


}

/// @nodoc
abstract mixin class $KycStatusCopyWith<$Res>  {
  factory $KycStatusCopyWith(KycStatus value, $Res Function(KycStatus) _then) = _$KycStatusCopyWithImpl;
@useResult
$Res call({
 String id, KycState state, String? idType, DateTime? submittedAt, DateTime? reviewedAt, String? rejectionReason, bool documentsUploaded, bool selfieUploaded
});




}
/// @nodoc
class _$KycStatusCopyWithImpl<$Res>
    implements $KycStatusCopyWith<$Res> {
  _$KycStatusCopyWithImpl(this._self, this._then);

  final KycStatus _self;
  final $Res Function(KycStatus) _then;

/// Create a copy of KycStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? state = null,Object? idType = freezed,Object? submittedAt = freezed,Object? reviewedAt = freezed,Object? rejectionReason = freezed,Object? documentsUploaded = null,Object? selfieUploaded = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as KycState,idType: freezed == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,documentsUploaded: null == documentsUploaded ? _self.documentsUploaded : documentsUploaded // ignore: cast_nullable_to_non_nullable
as bool,selfieUploaded: null == selfieUploaded ? _self.selfieUploaded : selfieUploaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [KycStatus].
extension KycStatusPatterns on KycStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycStatus value)  $default,){
final _that = this;
switch (_that) {
case _KycStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycStatus value)?  $default,){
final _that = this;
switch (_that) {
case _KycStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  KycState state,  String? idType,  DateTime? submittedAt,  DateTime? reviewedAt,  String? rejectionReason,  bool documentsUploaded,  bool selfieUploaded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycStatus() when $default != null:
return $default(_that.id,_that.state,_that.idType,_that.submittedAt,_that.reviewedAt,_that.rejectionReason,_that.documentsUploaded,_that.selfieUploaded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  KycState state,  String? idType,  DateTime? submittedAt,  DateTime? reviewedAt,  String? rejectionReason,  bool documentsUploaded,  bool selfieUploaded)  $default,) {final _that = this;
switch (_that) {
case _KycStatus():
return $default(_that.id,_that.state,_that.idType,_that.submittedAt,_that.reviewedAt,_that.rejectionReason,_that.documentsUploaded,_that.selfieUploaded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  KycState state,  String? idType,  DateTime? submittedAt,  DateTime? reviewedAt,  String? rejectionReason,  bool documentsUploaded,  bool selfieUploaded)?  $default,) {final _that = this;
switch (_that) {
case _KycStatus() when $default != null:
return $default(_that.id,_that.state,_that.idType,_that.submittedAt,_that.reviewedAt,_that.rejectionReason,_that.documentsUploaded,_that.selfieUploaded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KycStatus implements KycStatus {
  const _KycStatus({required this.id, required this.state, this.idType, this.submittedAt, this.reviewedAt, this.rejectionReason, this.documentsUploaded = false, this.selfieUploaded = false});
  factory _KycStatus.fromJson(Map<String, dynamic> json) => _$KycStatusFromJson(json);

@override final  String id;
@override final  KycState state;
@override final  String? idType;
@override final  DateTime? submittedAt;
@override final  DateTime? reviewedAt;
@override final  String? rejectionReason;
@override@JsonKey() final  bool documentsUploaded;
@override@JsonKey() final  bool selfieUploaded;

/// Create a copy of KycStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycStatusCopyWith<_KycStatus> get copyWith => __$KycStatusCopyWithImpl<_KycStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KycStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.state, state) || other.state == state)&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.documentsUploaded, documentsUploaded) || other.documentsUploaded == documentsUploaded)&&(identical(other.selfieUploaded, selfieUploaded) || other.selfieUploaded == selfieUploaded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,state,idType,submittedAt,reviewedAt,rejectionReason,documentsUploaded,selfieUploaded);

@override
String toString() {
  return 'KycStatus(id: $id, state: $state, idType: $idType, submittedAt: $submittedAt, reviewedAt: $reviewedAt, rejectionReason: $rejectionReason, documentsUploaded: $documentsUploaded, selfieUploaded: $selfieUploaded)';
}


}

/// @nodoc
abstract mixin class _$KycStatusCopyWith<$Res> implements $KycStatusCopyWith<$Res> {
  factory _$KycStatusCopyWith(_KycStatus value, $Res Function(_KycStatus) _then) = __$KycStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, KycState state, String? idType, DateTime? submittedAt, DateTime? reviewedAt, String? rejectionReason, bool documentsUploaded, bool selfieUploaded
});




}
/// @nodoc
class __$KycStatusCopyWithImpl<$Res>
    implements _$KycStatusCopyWith<$Res> {
  __$KycStatusCopyWithImpl(this._self, this._then);

  final _KycStatus _self;
  final $Res Function(_KycStatus) _then;

/// Create a copy of KycStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? state = null,Object? idType = freezed,Object? submittedAt = freezed,Object? reviewedAt = freezed,Object? rejectionReason = freezed,Object? documentsUploaded = null,Object? selfieUploaded = null,}) {
  return _then(_KycStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as KycState,idType: freezed == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,documentsUploaded: null == documentsUploaded ? _self.documentsUploaded : documentsUploaded // ignore: cast_nullable_to_non_nullable
as bool,selfieUploaded: null == selfieUploaded ? _self.selfieUploaded : selfieUploaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
