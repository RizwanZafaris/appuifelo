// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remittance_waitlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemittanceWaitlist {

 String get id; String get corridor; bool get joined; DateTime get updatedAt;
/// Create a copy of RemittanceWaitlist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemittanceWaitlistCopyWith<RemittanceWaitlist> get copyWith => _$RemittanceWaitlistCopyWithImpl<RemittanceWaitlist>(this as RemittanceWaitlist, _$identity);

  /// Serializes this RemittanceWaitlist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemittanceWaitlist&&(identical(other.id, id) || other.id == id)&&(identical(other.corridor, corridor) || other.corridor == corridor)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,corridor,joined,updatedAt);

@override
String toString() {
  return 'RemittanceWaitlist(id: $id, corridor: $corridor, joined: $joined, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RemittanceWaitlistCopyWith<$Res>  {
  factory $RemittanceWaitlistCopyWith(RemittanceWaitlist value, $Res Function(RemittanceWaitlist) _then) = _$RemittanceWaitlistCopyWithImpl;
@useResult
$Res call({
 String id, String corridor, bool joined, DateTime updatedAt
});




}
/// @nodoc
class _$RemittanceWaitlistCopyWithImpl<$Res>
    implements $RemittanceWaitlistCopyWith<$Res> {
  _$RemittanceWaitlistCopyWithImpl(this._self, this._then);

  final RemittanceWaitlist _self;
  final $Res Function(RemittanceWaitlist) _then;

/// Create a copy of RemittanceWaitlist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? corridor = null,Object? joined = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,corridor: null == corridor ? _self.corridor : corridor // ignore: cast_nullable_to_non_nullable
as String,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RemittanceWaitlist].
extension RemittanceWaitlistPatterns on RemittanceWaitlist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemittanceWaitlist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemittanceWaitlist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemittanceWaitlist value)  $default,){
final _that = this;
switch (_that) {
case _RemittanceWaitlist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemittanceWaitlist value)?  $default,){
final _that = this;
switch (_that) {
case _RemittanceWaitlist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String corridor,  bool joined,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemittanceWaitlist() when $default != null:
return $default(_that.id,_that.corridor,_that.joined,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String corridor,  bool joined,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RemittanceWaitlist():
return $default(_that.id,_that.corridor,_that.joined,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String corridor,  bool joined,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RemittanceWaitlist() when $default != null:
return $default(_that.id,_that.corridor,_that.joined,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemittanceWaitlist implements RemittanceWaitlist {
  const _RemittanceWaitlist({required this.id, required this.corridor, required this.joined, required this.updatedAt});
  factory _RemittanceWaitlist.fromJson(Map<String, dynamic> json) => _$RemittanceWaitlistFromJson(json);

@override final  String id;
@override final  String corridor;
@override final  bool joined;
@override final  DateTime updatedAt;

/// Create a copy of RemittanceWaitlist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemittanceWaitlistCopyWith<_RemittanceWaitlist> get copyWith => __$RemittanceWaitlistCopyWithImpl<_RemittanceWaitlist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemittanceWaitlistToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemittanceWaitlist&&(identical(other.id, id) || other.id == id)&&(identical(other.corridor, corridor) || other.corridor == corridor)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,corridor,joined,updatedAt);

@override
String toString() {
  return 'RemittanceWaitlist(id: $id, corridor: $corridor, joined: $joined, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RemittanceWaitlistCopyWith<$Res> implements $RemittanceWaitlistCopyWith<$Res> {
  factory _$RemittanceWaitlistCopyWith(_RemittanceWaitlist value, $Res Function(_RemittanceWaitlist) _then) = __$RemittanceWaitlistCopyWithImpl;
@override @useResult
$Res call({
 String id, String corridor, bool joined, DateTime updatedAt
});




}
/// @nodoc
class __$RemittanceWaitlistCopyWithImpl<$Res>
    implements _$RemittanceWaitlistCopyWith<$Res> {
  __$RemittanceWaitlistCopyWithImpl(this._self, this._then);

  final _RemittanceWaitlist _self;
  final $Res Function(_RemittanceWaitlist) _then;

/// Create a copy of RemittanceWaitlist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? corridor = null,Object? joined = null,Object? updatedAt = null,}) {
  return _then(_RemittanceWaitlist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,corridor: null == corridor ? _self.corridor : corridor // ignore: cast_nullable_to_non_nullable
as String,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
