// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FamilyMember {

 String get id; String get displayName; String get phoneMasked; FamilyRole get role; bool get canViewSharedTransactions; bool get canEditSharedBudgets;
/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyMemberCopyWith<FamilyMember> get copyWith => _$FamilyMemberCopyWithImpl<FamilyMember>(this as FamilyMember, _$identity);

  /// Serializes this FamilyMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.phoneMasked, phoneMasked) || other.phoneMasked == phoneMasked)&&(identical(other.role, role) || other.role == role)&&(identical(other.canViewSharedTransactions, canViewSharedTransactions) || other.canViewSharedTransactions == canViewSharedTransactions)&&(identical(other.canEditSharedBudgets, canEditSharedBudgets) || other.canEditSharedBudgets == canEditSharedBudgets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,phoneMasked,role,canViewSharedTransactions,canEditSharedBudgets);

@override
String toString() {
  return 'FamilyMember(id: $id, displayName: $displayName, phoneMasked: $phoneMasked, role: $role, canViewSharedTransactions: $canViewSharedTransactions, canEditSharedBudgets: $canEditSharedBudgets)';
}


}

/// @nodoc
abstract mixin class $FamilyMemberCopyWith<$Res>  {
  factory $FamilyMemberCopyWith(FamilyMember value, $Res Function(FamilyMember) _then) = _$FamilyMemberCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String phoneMasked, FamilyRole role, bool canViewSharedTransactions, bool canEditSharedBudgets
});




}
/// @nodoc
class _$FamilyMemberCopyWithImpl<$Res>
    implements $FamilyMemberCopyWith<$Res> {
  _$FamilyMemberCopyWithImpl(this._self, this._then);

  final FamilyMember _self;
  final $Res Function(FamilyMember) _then;

/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? phoneMasked = null,Object? role = null,Object? canViewSharedTransactions = null,Object? canEditSharedBudgets = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,phoneMasked: null == phoneMasked ? _self.phoneMasked : phoneMasked // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as FamilyRole,canViewSharedTransactions: null == canViewSharedTransactions ? _self.canViewSharedTransactions : canViewSharedTransactions // ignore: cast_nullable_to_non_nullable
as bool,canEditSharedBudgets: null == canEditSharedBudgets ? _self.canEditSharedBudgets : canEditSharedBudgets // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FamilyMember].
extension FamilyMemberPatterns on FamilyMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FamilyMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FamilyMember value)  $default,){
final _that = this;
switch (_that) {
case _FamilyMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FamilyMember value)?  $default,){
final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String phoneMasked,  FamilyRole role,  bool canViewSharedTransactions,  bool canEditSharedBudgets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
return $default(_that.id,_that.displayName,_that.phoneMasked,_that.role,_that.canViewSharedTransactions,_that.canEditSharedBudgets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String phoneMasked,  FamilyRole role,  bool canViewSharedTransactions,  bool canEditSharedBudgets)  $default,) {final _that = this;
switch (_that) {
case _FamilyMember():
return $default(_that.id,_that.displayName,_that.phoneMasked,_that.role,_that.canViewSharedTransactions,_that.canEditSharedBudgets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String phoneMasked,  FamilyRole role,  bool canViewSharedTransactions,  bool canEditSharedBudgets)?  $default,) {final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
return $default(_that.id,_that.displayName,_that.phoneMasked,_that.role,_that.canViewSharedTransactions,_that.canEditSharedBudgets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FamilyMember implements FamilyMember {
  const _FamilyMember({required this.id, required this.displayName, required this.phoneMasked, required this.role, required this.canViewSharedTransactions, required this.canEditSharedBudgets});
  factory _FamilyMember.fromJson(Map<String, dynamic> json) => _$FamilyMemberFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String phoneMasked;
@override final  FamilyRole role;
@override final  bool canViewSharedTransactions;
@override final  bool canEditSharedBudgets;

/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyMemberCopyWith<_FamilyMember> get copyWith => __$FamilyMemberCopyWithImpl<_FamilyMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.phoneMasked, phoneMasked) || other.phoneMasked == phoneMasked)&&(identical(other.role, role) || other.role == role)&&(identical(other.canViewSharedTransactions, canViewSharedTransactions) || other.canViewSharedTransactions == canViewSharedTransactions)&&(identical(other.canEditSharedBudgets, canEditSharedBudgets) || other.canEditSharedBudgets == canEditSharedBudgets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,phoneMasked,role,canViewSharedTransactions,canEditSharedBudgets);

@override
String toString() {
  return 'FamilyMember(id: $id, displayName: $displayName, phoneMasked: $phoneMasked, role: $role, canViewSharedTransactions: $canViewSharedTransactions, canEditSharedBudgets: $canEditSharedBudgets)';
}


}

/// @nodoc
abstract mixin class _$FamilyMemberCopyWith<$Res> implements $FamilyMemberCopyWith<$Res> {
  factory _$FamilyMemberCopyWith(_FamilyMember value, $Res Function(_FamilyMember) _then) = __$FamilyMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String phoneMasked, FamilyRole role, bool canViewSharedTransactions, bool canEditSharedBudgets
});




}
/// @nodoc
class __$FamilyMemberCopyWithImpl<$Res>
    implements _$FamilyMemberCopyWith<$Res> {
  __$FamilyMemberCopyWithImpl(this._self, this._then);

  final _FamilyMember _self;
  final $Res Function(_FamilyMember) _then;

/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? phoneMasked = null,Object? role = null,Object? canViewSharedTransactions = null,Object? canEditSharedBudgets = null,}) {
  return _then(_FamilyMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,phoneMasked: null == phoneMasked ? _self.phoneMasked : phoneMasked // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as FamilyRole,canViewSharedTransactions: null == canViewSharedTransactions ? _self.canViewSharedTransactions : canViewSharedTransactions // ignore: cast_nullable_to_non_nullable
as bool,canEditSharedBudgets: null == canEditSharedBudgets ? _self.canEditSharedBudgets : canEditSharedBudgets // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
