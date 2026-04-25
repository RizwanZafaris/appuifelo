// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'split.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SplitParticipant {

 String get id; String get splitId; String get displayName; String get contact; int get shareMinor; int get paidMinor; SplitParticipantStatus get status;
/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitParticipantCopyWith<SplitParticipant> get copyWith => _$SplitParticipantCopyWithImpl<SplitParticipant>(this as SplitParticipant, _$identity);

  /// Serializes this SplitParticipant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.splitId, splitId) || other.splitId == splitId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.shareMinor, shareMinor) || other.shareMinor == shareMinor)&&(identical(other.paidMinor, paidMinor) || other.paidMinor == paidMinor)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,splitId,displayName,contact,shareMinor,paidMinor,status);

@override
String toString() {
  return 'SplitParticipant(id: $id, splitId: $splitId, displayName: $displayName, contact: $contact, shareMinor: $shareMinor, paidMinor: $paidMinor, status: $status)';
}


}

/// @nodoc
abstract mixin class $SplitParticipantCopyWith<$Res>  {
  factory $SplitParticipantCopyWith(SplitParticipant value, $Res Function(SplitParticipant) _then) = _$SplitParticipantCopyWithImpl;
@useResult
$Res call({
 String id, String splitId, String displayName, String contact, int shareMinor, int paidMinor, SplitParticipantStatus status
});




}
/// @nodoc
class _$SplitParticipantCopyWithImpl<$Res>
    implements $SplitParticipantCopyWith<$Res> {
  _$SplitParticipantCopyWithImpl(this._self, this._then);

  final SplitParticipant _self;
  final $Res Function(SplitParticipant) _then;

/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? splitId = null,Object? displayName = null,Object? contact = null,Object? shareMinor = null,Object? paidMinor = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,splitId: null == splitId ? _self.splitId : splitId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String,shareMinor: null == shareMinor ? _self.shareMinor : shareMinor // ignore: cast_nullable_to_non_nullable
as int,paidMinor: null == paidMinor ? _self.paidMinor : paidMinor // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitParticipantStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [SplitParticipant].
extension SplitParticipantPatterns on SplitParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplitParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplitParticipant value)  $default,){
final _that = this;
switch (_that) {
case _SplitParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplitParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String splitId,  String displayName,  String contact,  int shareMinor,  int paidMinor,  SplitParticipantStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
return $default(_that.id,_that.splitId,_that.displayName,_that.contact,_that.shareMinor,_that.paidMinor,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String splitId,  String displayName,  String contact,  int shareMinor,  int paidMinor,  SplitParticipantStatus status)  $default,) {final _that = this;
switch (_that) {
case _SplitParticipant():
return $default(_that.id,_that.splitId,_that.displayName,_that.contact,_that.shareMinor,_that.paidMinor,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String splitId,  String displayName,  String contact,  int shareMinor,  int paidMinor,  SplitParticipantStatus status)?  $default,) {final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
return $default(_that.id,_that.splitId,_that.displayName,_that.contact,_that.shareMinor,_that.paidMinor,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SplitParticipant implements SplitParticipant {
  const _SplitParticipant({required this.id, required this.splitId, required this.displayName, required this.contact, required this.shareMinor, required this.paidMinor, required this.status});
  factory _SplitParticipant.fromJson(Map<String, dynamic> json) => _$SplitParticipantFromJson(json);

@override final  String id;
@override final  String splitId;
@override final  String displayName;
@override final  String contact;
@override final  int shareMinor;
@override final  int paidMinor;
@override final  SplitParticipantStatus status;

/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitParticipantCopyWith<_SplitParticipant> get copyWith => __$SplitParticipantCopyWithImpl<_SplitParticipant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplitParticipantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplitParticipant&&(identical(other.id, id) || other.id == id)&&(identical(other.splitId, splitId) || other.splitId == splitId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.shareMinor, shareMinor) || other.shareMinor == shareMinor)&&(identical(other.paidMinor, paidMinor) || other.paidMinor == paidMinor)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,splitId,displayName,contact,shareMinor,paidMinor,status);

@override
String toString() {
  return 'SplitParticipant(id: $id, splitId: $splitId, displayName: $displayName, contact: $contact, shareMinor: $shareMinor, paidMinor: $paidMinor, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SplitParticipantCopyWith<$Res> implements $SplitParticipantCopyWith<$Res> {
  factory _$SplitParticipantCopyWith(_SplitParticipant value, $Res Function(_SplitParticipant) _then) = __$SplitParticipantCopyWithImpl;
@override @useResult
$Res call({
 String id, String splitId, String displayName, String contact, int shareMinor, int paidMinor, SplitParticipantStatus status
});




}
/// @nodoc
class __$SplitParticipantCopyWithImpl<$Res>
    implements _$SplitParticipantCopyWith<$Res> {
  __$SplitParticipantCopyWithImpl(this._self, this._then);

  final _SplitParticipant _self;
  final $Res Function(_SplitParticipant) _then;

/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? splitId = null,Object? displayName = null,Object? contact = null,Object? shareMinor = null,Object? paidMinor = null,Object? status = null,}) {
  return _then(_SplitParticipant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,splitId: null == splitId ? _self.splitId : splitId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String,shareMinor: null == shareMinor ? _self.shareMinor : shareMinor // ignore: cast_nullable_to_non_nullable
as int,paidMinor: null == paidMinor ? _self.paidMinor : paidMinor // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitParticipantStatus,
  ));
}


}


