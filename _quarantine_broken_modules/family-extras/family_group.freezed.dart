// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FamilyGroup {

 String get id; String get name; String get createdBy; DateTime get createdAt; List<FamilyMember> get members; bool get isDefault;
/// Create a copy of FamilyGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyGroupCopyWith<FamilyGroup> get copyWith => _$FamilyGroupCopyWithImpl<FamilyGroup>(this as FamilyGroup, _$identity);

  /// Serializes this FamilyGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdBy,createdAt,const DeepCollectionEquality().hash(members),isDefault);

@override
String toString() {
  return 'FamilyGroup(id: $id, name: $name, createdBy: $createdBy, createdAt: $createdAt, members: $members, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $FamilyGroupCopyWith<$Res>  {
  factory $FamilyGroupCopyWith(FamilyGroup value, $Res Function(FamilyGroup) _then) = _$FamilyGroupCopyWithImpl;
@useResult
$Res call({
 String id, String name, String createdBy, DateTime createdAt, List<FamilyMember> members, bool isDefault
});




}
/// @nodoc
class _$FamilyGroupCopyWithImpl<$Res>
    implements $FamilyGroupCopyWith<$Res> {
  _$FamilyGroupCopyWithImpl(this._self, this._then);

  final FamilyGroup _self;
  final $Res Function(FamilyGroup) _then;

/// Create a copy of FamilyGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? createdBy = null,Object? createdAt = null,Object? members = null,Object? isDefault = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<FamilyMember>,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FamilyGroup].
extension FamilyGroupPatterns on FamilyGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FamilyGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FamilyGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FamilyGroup value)  $default,){
final _that = this;
switch (_that) {
case _FamilyGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FamilyGroup value)?  $default,){
final _that = this;
switch (_that) {
case _FamilyGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String createdBy,  DateTime createdAt,  List<FamilyMember> members,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyGroup() when $default != null:
return $default(_that.id,_that.name,_that.createdBy,_that.createdAt,_that.members,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String createdBy,  DateTime createdAt,  List<FamilyMember> members,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _FamilyGroup():
return $default(_that.id,_that.name,_that.createdBy,_that.createdAt,_that.members,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String createdBy,  DateTime createdAt,  List<FamilyMember> members,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _FamilyGroup() when $default != null:
return $default(_that.id,_that.name,_that.createdBy,_that.createdAt,_that.members,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FamilyGroup implements FamilyGroup {
  const _FamilyGroup({required this.id, required this.name, required this.createdBy, required this.createdAt, required final  List<FamilyMember> members, this.isDefault = false}): _members = members;
  factory _FamilyGroup.fromJson(Map<String, dynamic> json) => _$FamilyGroupFromJson(json);

@override final  String id;
@override final  String name;
@override final  String createdBy;
@override final  DateTime createdAt;
 final  List<FamilyMember> _members;
@override List<FamilyMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override@JsonKey() final  bool isDefault;

/// Create a copy of FamilyGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyGroupCopyWith<_FamilyGroup> get copyWith => __$FamilyGroupCopyWithImpl<_FamilyGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdBy,createdAt,const DeepCollectionEquality().hash(_members),isDefault);

@override
String toString() {
  return 'FamilyGroup(id: $id, name: $name, createdBy: $createdBy, createdAt: $createdAt, members: $members, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$FamilyGroupCopyWith<$Res> implements $FamilyGroupCopyWith<$Res> {
  factory _$FamilyGroupCopyWith(_FamilyGroup value, $Res Function(_FamilyGroup) _then) = __$FamilyGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String createdBy, DateTime createdAt, List<FamilyMember> members, bool isDefault
});




}
/// @nodoc
class __$FamilyGroupCopyWithImpl<$Res>
    implements _$FamilyGroupCopyWith<$Res> {
  __$FamilyGroupCopyWithImpl(this._self, this._then);

  final _FamilyGroup _self;
  final $Res Function(_FamilyGroup) _then;

/// Create a copy of FamilyGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? createdBy = null,Object? createdAt = null,Object? members = null,Object? isDefault = null,}) {
  return _then(_FamilyGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<FamilyMember>,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
