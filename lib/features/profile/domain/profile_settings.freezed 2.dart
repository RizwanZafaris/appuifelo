// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileSettings {

 String get languageCode; FeloThemeMode get themeMode; bool get operationalNotifications; bool get marketingConsent; bool get smsParserEnabled;
/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSettingsCopyWith<ProfileSettings> get copyWith => _$ProfileSettingsCopyWithImpl<ProfileSettings>(this as ProfileSettings, _$identity);

  /// Serializes this ProfileSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSettings&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.operationalNotifications, operationalNotifications) || other.operationalNotifications == operationalNotifications)&&(identical(other.marketingConsent, marketingConsent) || other.marketingConsent == marketingConsent)&&(identical(other.smsParserEnabled, smsParserEnabled) || other.smsParserEnabled == smsParserEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,themeMode,operationalNotifications,marketingConsent,smsParserEnabled);

@override
String toString() {
  return 'ProfileSettings(languageCode: $languageCode, themeMode: $themeMode, operationalNotifications: $operationalNotifications, marketingConsent: $marketingConsent, smsParserEnabled: $smsParserEnabled)';
}


}

/// @nodoc
abstract mixin class $ProfileSettingsCopyWith<$Res>  {
  factory $ProfileSettingsCopyWith(ProfileSettings value, $Res Function(ProfileSettings) _then) = _$ProfileSettingsCopyWithImpl;
@useResult
$Res call({
 String languageCode, FeloThemeMode themeMode, bool operationalNotifications, bool marketingConsent, bool smsParserEnabled
});




}
/// @nodoc
class _$ProfileSettingsCopyWithImpl<$Res>
    implements $ProfileSettingsCopyWith<$Res> {
  _$ProfileSettingsCopyWithImpl(this._self, this._then);

  final ProfileSettings _self;
  final $Res Function(ProfileSettings) _then;

/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,Object? themeMode = null,Object? operationalNotifications = null,Object? marketingConsent = null,Object? smsParserEnabled = null,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as FeloThemeMode,operationalNotifications: null == operationalNotifications ? _self.operationalNotifications : operationalNotifications // ignore: cast_nullable_to_non_nullable
as bool,marketingConsent: null == marketingConsent ? _self.marketingConsent : marketingConsent // ignore: cast_nullable_to_non_nullable
as bool,smsParserEnabled: null == smsParserEnabled ? _self.smsParserEnabled : smsParserEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSettings].
extension ProfileSettingsPatterns on ProfileSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSettings value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String languageCode,  FeloThemeMode themeMode,  bool operationalNotifications,  bool marketingConsent,  bool smsParserEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
return $default(_that.languageCode,_that.themeMode,_that.operationalNotifications,_that.marketingConsent,_that.smsParserEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String languageCode,  FeloThemeMode themeMode,  bool operationalNotifications,  bool marketingConsent,  bool smsParserEnabled)  $default,) {final _that = this;
switch (_that) {
case _ProfileSettings():
return $default(_that.languageCode,_that.themeMode,_that.operationalNotifications,_that.marketingConsent,_that.smsParserEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String languageCode,  FeloThemeMode themeMode,  bool operationalNotifications,  bool marketingConsent,  bool smsParserEnabled)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSettings() when $default != null:
return $default(_that.languageCode,_that.themeMode,_that.operationalNotifications,_that.marketingConsent,_that.smsParserEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileSettings implements ProfileSettings {
  const _ProfileSettings({required this.languageCode, required this.themeMode, required this.operationalNotifications, required this.marketingConsent, required this.smsParserEnabled});
  factory _ProfileSettings.fromJson(Map<String, dynamic> json) => _$ProfileSettingsFromJson(json);

@override final  String languageCode;
@override final  FeloThemeMode themeMode;
@override final  bool operationalNotifications;
@override final  bool marketingConsent;
@override final  bool smsParserEnabled;

/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSettingsCopyWith<_ProfileSettings> get copyWith => __$ProfileSettingsCopyWithImpl<_ProfileSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSettings&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.operationalNotifications, operationalNotifications) || other.operationalNotifications == operationalNotifications)&&(identical(other.marketingConsent, marketingConsent) || other.marketingConsent == marketingConsent)&&(identical(other.smsParserEnabled, smsParserEnabled) || other.smsParserEnabled == smsParserEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,themeMode,operationalNotifications,marketingConsent,smsParserEnabled);

@override
String toString() {
  return 'ProfileSettings(languageCode: $languageCode, themeMode: $themeMode, operationalNotifications: $operationalNotifications, marketingConsent: $marketingConsent, smsParserEnabled: $smsParserEnabled)';
}


}

/// @nodoc
abstract mixin class _$ProfileSettingsCopyWith<$Res> implements $ProfileSettingsCopyWith<$Res> {
  factory _$ProfileSettingsCopyWith(_ProfileSettings value, $Res Function(_ProfileSettings) _then) = __$ProfileSettingsCopyWithImpl;
@override @useResult
$Res call({
 String languageCode, FeloThemeMode themeMode, bool operationalNotifications, bool marketingConsent, bool smsParserEnabled
});




}
/// @nodoc
class __$ProfileSettingsCopyWithImpl<$Res>
    implements _$ProfileSettingsCopyWith<$Res> {
  __$ProfileSettingsCopyWithImpl(this._self, this._then);

  final _ProfileSettings _self;
  final $Res Function(_ProfileSettings) _then;

/// Create a copy of ProfileSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,Object? themeMode = null,Object? operationalNotifications = null,Object? marketingConsent = null,Object? smsParserEnabled = null,}) {
  return _then(_ProfileSettings(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as FeloThemeMode,operationalNotifications: null == operationalNotifications ? _self.operationalNotifications : operationalNotifications // ignore: cast_nullable_to_non_nullable
as bool,marketingConsent: null == marketingConsent ? _self.marketingConsent : marketingConsent // ignore: cast_nullable_to_non_nullable
as bool,smsParserEnabled: null == smsParserEnabled ? _self.smsParserEnabled : smsParserEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