/// @nodoc
mixin _$Split {

 String get id; String get name; String get currency; int get totalMinor; SplitStatus get status; DateTime get createdAt; List<SplitParticipant> get participants;
/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitCopyWith<Split> get copyWith => _$SplitCopyWithImpl<Split>(this as Split, _$identity);

  /// Serializes this Split to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Split&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.participants, participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,currency,totalMinor,status,createdAt,const DeepCollectionEquality().hash(participants));

@override
String toString() {
  return 'Split(id: $id, name: $name, currency: $currency, totalMinor: $totalMinor, status: $status, createdAt: $createdAt, participants: $participants)';
}


}

/// @nodoc
abstract mixin class $SplitCopyWith<$Res>  {
  factory $SplitCopyWith(Split value, $Res Function(Split) _then) = _$SplitCopyWithImpl;
@useResult
$Res call({
 String id, String name, String currency, int totalMinor, SplitStatus status, DateTime createdAt, List<SplitParticipant> participants
});




}
/// @nodoc
class _$SplitCopyWithImpl<$Res>
    implements $SplitCopyWith<$Res> {
  _$SplitCopyWithImpl(this._self, this._then);

  final Split _self;
  final $Res Function(Split) _then;

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? currency = null,Object? totalMinor = null,Object? status = null,Object? createdAt = null,Object? participants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<SplitParticipant>,
  ));
}

}


/// Adds pattern-matching-related methods to [Split].
extension SplitPatterns on Split {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Split value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Split() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Split value)  $default,){
final _that = this;
switch (_that) {
case _Split():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Split value)?  $default,){
final _that = this;
switch (_that) {
case _Split() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String currency,  int totalMinor,  SplitStatus status,  DateTime createdAt,  List<SplitParticipant> participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Split() when $default != null:
return $default(_that.id,_that.name,_that.currency,_that.totalMinor,_that.status,_that.createdAt,_that.participants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String currency,  int totalMinor,  SplitStatus status,  DateTime createdAt,  List<SplitParticipant> participants)  $default,) {final _that = this;
switch (_that) {
case _Split():
return $default(_that.id,_that.name,_that.currency,_that.totalMinor,_that.status,_that.createdAt,_that.participants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String currency,  int totalMinor,  SplitStatus status,  DateTime createdAt,  List<SplitParticipant> participants)?  $default,) {final _that = this;
switch (_that) {
case _Split() when $default != null:
return $default(_that.id,_that.name,_that.currency,_that.totalMinor,_that.status,_that.createdAt,_that.participants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Split implements Split {
  const _Split({required this.id, required this.name, required this.currency, required this.totalMinor, required this.status, required this.createdAt, required final  List<SplitParticipant> participants}): _participants = participants;
  factory _Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);

@override final  String id;
@override final  String name;
@override final  String currency;
@override final  int totalMinor;
@override final  SplitStatus status;
@override final  DateTime createdAt;
 final  List<SplitParticipant> _participants;
@override List<SplitParticipant> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}


/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitCopyWith<_Split> get copyWith => __$SplitCopyWithImpl<_Split>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Split&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._participants, _participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,currency,totalMinor,status,createdAt,const DeepCollectionEquality().hash(_participants));

@override
String toString() {
  return 'Split(id: $id, name: $name, currency: $currency, totalMinor: $totalMinor, status: $status, createdAt: $createdAt, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$SplitCopyWith<$Res> implements $SplitCopyWith<$Res> {
  factory _$SplitCopyWith(_Split value, $Res Function(_Split) _then) = __$SplitCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String currency, int totalMinor, SplitStatus status, DateTime createdAt, List<SplitParticipant> participants
});




}
/// @nodoc
class __$SplitCopyWithImpl<$Res>
    implements _$SplitCopyWith<$Res> {
  __$SplitCopyWithImpl(this._self, this._then);

  final _Split _self;
  final $Res Function(_Split) _then;

/// Create a copy of Split
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? currency = null,Object? totalMinor = null,Object? status = null,Object? createdAt = null,Object? participants = null,}) {
  return _then(_Split(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<SplitParticipant>,
  ));
}


}

// dart format on
