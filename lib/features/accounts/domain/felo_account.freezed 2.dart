// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'felo_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeloAccount {

 String get id; FeloAccountProvider get provider; FeloAccountType get type; String get displayName; String get currency; int get balanceMinor; DateTime get lastSyncedAt; FeloAccountSyncStatus get syncStatus;
/// Create a copy of FeloAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeloAccountCopyWith<FeloAccount> get copyWith => _$FeloAccountCopyWithImpl<FeloAccount>(this as FeloAccount, _$identity);

  /// Serializes this FeloAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeloAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.balanceMinor, balanceMinor) || other.balanceMinor == balanceMinor)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,type,displayName,currency,balanceMinor,lastSyncedAt,syncStatus);

@override
String toString() {
  return 'FeloAccount(id: $id, provider: $provider, type: $type, displayName: $displayName, currency: $currency, balanceMinor: $balanceMinor, lastSyncedAt: $lastSyncedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class $FeloAccountCopyWith<$Res>  {
  factory $FeloAccountCopyWith(FeloAccount value, $Res Function(FeloAccount) _then) = _$FeloAccountCopyWithImpl;
@useResult
$Res call({
 String id, FeloAccountProvider provider, FeloAccountType type, String displayName, String currency, int balanceMinor, DateTime lastSyncedAt, FeloAccountSyncStatus syncStatus
});




}
/// @nodoc
class _$FeloAccountCopyWithImpl<$Res>
    implements $FeloAccountCopyWith<$Res> {
  _$FeloAccountCopyWithImpl(this._self, this._then);

  final FeloAccount _self;
  final $Res Function(FeloAccount) _then;

/// Create a copy of FeloAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? provider = null,Object? type = null,Object? displayName = null,Object? currency = null,Object? balanceMinor = null,Object? lastSyncedAt = null,Object? syncStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as FeloAccountProvider,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeloAccountType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,balanceMinor: null == balanceMinor ? _self.balanceMinor : balanceMinor // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: null == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as FeloAccountSyncStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [FeloAccount].
extension FeloAccountPatterns on FeloAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeloAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeloAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeloAccount value)  $default,){
final _that = this;
switch (_that) {
case _FeloAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeloAccount value)?  $default,){
final _that = this;
switch (_that) {
case _FeloAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FeloAccountProvider provider,  FeloAccountType type,  String displayName,  String currency,  int balanceMinor,  DateTime lastSyncedAt,  FeloAccountSyncStatus syncStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeloAccount() when $default != null:
return $default(_that.id,_that.provider,_that.type,_that.displayName,_that.currency,_that.balanceMinor,_that.lastSyncedAt,_that.syncStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FeloAccountProvider provider,  FeloAccountType type,  String displayName,  String currency,  int balanceMinor,  DateTime lastSyncedAt,  FeloAccountSyncStatus syncStatus)  $default,) {final _that = this;
switch (_that) {
case _FeloAccount():
return $default(_that.id,_that.provider,_that.type,_that.displayName,_that.currency,_that.balanceMinor,_that.lastSyncedAt,_that.syncStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FeloAccountProvider provider,  FeloAccountType type,  String displayName,  String currency,  int balanceMinor,  DateTime lastSyncedAt,  FeloAccountSyncStatus syncStatus)?  $default,) {final _that = this;
switch (_that) {
case _FeloAccount() when $default != null:
return $default(_that.id,_that.provider,_that.type,_that.displayName,_that.currency,_that.balanceMinor,_that.lastSyncedAt,_that.syncStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeloAccount implements FeloAccount {
  const _FeloAccount({required this.id, required this.provider, required this.type, required this.displayName, required this.currency, required this.balanceMinor, required this.lastSyncedAt, required this.syncStatus});
  factory _FeloAccount.fromJson(Map<String, dynamic> json) => _$FeloAccountFromJson(json);

@override final  String id;
@override final  FeloAccountProvider provider;
@override final  FeloAccountType type;
@override final  String displayName;
@override final  String currency;
@override final  int balanceMinor;
@override final  DateTime lastSyncedAt;
@override final  FeloAccountSyncStatus syncStatus;

/// Create a copy of FeloAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeloAccountCopyWith<_FeloAccount> get copyWith => __$FeloAccountCopyWithImpl<_FeloAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeloAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeloAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.balanceMinor, balanceMinor) || other.balanceMinor == balanceMinor)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,type,displayName,currency,balanceMinor,lastSyncedAt,syncStatus);

@override
String toString() {
  return 'FeloAccount(id: $id, provider: $provider, type: $type, displayName: $displayName, currency: $currency, balanceMinor: $balanceMinor, lastSyncedAt: $lastSyncedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class _$FeloAccountCopyWith<$Res> implements $FeloAccountCopyWith<$Res> {
  factory _$FeloAccountCopyWith(_FeloAccount value, $Res Function(_FeloAccount) _then) = __$FeloAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, FeloAccountProvider provider, FeloAccountType type, String displayName, String currency, int balanceMinor, DateTime lastSyncedAt, FeloAccountSyncStatus syncStatus
});




}
/// @nodoc
class __$FeloAccountCopyWithImpl<$Res>
    implements _$FeloAccountCopyWith<$Res> {
  __$FeloAccountCopyWithImpl(this._self, this._then);

  final _FeloAccount _self;
  final $Res Function(_FeloAccount) _then;

/// Create a copy of FeloAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? provider = null,Object? type = null,Object? displayName = null,Object? currency = null,Object? balanceMinor = null,Object? lastSyncedAt = null,Object? syncStatus = null,}) {
  return _then(_FeloAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as FeloAccountProvider,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeloAccountType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,balanceMinor: null == balanceMinor ? _self.balanceMinor : balanceMinor // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: null == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as FeloAccountSyncStatus,
  ));
}


}

/// @nodoc
mixin _$AccountConnectState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountConnectState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountConnectState()';
}


}

/// @nodoc
class $AccountConnectStateCopyWith<$Res>  {
$AccountConnectStateCopyWith(AccountConnectState _, $Res Function(AccountConnectState) __);
}


/// Adds pattern-matching-related methods to [AccountConnectState].
extension AccountConnectStatePatterns on AccountConnectState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountConnectPicker value)?  picker,TResult Function( AccountConnectOAuth value)?  oauth,TResult Function( AccountConnectSuccess value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountConnectPicker() when picker != null:
return picker(_that);case AccountConnectOAuth() when oauth != null:
return oauth(_that);case AccountConnectSuccess() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountConnectPicker value)  picker,required TResult Function( AccountConnectOAuth value)  oauth,required TResult Function( AccountConnectSuccess value)  success,}){
final _that = this;
switch (_that) {
case AccountConnectPicker():
return picker(_that);case AccountConnectOAuth():
return oauth(_that);case AccountConnectSuccess():
return success(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountConnectPicker value)?  picker,TResult? Function( AccountConnectOAuth value)?  oauth,TResult? Function( AccountConnectSuccess value)?  success,}){
final _that = this;
switch (_that) {
case AccountConnectPicker() when picker != null:
return picker(_that);case AccountConnectOAuth() when oauth != null:
return oauth(_that);case AccountConnectSuccess() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  picker,TResult Function( FeloAccountProvider provider)?  oauth,TResult Function( FeloAccount account)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountConnectPicker() when picker != null:
return picker();case AccountConnectOAuth() when oauth != null:
return oauth(_that.provider);case AccountConnectSuccess() when success != null:
return success(_that.account);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  picker,required TResult Function( FeloAccountProvider provider)  oauth,required TResult Function( FeloAccount account)  success,}) {final _that = this;
switch (_that) {
case AccountConnectPicker():
return picker();case AccountConnectOAuth():
return oauth(_that.provider);case AccountConnectSuccess():
return success(_that.account);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  picker,TResult? Function( FeloAccountProvider provider)?  oauth,TResult? Function( FeloAccount account)?  success,}) {final _that = this;
switch (_that) {
case AccountConnectPicker() when picker != null:
return picker();case AccountConnectOAuth() when oauth != null:
return oauth(_that.provider);case AccountConnectSuccess() when success != null:
return success(_that.account);case _:
  return null;

}
}

}

/// @nodoc


class AccountConnectPicker implements AccountConnectState {
  const AccountConnectPicker();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountConnectPicker);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountConnectState.picker()';
}


}




/// @nodoc


class AccountConnectOAuth implements AccountConnectState {
  const AccountConnectOAuth({required this.provider});
  

 final  FeloAccountProvider provider;

/// Create a copy of AccountConnectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountConnectOAuthCopyWith<AccountConnectOAuth> get copyWith => _$AccountConnectOAuthCopyWithImpl<AccountConnectOAuth>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountConnectOAuth&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'AccountConnectState.oauth(provider: $provider)';
}


}

/// @nodoc
abstract mixin class $AccountConnectOAuthCopyWith<$Res> implements $AccountConnectStateCopyWith<$Res> {
  factory $AccountConnectOAuthCopyWith(AccountConnectOAuth value, $Res Function(AccountConnectOAuth) _then) = _$AccountConnectOAuthCopyWithImpl;
@useResult
$Res call({
 FeloAccountProvider provider
});




}
/// @nodoc
class _$AccountConnectOAuthCopyWithImpl<$Res>
    implements $AccountConnectOAuthCopyWith<$Res> {
  _$AccountConnectOAuthCopyWithImpl(this._self, this._then);

  final AccountConnectOAuth _self;
  final $Res Function(AccountConnectOAuth) _then;

/// Create a copy of AccountConnectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(AccountConnectOAuth(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as FeloAccountProvider,
  ));
}


}

/// @nodoc


class AccountConnectSuccess implements AccountConnectState {
  const AccountConnectSuccess({required this.account});
  

 final  FeloAccount account;

/// Create a copy of AccountConnectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountConnectSuccessCopyWith<AccountConnectSuccess> get copyWith => _$AccountConnectSuccessCopyWithImpl<AccountConnectSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountConnectSuccess&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString() {
  return 'AccountConnectState.success(account: $account)';
}


}

/// @nodoc
abstract mixin class $AccountConnectSuccessCopyWith<$Res> implements $AccountConnectStateCopyWith<$Res> {
  factory $AccountConnectSuccessCopyWith(AccountConnectSuccess value, $Res Function(AccountConnectSuccess) _then) = _$AccountConnectSuccessCopyWithImpl;
@useResult
$Res call({
 FeloAccount account
});


$FeloAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$AccountConnectSuccessCopyWithImpl<$Res>
    implements $AccountConnectSuccessCopyWith<$Res> {
  _$AccountConnectSuccessCopyWithImpl(this._self, this._then);

  final AccountConnectSuccess _self;
  final $Res Function(AccountConnectSuccess) _then;

/// Create a copy of AccountConnectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(AccountConnectSuccess(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as FeloAccount,
  ));
}

/// Create a copy of AccountConnectState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeloAccountCopyWith<$Res> get account {
  
  return $FeloAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
