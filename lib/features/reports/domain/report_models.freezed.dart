// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyReport {

 ReportPeriod get period; MoneyPulse get moneyPulse; List<TopMover> get topMovers; List<BillAhead> get billsAhead; List<GoalAtRisk> get goalsAtRisk; List<SharedObligation> get sharedObligations; String get aiSuggestion;
/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyReportCopyWith<WeeklyReport> get copyWith => _$WeeklyReportCopyWithImpl<WeeklyReport>(this as WeeklyReport, _$identity);

  /// Serializes this WeeklyReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyReport&&(identical(other.period, period) || other.period == period)&&(identical(other.moneyPulse, moneyPulse) || other.moneyPulse == moneyPulse)&&const DeepCollectionEquality().equals(other.topMovers, topMovers)&&const DeepCollectionEquality().equals(other.billsAhead, billsAhead)&&const DeepCollectionEquality().equals(other.goalsAtRisk, goalsAtRisk)&&const DeepCollectionEquality().equals(other.sharedObligations, sharedObligations)&&(identical(other.aiSuggestion, aiSuggestion) || other.aiSuggestion == aiSuggestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,moneyPulse,const DeepCollectionEquality().hash(topMovers),const DeepCollectionEquality().hash(billsAhead),const DeepCollectionEquality().hash(goalsAtRisk),const DeepCollectionEquality().hash(sharedObligations),aiSuggestion);

@override
String toString() {
  return 'WeeklyReport(period: $period, moneyPulse: $moneyPulse, topMovers: $topMovers, billsAhead: $billsAhead, goalsAtRisk: $goalsAtRisk, sharedObligations: $sharedObligations, aiSuggestion: $aiSuggestion)';
}


}

/// @nodoc
abstract mixin class $WeeklyReportCopyWith<$Res>  {
  factory $WeeklyReportCopyWith(WeeklyReport value, $Res Function(WeeklyReport) _then) = _$WeeklyReportCopyWithImpl;
@useResult
$Res call({
 ReportPeriod period, MoneyPulse moneyPulse, List<TopMover> topMovers, List<BillAhead> billsAhead, List<GoalAtRisk> goalsAtRisk, List<SharedObligation> sharedObligations, String aiSuggestion
});


$ReportPeriodCopyWith<$Res> get period;$MoneyPulseCopyWith<$Res> get moneyPulse;

}
/// @nodoc
class _$WeeklyReportCopyWithImpl<$Res>
    implements $WeeklyReportCopyWith<$Res> {
  _$WeeklyReportCopyWithImpl(this._self, this._then);

  final WeeklyReport _self;
  final $Res Function(WeeklyReport) _then;

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? moneyPulse = null,Object? topMovers = null,Object? billsAhead = null,Object? goalsAtRisk = null,Object? sharedObligations = null,Object? aiSuggestion = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,moneyPulse: null == moneyPulse ? _self.moneyPulse : moneyPulse // ignore: cast_nullable_to_non_nullable
as MoneyPulse,topMovers: null == topMovers ? _self.topMovers : topMovers // ignore: cast_nullable_to_non_nullable
as List<TopMover>,billsAhead: null == billsAhead ? _self.billsAhead : billsAhead // ignore: cast_nullable_to_non_nullable
as List<BillAhead>,goalsAtRisk: null == goalsAtRisk ? _self.goalsAtRisk : goalsAtRisk // ignore: cast_nullable_to_non_nullable
as List<GoalAtRisk>,sharedObligations: null == sharedObligations ? _self.sharedObligations : sharedObligations // ignore: cast_nullable_to_non_nullable
as List<SharedObligation>,aiSuggestion: null == aiSuggestion ? _self.aiSuggestion : aiSuggestion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportPeriodCopyWith<$Res> get period {
  
  return $ReportPeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyPulseCopyWith<$Res> get moneyPulse {
  
  return $MoneyPulseCopyWith<$Res>(_self.moneyPulse, (value) {
    return _then(_self.copyWith(moneyPulse: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeeklyReport].
extension WeeklyReportPatterns on WeeklyReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyReport value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyReport value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportPeriod period,  MoneyPulse moneyPulse,  List<TopMover> topMovers,  List<BillAhead> billsAhead,  List<GoalAtRisk> goalsAtRisk,  List<SharedObligation> sharedObligations,  String aiSuggestion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
return $default(_that.period,_that.moneyPulse,_that.topMovers,_that.billsAhead,_that.goalsAtRisk,_that.sharedObligations,_that.aiSuggestion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportPeriod period,  MoneyPulse moneyPulse,  List<TopMover> topMovers,  List<BillAhead> billsAhead,  List<GoalAtRisk> goalsAtRisk,  List<SharedObligation> sharedObligations,  String aiSuggestion)  $default,) {final _that = this;
switch (_that) {
case _WeeklyReport():
return $default(_that.period,_that.moneyPulse,_that.topMovers,_that.billsAhead,_that.goalsAtRisk,_that.sharedObligations,_that.aiSuggestion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportPeriod period,  MoneyPulse moneyPulse,  List<TopMover> topMovers,  List<BillAhead> billsAhead,  List<GoalAtRisk> goalsAtRisk,  List<SharedObligation> sharedObligations,  String aiSuggestion)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
return $default(_that.period,_that.moneyPulse,_that.topMovers,_that.billsAhead,_that.goalsAtRisk,_that.sharedObligations,_that.aiSuggestion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyReport implements WeeklyReport {
  const _WeeklyReport({required this.period, required this.moneyPulse, required final  List<TopMover> topMovers, required final  List<BillAhead> billsAhead, required final  List<GoalAtRisk> goalsAtRisk, required final  List<SharedObligation> sharedObligations, required this.aiSuggestion}): _topMovers = topMovers,_billsAhead = billsAhead,_goalsAtRisk = goalsAtRisk,_sharedObligations = sharedObligations;
  factory _WeeklyReport.fromJson(Map<String, dynamic> json) => _$WeeklyReportFromJson(json);

@override final  ReportPeriod period;
@override final  MoneyPulse moneyPulse;
 final  List<TopMover> _topMovers;
@override List<TopMover> get topMovers {
  if (_topMovers is EqualUnmodifiableListView) return _topMovers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topMovers);
}

 final  List<BillAhead> _billsAhead;
@override List<BillAhead> get billsAhead {
  if (_billsAhead is EqualUnmodifiableListView) return _billsAhead;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_billsAhead);
}

 final  List<GoalAtRisk> _goalsAtRisk;
@override List<GoalAtRisk> get goalsAtRisk {
  if (_goalsAtRisk is EqualUnmodifiableListView) return _goalsAtRisk;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goalsAtRisk);
}

 final  List<SharedObligation> _sharedObligations;
@override List<SharedObligation> get sharedObligations {
  if (_sharedObligations is EqualUnmodifiableListView) return _sharedObligations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedObligations);
}

@override final  String aiSuggestion;

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyReportCopyWith<_WeeklyReport> get copyWith => __$WeeklyReportCopyWithImpl<_WeeklyReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyReport&&(identical(other.period, period) || other.period == period)&&(identical(other.moneyPulse, moneyPulse) || other.moneyPulse == moneyPulse)&&const DeepCollectionEquality().equals(other._topMovers, _topMovers)&&const DeepCollectionEquality().equals(other._billsAhead, _billsAhead)&&const DeepCollectionEquality().equals(other._goalsAtRisk, _goalsAtRisk)&&const DeepCollectionEquality().equals(other._sharedObligations, _sharedObligations)&&(identical(other.aiSuggestion, aiSuggestion) || other.aiSuggestion == aiSuggestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,moneyPulse,const DeepCollectionEquality().hash(_topMovers),const DeepCollectionEquality().hash(_billsAhead),const DeepCollectionEquality().hash(_goalsAtRisk),const DeepCollectionEquality().hash(_sharedObligations),aiSuggestion);

@override
String toString() {
  return 'WeeklyReport(period: $period, moneyPulse: $moneyPulse, topMovers: $topMovers, billsAhead: $billsAhead, goalsAtRisk: $goalsAtRisk, sharedObligations: $sharedObligations, aiSuggestion: $aiSuggestion)';
}


}

/// @nodoc
abstract mixin class _$WeeklyReportCopyWith<$Res> implements $WeeklyReportCopyWith<$Res> {
  factory _$WeeklyReportCopyWith(_WeeklyReport value, $Res Function(_WeeklyReport) _then) = __$WeeklyReportCopyWithImpl;
@override @useResult
$Res call({
 ReportPeriod period, MoneyPulse moneyPulse, List<TopMover> topMovers, List<BillAhead> billsAhead, List<GoalAtRisk> goalsAtRisk, List<SharedObligation> sharedObligations, String aiSuggestion
});


@override $ReportPeriodCopyWith<$Res> get period;@override $MoneyPulseCopyWith<$Res> get moneyPulse;

}
/// @nodoc
class __$WeeklyReportCopyWithImpl<$Res>
    implements _$WeeklyReportCopyWith<$Res> {
  __$WeeklyReportCopyWithImpl(this._self, this._then);

  final _WeeklyReport _self;
  final $Res Function(_WeeklyReport) _then;

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? moneyPulse = null,Object? topMovers = null,Object? billsAhead = null,Object? goalsAtRisk = null,Object? sharedObligations = null,Object? aiSuggestion = null,}) {
  return _then(_WeeklyReport(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,moneyPulse: null == moneyPulse ? _self.moneyPulse : moneyPulse // ignore: cast_nullable_to_non_nullable
as MoneyPulse,topMovers: null == topMovers ? _self._topMovers : topMovers // ignore: cast_nullable_to_non_nullable
as List<TopMover>,billsAhead: null == billsAhead ? _self._billsAhead : billsAhead // ignore: cast_nullable_to_non_nullable
as List<BillAhead>,goalsAtRisk: null == goalsAtRisk ? _self._goalsAtRisk : goalsAtRisk // ignore: cast_nullable_to_non_nullable
as List<GoalAtRisk>,sharedObligations: null == sharedObligations ? _self._sharedObligations : sharedObligations // ignore: cast_nullable_to_non_nullable
as List<SharedObligation>,aiSuggestion: null == aiSuggestion ? _self.aiSuggestion : aiSuggestion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportPeriodCopyWith<$Res> get period {
  
  return $ReportPeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyPulseCopyWith<$Res> get moneyPulse {
  
  return $MoneyPulseCopyWith<$Res>(_self.moneyPulse, (value) {
    return _then(_self.copyWith(moneyPulse: value));
  });
}
}


/// @nodoc
mixin _$ReportPeriod {

 String get start; String get end;
/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportPeriodCopyWith<ReportPeriod> get copyWith => _$ReportPeriodCopyWithImpl<ReportPeriod>(this as ReportPeriod, _$identity);

  /// Serializes this ReportPeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportPeriod&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'ReportPeriod(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $ReportPeriodCopyWith<$Res>  {
  factory $ReportPeriodCopyWith(ReportPeriod value, $Res Function(ReportPeriod) _then) = _$ReportPeriodCopyWithImpl;
@useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class _$ReportPeriodCopyWithImpl<$Res>
    implements $ReportPeriodCopyWith<$Res> {
  _$ReportPeriodCopyWithImpl(this._self, this._then);

  final ReportPeriod _self;
  final $Res Function(ReportPeriod) _then;

/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportPeriod].
extension ReportPeriodPatterns on ReportPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportPeriod value)  $default,){
final _that = this;
switch (_that) {
case _ReportPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String start,  String end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String start,  String end)  $default,) {final _that = this;
switch (_that) {
case _ReportPeriod():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String start,  String end)?  $default,) {final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportPeriod implements ReportPeriod {
  const _ReportPeriod({required this.start, required this.end});
  factory _ReportPeriod.fromJson(Map<String, dynamic> json) => _$ReportPeriodFromJson(json);

@override final  String start;
@override final  String end;

/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportPeriodCopyWith<_ReportPeriod> get copyWith => __$ReportPeriodCopyWithImpl<_ReportPeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportPeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportPeriod&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'ReportPeriod(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$ReportPeriodCopyWith<$Res> implements $ReportPeriodCopyWith<$Res> {
  factory _$ReportPeriodCopyWith(_ReportPeriod value, $Res Function(_ReportPeriod) _then) = __$ReportPeriodCopyWithImpl;
@override @useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class __$ReportPeriodCopyWithImpl<$Res>
    implements _$ReportPeriodCopyWith<$Res> {
  __$ReportPeriodCopyWithImpl(this._self, this._then);

  final _ReportPeriod _self;
  final $Res Function(_ReportPeriod) _then;

/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_ReportPeriod(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MoneyPulse {

 int get totalLoggedSpend; int get remainingBudget; int get confidenceScore;
/// Create a copy of MoneyPulse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoneyPulseCopyWith<MoneyPulse> get copyWith => _$MoneyPulseCopyWithImpl<MoneyPulse>(this as MoneyPulse, _$identity);

  /// Serializes this MoneyPulse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoneyPulse&&(identical(other.totalLoggedSpend, totalLoggedSpend) || other.totalLoggedSpend == totalLoggedSpend)&&(identical(other.remainingBudget, remainingBudget) || other.remainingBudget == remainingBudget)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalLoggedSpend,remainingBudget,confidenceScore);

@override
String toString() {
  return 'MoneyPulse(totalLoggedSpend: $totalLoggedSpend, remainingBudget: $remainingBudget, confidenceScore: $confidenceScore)';
}


}

/// @nodoc
abstract mixin class $MoneyPulseCopyWith<$Res>  {
  factory $MoneyPulseCopyWith(MoneyPulse value, $Res Function(MoneyPulse) _then) = _$MoneyPulseCopyWithImpl;
@useResult
$Res call({
 int totalLoggedSpend, int remainingBudget, int confidenceScore
});




}
/// @nodoc
class _$MoneyPulseCopyWithImpl<$Res>
    implements $MoneyPulseCopyWith<$Res> {
  _$MoneyPulseCopyWithImpl(this._self, this._then);

  final MoneyPulse _self;
  final $Res Function(MoneyPulse) _then;

/// Create a copy of MoneyPulse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalLoggedSpend = null,Object? remainingBudget = null,Object? confidenceScore = null,}) {
  return _then(_self.copyWith(
totalLoggedSpend: null == totalLoggedSpend ? _self.totalLoggedSpend : totalLoggedSpend // ignore: cast_nullable_to_non_nullable
as int,remainingBudget: null == remainingBudget ? _self.remainingBudget : remainingBudget // ignore: cast_nullable_to_non_nullable
as int,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MoneyPulse].
extension MoneyPulsePatterns on MoneyPulse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoneyPulse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoneyPulse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoneyPulse value)  $default,){
final _that = this;
switch (_that) {
case _MoneyPulse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoneyPulse value)?  $default,){
final _that = this;
switch (_that) {
case _MoneyPulse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalLoggedSpend,  int remainingBudget,  int confidenceScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoneyPulse() when $default != null:
return $default(_that.totalLoggedSpend,_that.remainingBudget,_that.confidenceScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalLoggedSpend,  int remainingBudget,  int confidenceScore)  $default,) {final _that = this;
switch (_that) {
case _MoneyPulse():
return $default(_that.totalLoggedSpend,_that.remainingBudget,_that.confidenceScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalLoggedSpend,  int remainingBudget,  int confidenceScore)?  $default,) {final _that = this;
switch (_that) {
case _MoneyPulse() when $default != null:
return $default(_that.totalLoggedSpend,_that.remainingBudget,_that.confidenceScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MoneyPulse implements MoneyPulse {
  const _MoneyPulse({required this.totalLoggedSpend, required this.remainingBudget, required this.confidenceScore});
  factory _MoneyPulse.fromJson(Map<String, dynamic> json) => _$MoneyPulseFromJson(json);

@override final  int totalLoggedSpend;
@override final  int remainingBudget;
@override final  int confidenceScore;

/// Create a copy of MoneyPulse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoneyPulseCopyWith<_MoneyPulse> get copyWith => __$MoneyPulseCopyWithImpl<_MoneyPulse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoneyPulseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoneyPulse&&(identical(other.totalLoggedSpend, totalLoggedSpend) || other.totalLoggedSpend == totalLoggedSpend)&&(identical(other.remainingBudget, remainingBudget) || other.remainingBudget == remainingBudget)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalLoggedSpend,remainingBudget,confidenceScore);

@override
String toString() {
  return 'MoneyPulse(totalLoggedSpend: $totalLoggedSpend, remainingBudget: $remainingBudget, confidenceScore: $confidenceScore)';
}


}

/// @nodoc
abstract mixin class _$MoneyPulseCopyWith<$Res> implements $MoneyPulseCopyWith<$Res> {
  factory _$MoneyPulseCopyWith(_MoneyPulse value, $Res Function(_MoneyPulse) _then) = __$MoneyPulseCopyWithImpl;
@override @useResult
$Res call({
 int totalLoggedSpend, int remainingBudget, int confidenceScore
});




}
/// @nodoc
class __$MoneyPulseCopyWithImpl<$Res>
    implements _$MoneyPulseCopyWith<$Res> {
  __$MoneyPulseCopyWithImpl(this._self, this._then);

  final _MoneyPulse _self;
  final $Res Function(_MoneyPulse) _then;

/// Create a copy of MoneyPulse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalLoggedSpend = null,Object? remainingBudget = null,Object? confidenceScore = null,}) {
  return _then(_MoneyPulse(
totalLoggedSpend: null == totalLoggedSpend ? _self.totalLoggedSpend : totalLoggedSpend // ignore: cast_nullable_to_non_nullable
as int,remainingBudget: null == remainingBudget ? _self.remainingBudget : remainingBudget // ignore: cast_nullable_to_non_nullable
as int,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TopMover {

 String get category; int get amount; int get changePercent;
/// Create a copy of TopMover
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopMoverCopyWith<TopMover> get copyWith => _$TopMoverCopyWithImpl<TopMover>(this as TopMover, _$identity);

  /// Serializes this TopMover to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopMover&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amount,changePercent);

@override
String toString() {
  return 'TopMover(category: $category, amount: $amount, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class $TopMoverCopyWith<$Res>  {
  factory $TopMoverCopyWith(TopMover value, $Res Function(TopMover) _then) = _$TopMoverCopyWithImpl;
@useResult
$Res call({
 String category, int amount, int changePercent
});




}
/// @nodoc
class _$TopMoverCopyWithImpl<$Res>
    implements $TopMoverCopyWith<$Res> {
  _$TopMoverCopyWithImpl(this._self, this._then);

  final TopMover _self;
  final $Res Function(TopMover) _then;

/// Create a copy of TopMover
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? amount = null,Object? changePercent = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TopMover].
extension TopMoverPatterns on TopMover {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopMover value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopMover() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopMover value)  $default,){
final _that = this;
switch (_that) {
case _TopMover():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopMover value)?  $default,){
final _that = this;
switch (_that) {
case _TopMover() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  int amount,  int changePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopMover() when $default != null:
return $default(_that.category,_that.amount,_that.changePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  int amount,  int changePercent)  $default,) {final _that = this;
switch (_that) {
case _TopMover():
return $default(_that.category,_that.amount,_that.changePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  int amount,  int changePercent)?  $default,) {final _that = this;
switch (_that) {
case _TopMover() when $default != null:
return $default(_that.category,_that.amount,_that.changePercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopMover implements TopMover {
  const _TopMover({required this.category, required this.amount, required this.changePercent});
  factory _TopMover.fromJson(Map<String, dynamic> json) => _$TopMoverFromJson(json);

@override final  String category;
@override final  int amount;
@override final  int changePercent;

/// Create a copy of TopMover
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopMoverCopyWith<_TopMover> get copyWith => __$TopMoverCopyWithImpl<_TopMover>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopMoverToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopMover&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amount,changePercent);

@override
String toString() {
  return 'TopMover(category: $category, amount: $amount, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class _$TopMoverCopyWith<$Res> implements $TopMoverCopyWith<$Res> {
  factory _$TopMoverCopyWith(_TopMover value, $Res Function(_TopMover) _then) = __$TopMoverCopyWithImpl;
@override @useResult
$Res call({
 String category, int amount, int changePercent
});




}
/// @nodoc
class __$TopMoverCopyWithImpl<$Res>
    implements _$TopMoverCopyWith<$Res> {
  __$TopMoverCopyWithImpl(this._self, this._then);

  final _TopMover _self;
  final $Res Function(_TopMover) _then;

/// Create a copy of TopMover
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? amount = null,Object? changePercent = null,}) {
  return _then(_TopMover(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BillAhead {

 String get name; String get dueDate; int get amountMinor; String get currency;
/// Create a copy of BillAhead
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillAheadCopyWith<BillAhead> get copyWith => _$BillAheadCopyWithImpl<BillAhead>(this as BillAhead, _$identity);

  /// Serializes this BillAhead to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillAhead&&(identical(other.name, name) || other.name == name)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,dueDate,amountMinor,currency);

@override
String toString() {
  return 'BillAhead(name: $name, dueDate: $dueDate, amountMinor: $amountMinor, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $BillAheadCopyWith<$Res>  {
  factory $BillAheadCopyWith(BillAhead value, $Res Function(BillAhead) _then) = _$BillAheadCopyWithImpl;
@useResult
$Res call({
 String name, String dueDate, int amountMinor, String currency
});




}
/// @nodoc
class _$BillAheadCopyWithImpl<$Res>
    implements $BillAheadCopyWith<$Res> {
  _$BillAheadCopyWithImpl(this._self, this._then);

  final BillAhead _self;
  final $Res Function(BillAhead) _then;

/// Create a copy of BillAhead
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? dueDate = null,Object? amountMinor = null,Object? currency = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BillAhead].
extension BillAheadPatterns on BillAhead {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillAhead value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillAhead() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillAhead value)  $default,){
final _that = this;
switch (_that) {
case _BillAhead():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillAhead value)?  $default,){
final _that = this;
switch (_that) {
case _BillAhead() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String dueDate,  int amountMinor,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillAhead() when $default != null:
return $default(_that.name,_that.dueDate,_that.amountMinor,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String dueDate,  int amountMinor,  String currency)  $default,) {final _that = this;
switch (_that) {
case _BillAhead():
return $default(_that.name,_that.dueDate,_that.amountMinor,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String dueDate,  int amountMinor,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _BillAhead() when $default != null:
return $default(_that.name,_that.dueDate,_that.amountMinor,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillAhead implements BillAhead {
  const _BillAhead({required this.name, required this.dueDate, required this.amountMinor, required this.currency});
  factory _BillAhead.fromJson(Map<String, dynamic> json) => _$BillAheadFromJson(json);

@override final  String name;
@override final  String dueDate;
@override final  int amountMinor;
@override final  String currency;

/// Create a copy of BillAhead
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillAheadCopyWith<_BillAhead> get copyWith => __$BillAheadCopyWithImpl<_BillAhead>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillAheadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillAhead&&(identical(other.name, name) || other.name == name)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,dueDate,amountMinor,currency);

@override
String toString() {
  return 'BillAhead(name: $name, dueDate: $dueDate, amountMinor: $amountMinor, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$BillAheadCopyWith<$Res> implements $BillAheadCopyWith<$Res> {
  factory _$BillAheadCopyWith(_BillAhead value, $Res Function(_BillAhead) _then) = __$BillAheadCopyWithImpl;
@override @useResult
$Res call({
 String name, String dueDate, int amountMinor, String currency
});




}
/// @nodoc
class __$BillAheadCopyWithImpl<$Res>
    implements _$BillAheadCopyWith<$Res> {
  __$BillAheadCopyWithImpl(this._self, this._then);

  final _BillAhead _self;
  final $Res Function(_BillAhead) _then;

/// Create a copy of BillAhead
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? dueDate = null,Object? amountMinor = null,Object? currency = null,}) {
  return _then(_BillAhead(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GoalAtRisk {

 String get name; int get progressPercent; int get projectedShortfall;
/// Create a copy of GoalAtRisk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalAtRiskCopyWith<GoalAtRisk> get copyWith => _$GoalAtRiskCopyWithImpl<GoalAtRisk>(this as GoalAtRisk, _$identity);

  /// Serializes this GoalAtRisk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalAtRisk&&(identical(other.name, name) || other.name == name)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.projectedShortfall, projectedShortfall) || other.projectedShortfall == projectedShortfall));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,progressPercent,projectedShortfall);

@override
String toString() {
  return 'GoalAtRisk(name: $name, progressPercent: $progressPercent, projectedShortfall: $projectedShortfall)';
}


}

/// @nodoc
abstract mixin class $GoalAtRiskCopyWith<$Res>  {
  factory $GoalAtRiskCopyWith(GoalAtRisk value, $Res Function(GoalAtRisk) _then) = _$GoalAtRiskCopyWithImpl;
@useResult
$Res call({
 String name, int progressPercent, int projectedShortfall
});




}
/// @nodoc
class _$GoalAtRiskCopyWithImpl<$Res>
    implements $GoalAtRiskCopyWith<$Res> {
  _$GoalAtRiskCopyWithImpl(this._self, this._then);

  final GoalAtRisk _self;
  final $Res Function(GoalAtRisk) _then;

/// Create a copy of GoalAtRisk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? progressPercent = null,Object? projectedShortfall = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,projectedShortfall: null == projectedShortfall ? _self.projectedShortfall : projectedShortfall // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalAtRisk].
extension GoalAtRiskPatterns on GoalAtRisk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalAtRisk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalAtRisk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalAtRisk value)  $default,){
final _that = this;
switch (_that) {
case _GoalAtRisk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalAtRisk value)?  $default,){
final _that = this;
switch (_that) {
case _GoalAtRisk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int progressPercent,  int projectedShortfall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalAtRisk() when $default != null:
return $default(_that.name,_that.progressPercent,_that.projectedShortfall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int progressPercent,  int projectedShortfall)  $default,) {final _that = this;
switch (_that) {
case _GoalAtRisk():
return $default(_that.name,_that.progressPercent,_that.projectedShortfall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int progressPercent,  int projectedShortfall)?  $default,) {final _that = this;
switch (_that) {
case _GoalAtRisk() when $default != null:
return $default(_that.name,_that.progressPercent,_that.projectedShortfall);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalAtRisk implements GoalAtRisk {
  const _GoalAtRisk({required this.name, required this.progressPercent, required this.projectedShortfall});
  factory _GoalAtRisk.fromJson(Map<String, dynamic> json) => _$GoalAtRiskFromJson(json);

@override final  String name;
@override final  int progressPercent;
@override final  int projectedShortfall;

/// Create a copy of GoalAtRisk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalAtRiskCopyWith<_GoalAtRisk> get copyWith => __$GoalAtRiskCopyWithImpl<_GoalAtRisk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalAtRiskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalAtRisk&&(identical(other.name, name) || other.name == name)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.projectedShortfall, projectedShortfall) || other.projectedShortfall == projectedShortfall));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,progressPercent,projectedShortfall);

@override
String toString() {
  return 'GoalAtRisk(name: $name, progressPercent: $progressPercent, projectedShortfall: $projectedShortfall)';
}


}

/// @nodoc
abstract mixin class _$GoalAtRiskCopyWith<$Res> implements $GoalAtRiskCopyWith<$Res> {
  factory _$GoalAtRiskCopyWith(_GoalAtRisk value, $Res Function(_GoalAtRisk) _then) = __$GoalAtRiskCopyWithImpl;
@override @useResult
$Res call({
 String name, int progressPercent, int projectedShortfall
});




}
/// @nodoc
class __$GoalAtRiskCopyWithImpl<$Res>
    implements _$GoalAtRiskCopyWith<$Res> {
  __$GoalAtRiskCopyWithImpl(this._self, this._then);

  final _GoalAtRisk _self;
  final $Res Function(_GoalAtRisk) _then;

/// Create a copy of GoalAtRisk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? progressPercent = null,Object? projectedShortfall = null,}) {
  return _then(_GoalAtRisk(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,projectedShortfall: null == projectedShortfall ? _self.projectedShortfall : projectedShortfall // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SharedObligation {

 String get splitName; int get pendingAmount; String get currency;
/// Create a copy of SharedObligation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedObligationCopyWith<SharedObligation> get copyWith => _$SharedObligationCopyWithImpl<SharedObligation>(this as SharedObligation, _$identity);

  /// Serializes this SharedObligation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedObligation&&(identical(other.splitName, splitName) || other.splitName == splitName)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,splitName,pendingAmount,currency);

@override
String toString() {
  return 'SharedObligation(splitName: $splitName, pendingAmount: $pendingAmount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $SharedObligationCopyWith<$Res>  {
  factory $SharedObligationCopyWith(SharedObligation value, $Res Function(SharedObligation) _then) = _$SharedObligationCopyWithImpl;
@useResult
$Res call({
 String splitName, int pendingAmount, String currency
});




}
/// @nodoc
class _$SharedObligationCopyWithImpl<$Res>
    implements $SharedObligationCopyWith<$Res> {
  _$SharedObligationCopyWithImpl(this._self, this._then);

  final SharedObligation _self;
  final $Res Function(SharedObligation) _then;

/// Create a copy of SharedObligation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? splitName = null,Object? pendingAmount = null,Object? currency = null,}) {
  return _then(_self.copyWith(
splitName: null == splitName ? _self.splitName : splitName // ignore: cast_nullable_to_non_nullable
as String,pendingAmount: null == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedObligation].
extension SharedObligationPatterns on SharedObligation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedObligation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedObligation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedObligation value)  $default,){
final _that = this;
switch (_that) {
case _SharedObligation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedObligation value)?  $default,){
final _that = this;
switch (_that) {
case _SharedObligation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String splitName,  int pendingAmount,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedObligation() when $default != null:
return $default(_that.splitName,_that.pendingAmount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String splitName,  int pendingAmount,  String currency)  $default,) {final _that = this;
switch (_that) {
case _SharedObligation():
return $default(_that.splitName,_that.pendingAmount,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String splitName,  int pendingAmount,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _SharedObligation() when $default != null:
return $default(_that.splitName,_that.pendingAmount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedObligation implements SharedObligation {
  const _SharedObligation({required this.splitName, required this.pendingAmount, required this.currency});
  factory _SharedObligation.fromJson(Map<String, dynamic> json) => _$SharedObligationFromJson(json);

@override final  String splitName;
@override final  int pendingAmount;
@override final  String currency;

/// Create a copy of SharedObligation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedObligationCopyWith<_SharedObligation> get copyWith => __$SharedObligationCopyWithImpl<_SharedObligation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedObligationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedObligation&&(identical(other.splitName, splitName) || other.splitName == splitName)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,splitName,pendingAmount,currency);

@override
String toString() {
  return 'SharedObligation(splitName: $splitName, pendingAmount: $pendingAmount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$SharedObligationCopyWith<$Res> implements $SharedObligationCopyWith<$Res> {
  factory _$SharedObligationCopyWith(_SharedObligation value, $Res Function(_SharedObligation) _then) = __$SharedObligationCopyWithImpl;
@override @useResult
$Res call({
 String splitName, int pendingAmount, String currency
});




}
/// @nodoc
class __$SharedObligationCopyWithImpl<$Res>
    implements _$SharedObligationCopyWith<$Res> {
  __$SharedObligationCopyWithImpl(this._self, this._then);

  final _SharedObligation _self;
  final $Res Function(_SharedObligation) _then;

/// Create a copy of SharedObligation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? splitName = null,Object? pendingAmount = null,Object? currency = null,}) {
  return _then(_SharedObligation(
splitName: null == splitName ? _self.splitName : splitName // ignore: cast_nullable_to_non_nullable
as String,pendingAmount: null == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MonthlyReport {

 int get year; int get month; IncomeSummary get incomeSummary; ExpenseSummary get expenseSummary; List<BudgetPerformance> get budgetPerformance; List<GoalProgressReport> get goalProgress; BillReliability get billReliability; SharedLedger get sharedLedger; List<ValidationChecklistItem> get validationChecklist;
/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyReportCopyWith<MonthlyReport> get copyWith => _$MonthlyReportCopyWithImpl<MonthlyReport>(this as MonthlyReport, _$identity);

  /// Serializes this MonthlyReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyReport&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.incomeSummary, incomeSummary) || other.incomeSummary == incomeSummary)&&(identical(other.expenseSummary, expenseSummary) || other.expenseSummary == expenseSummary)&&const DeepCollectionEquality().equals(other.budgetPerformance, budgetPerformance)&&const DeepCollectionEquality().equals(other.goalProgress, goalProgress)&&(identical(other.billReliability, billReliability) || other.billReliability == billReliability)&&(identical(other.sharedLedger, sharedLedger) || other.sharedLedger == sharedLedger)&&const DeepCollectionEquality().equals(other.validationChecklist, validationChecklist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,month,incomeSummary,expenseSummary,const DeepCollectionEquality().hash(budgetPerformance),const DeepCollectionEquality().hash(goalProgress),billReliability,sharedLedger,const DeepCollectionEquality().hash(validationChecklist));

@override
String toString() {
  return 'MonthlyReport(year: $year, month: $month, incomeSummary: $incomeSummary, expenseSummary: $expenseSummary, budgetPerformance: $budgetPerformance, goalProgress: $goalProgress, billReliability: $billReliability, sharedLedger: $sharedLedger, validationChecklist: $validationChecklist)';
}


}

/// @nodoc
abstract mixin class $MonthlyReportCopyWith<$Res>  {
  factory $MonthlyReportCopyWith(MonthlyReport value, $Res Function(MonthlyReport) _then) = _$MonthlyReportCopyWithImpl;
@useResult
$Res call({
 int year, int month, IncomeSummary incomeSummary, ExpenseSummary expenseSummary, List<BudgetPerformance> budgetPerformance, List<GoalProgressReport> goalProgress, BillReliability billReliability, SharedLedger sharedLedger, List<ValidationChecklistItem> validationChecklist
});


$IncomeSummaryCopyWith<$Res> get incomeSummary;$ExpenseSummaryCopyWith<$Res> get expenseSummary;$BillReliabilityCopyWith<$Res> get billReliability;$SharedLedgerCopyWith<$Res> get sharedLedger;

}
/// @nodoc
class _$MonthlyReportCopyWithImpl<$Res>
    implements $MonthlyReportCopyWith<$Res> {
  _$MonthlyReportCopyWithImpl(this._self, this._then);

  final MonthlyReport _self;
  final $Res Function(MonthlyReport) _then;

/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? incomeSummary = null,Object? expenseSummary = null,Object? budgetPerformance = null,Object? goalProgress = null,Object? billReliability = null,Object? sharedLedger = null,Object? validationChecklist = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,incomeSummary: null == incomeSummary ? _self.incomeSummary : incomeSummary // ignore: cast_nullable_to_non_nullable
as IncomeSummary,expenseSummary: null == expenseSummary ? _self.expenseSummary : expenseSummary // ignore: cast_nullable_to_non_nullable
as ExpenseSummary,budgetPerformance: null == budgetPerformance ? _self.budgetPerformance : budgetPerformance // ignore: cast_nullable_to_non_nullable
as List<BudgetPerformance>,goalProgress: null == goalProgress ? _self.goalProgress : goalProgress // ignore: cast_nullable_to_non_nullable
as List<GoalProgressReport>,billReliability: null == billReliability ? _self.billReliability : billReliability // ignore: cast_nullable_to_non_nullable
as BillReliability,sharedLedger: null == sharedLedger ? _self.sharedLedger : sharedLedger // ignore: cast_nullable_to_non_nullable
as SharedLedger,validationChecklist: null == validationChecklist ? _self.validationChecklist : validationChecklist // ignore: cast_nullable_to_non_nullable
as List<ValidationChecklistItem>,
  ));
}
/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomeSummaryCopyWith<$Res> get incomeSummary {
  
  return $IncomeSummaryCopyWith<$Res>(_self.incomeSummary, (value) {
    return _then(_self.copyWith(incomeSummary: value));
  });
}/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseSummaryCopyWith<$Res> get expenseSummary {
  
  return $ExpenseSummaryCopyWith<$Res>(_self.expenseSummary, (value) {
    return _then(_self.copyWith(expenseSummary: value));
  });
}/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillReliabilityCopyWith<$Res> get billReliability {
  
  return $BillReliabilityCopyWith<$Res>(_self.billReliability, (value) {
    return _then(_self.copyWith(billReliability: value));
  });
}/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SharedLedgerCopyWith<$Res> get sharedLedger {
  
  return $SharedLedgerCopyWith<$Res>(_self.sharedLedger, (value) {
    return _then(_self.copyWith(sharedLedger: value));
  });
}
}


/// Adds pattern-matching-related methods to [MonthlyReport].
extension MonthlyReportPatterns on MonthlyReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyReport value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyReport value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  IncomeSummary incomeSummary,  ExpenseSummary expenseSummary,  List<BudgetPerformance> budgetPerformance,  List<GoalProgressReport> goalProgress,  BillReliability billReliability,  SharedLedger sharedLedger,  List<ValidationChecklistItem> validationChecklist)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
return $default(_that.year,_that.month,_that.incomeSummary,_that.expenseSummary,_that.budgetPerformance,_that.goalProgress,_that.billReliability,_that.sharedLedger,_that.validationChecklist);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  IncomeSummary incomeSummary,  ExpenseSummary expenseSummary,  List<BudgetPerformance> budgetPerformance,  List<GoalProgressReport> goalProgress,  BillReliability billReliability,  SharedLedger sharedLedger,  List<ValidationChecklistItem> validationChecklist)  $default,) {final _that = this;
switch (_that) {
case _MonthlyReport():
return $default(_that.year,_that.month,_that.incomeSummary,_that.expenseSummary,_that.budgetPerformance,_that.goalProgress,_that.billReliability,_that.sharedLedger,_that.validationChecklist);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  IncomeSummary incomeSummary,  ExpenseSummary expenseSummary,  List<BudgetPerformance> budgetPerformance,  List<GoalProgressReport> goalProgress,  BillReliability billReliability,  SharedLedger sharedLedger,  List<ValidationChecklistItem> validationChecklist)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
return $default(_that.year,_that.month,_that.incomeSummary,_that.expenseSummary,_that.budgetPerformance,_that.goalProgress,_that.billReliability,_that.sharedLedger,_that.validationChecklist);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyReport implements MonthlyReport {
  const _MonthlyReport({required this.year, required this.month, required this.incomeSummary, required this.expenseSummary, required final  List<BudgetPerformance> budgetPerformance, required final  List<GoalProgressReport> goalProgress, required this.billReliability, required this.sharedLedger, required final  List<ValidationChecklistItem> validationChecklist}): _budgetPerformance = budgetPerformance,_goalProgress = goalProgress,_validationChecklist = validationChecklist;
  factory _MonthlyReport.fromJson(Map<String, dynamic> json) => _$MonthlyReportFromJson(json);

@override final  int year;
@override final  int month;
@override final  IncomeSummary incomeSummary;
@override final  ExpenseSummary expenseSummary;
 final  List<BudgetPerformance> _budgetPerformance;
@override List<BudgetPerformance> get budgetPerformance {
  if (_budgetPerformance is EqualUnmodifiableListView) return _budgetPerformance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_budgetPerformance);
}

 final  List<GoalProgressReport> _goalProgress;
@override List<GoalProgressReport> get goalProgress {
  if (_goalProgress is EqualUnmodifiableListView) return _goalProgress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goalProgress);
}

@override final  BillReliability billReliability;
@override final  SharedLedger sharedLedger;
 final  List<ValidationChecklistItem> _validationChecklist;
@override List<ValidationChecklistItem> get validationChecklist {
  if (_validationChecklist is EqualUnmodifiableListView) return _validationChecklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_validationChecklist);
}


/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyReportCopyWith<_MonthlyReport> get copyWith => __$MonthlyReportCopyWithImpl<_MonthlyReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyReport&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.incomeSummary, incomeSummary) || other.incomeSummary == incomeSummary)&&(identical(other.expenseSummary, expenseSummary) || other.expenseSummary == expenseSummary)&&const DeepCollectionEquality().equals(other._budgetPerformance, _budgetPerformance)&&const DeepCollectionEquality().equals(other._goalProgress, _goalProgress)&&(identical(other.billReliability, billReliability) || other.billReliability == billReliability)&&(identical(other.sharedLedger, sharedLedger) || other.sharedLedger == sharedLedger)&&const DeepCollectionEquality().equals(other._validationChecklist, _validationChecklist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,month,incomeSummary,expenseSummary,const DeepCollectionEquality().hash(_budgetPerformance),const DeepCollectionEquality().hash(_goalProgress),billReliability,sharedLedger,const DeepCollectionEquality().hash(_validationChecklist));

@override
String toString() {
  return 'MonthlyReport(year: $year, month: $month, incomeSummary: $incomeSummary, expenseSummary: $expenseSummary, budgetPerformance: $budgetPerformance, goalProgress: $goalProgress, billReliability: $billReliability, sharedLedger: $sharedLedger, validationChecklist: $validationChecklist)';
}


}

/// @nodoc
abstract mixin class _$MonthlyReportCopyWith<$Res> implements $MonthlyReportCopyWith<$Res> {
  factory _$MonthlyReportCopyWith(_MonthlyReport value, $Res Function(_MonthlyReport) _then) = __$MonthlyReportCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, IncomeSummary incomeSummary, ExpenseSummary expenseSummary, List<BudgetPerformance> budgetPerformance, List<GoalProgressReport> goalProgress, BillReliability billReliability, SharedLedger sharedLedger, List<ValidationChecklistItem> validationChecklist
});


@override $IncomeSummaryCopyWith<$Res> get incomeSummary;@override $ExpenseSummaryCopyWith<$Res> get expenseSummary;@override $BillReliabilityCopyWith<$Res> get billReliability;@override $SharedLedgerCopyWith<$Res> get sharedLedger;

}
/// @nodoc
class __$MonthlyReportCopyWithImpl<$Res>
    implements _$MonthlyReportCopyWith<$Res> {
  __$MonthlyReportCopyWithImpl(this._self, this._then);

  final _MonthlyReport _self;
  final $Res Function(_MonthlyReport) _then;

/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? incomeSummary = null,Object? expenseSummary = null,Object? budgetPerformance = null,Object? goalProgress = null,Object? billReliability = null,Object? sharedLedger = null,Object? validationChecklist = null,}) {
  return _then(_MonthlyReport(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,incomeSummary: null == incomeSummary ? _self.incomeSummary : incomeSummary // ignore: cast_nullable_to_non_nullable
as IncomeSummary,expenseSummary: null == expenseSummary ? _self.expenseSummary : expenseSummary // ignore: cast_nullable_to_non_nullable
as ExpenseSummary,budgetPerformance: null == budgetPerformance ? _self._budgetPerformance : budgetPerformance // ignore: cast_nullable_to_non_nullable
as List<BudgetPerformance>,goalProgress: null == goalProgress ? _self._goalProgress : goalProgress // ignore: cast_nullable_to_non_nullable
as List<GoalProgressReport>,billReliability: null == billReliability ? _self.billReliability : billReliability // ignore: cast_nullable_to_non_nullable
as BillReliability,sharedLedger: null == sharedLedger ? _self.sharedLedger : sharedLedger // ignore: cast_nullable_to_non_nullable
as SharedLedger,validationChecklist: null == validationChecklist ? _self._validationChecklist : validationChecklist // ignore: cast_nullable_to_non_nullable
as List<ValidationChecklistItem>,
  ));
}

/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomeSummaryCopyWith<$Res> get incomeSummary {
  
  return $IncomeSummaryCopyWith<$Res>(_self.incomeSummary, (value) {
    return _then(_self.copyWith(incomeSummary: value));
  });
}/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseSummaryCopyWith<$Res> get expenseSummary {
  
  return $ExpenseSummaryCopyWith<$Res>(_self.expenseSummary, (value) {
    return _then(_self.copyWith(expenseSummary: value));
  });
}/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillReliabilityCopyWith<$Res> get billReliability {
  
  return $BillReliabilityCopyWith<$Res>(_self.billReliability, (value) {
    return _then(_self.copyWith(billReliability: value));
  });
}/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SharedLedgerCopyWith<$Res> get sharedLedger {
  
  return $SharedLedgerCopyWith<$Res>(_self.sharedLedger, (value) {
    return _then(_self.copyWith(sharedLedger: value));
  });
}
}


/// @nodoc
mixin _$IncomeSummary {

 int get totalIncomeMinor; List<IncomeSource> get sources;
/// Create a copy of IncomeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeSummaryCopyWith<IncomeSummary> get copyWith => _$IncomeSummaryCopyWithImpl<IncomeSummary>(this as IncomeSummary, _$identity);

  /// Serializes this IncomeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeSummary&&(identical(other.totalIncomeMinor, totalIncomeMinor) || other.totalIncomeMinor == totalIncomeMinor)&&const DeepCollectionEquality().equals(other.sources, sources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalIncomeMinor,const DeepCollectionEquality().hash(sources));

@override
String toString() {
  return 'IncomeSummary(totalIncomeMinor: $totalIncomeMinor, sources: $sources)';
}


}

/// @nodoc
abstract mixin class $IncomeSummaryCopyWith<$Res>  {
  factory $IncomeSummaryCopyWith(IncomeSummary value, $Res Function(IncomeSummary) _then) = _$IncomeSummaryCopyWithImpl;
@useResult
$Res call({
 int totalIncomeMinor, List<IncomeSource> sources
});




}
/// @nodoc
class _$IncomeSummaryCopyWithImpl<$Res>
    implements $IncomeSummaryCopyWith<$Res> {
  _$IncomeSummaryCopyWithImpl(this._self, this._then);

  final IncomeSummary _self;
  final $Res Function(IncomeSummary) _then;

/// Create a copy of IncomeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalIncomeMinor = null,Object? sources = null,}) {
  return _then(_self.copyWith(
totalIncomeMinor: null == totalIncomeMinor ? _self.totalIncomeMinor : totalIncomeMinor // ignore: cast_nullable_to_non_nullable
as int,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<IncomeSource>,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeSummary].
extension IncomeSummaryPatterns on IncomeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeSummary value)  $default,){
final _that = this;
switch (_that) {
case _IncomeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalIncomeMinor,  List<IncomeSource> sources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeSummary() when $default != null:
return $default(_that.totalIncomeMinor,_that.sources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalIncomeMinor,  List<IncomeSource> sources)  $default,) {final _that = this;
switch (_that) {
case _IncomeSummary():
return $default(_that.totalIncomeMinor,_that.sources);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalIncomeMinor,  List<IncomeSource> sources)?  $default,) {final _that = this;
switch (_that) {
case _IncomeSummary() when $default != null:
return $default(_that.totalIncomeMinor,_that.sources);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncomeSummary implements IncomeSummary {
  const _IncomeSummary({required this.totalIncomeMinor, required final  List<IncomeSource> sources}): _sources = sources;
  factory _IncomeSummary.fromJson(Map<String, dynamic> json) => _$IncomeSummaryFromJson(json);

@override final  int totalIncomeMinor;
 final  List<IncomeSource> _sources;
@override List<IncomeSource> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}


/// Create a copy of IncomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeSummaryCopyWith<_IncomeSummary> get copyWith => __$IncomeSummaryCopyWithImpl<_IncomeSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncomeSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeSummary&&(identical(other.totalIncomeMinor, totalIncomeMinor) || other.totalIncomeMinor == totalIncomeMinor)&&const DeepCollectionEquality().equals(other._sources, _sources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalIncomeMinor,const DeepCollectionEquality().hash(_sources));

@override
String toString() {
  return 'IncomeSummary(totalIncomeMinor: $totalIncomeMinor, sources: $sources)';
}


}

/// @nodoc
abstract mixin class _$IncomeSummaryCopyWith<$Res> implements $IncomeSummaryCopyWith<$Res> {
  factory _$IncomeSummaryCopyWith(_IncomeSummary value, $Res Function(_IncomeSummary) _then) = __$IncomeSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalIncomeMinor, List<IncomeSource> sources
});




}
/// @nodoc
class __$IncomeSummaryCopyWithImpl<$Res>
    implements _$IncomeSummaryCopyWith<$Res> {
  __$IncomeSummaryCopyWithImpl(this._self, this._then);

  final _IncomeSummary _self;
  final $Res Function(_IncomeSummary) _then;

/// Create a copy of IncomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalIncomeMinor = null,Object? sources = null,}) {
  return _then(_IncomeSummary(
totalIncomeMinor: null == totalIncomeMinor ? _self.totalIncomeMinor : totalIncomeMinor // ignore: cast_nullable_to_non_nullable
as int,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<IncomeSource>,
  ));
}


}


/// @nodoc
mixin _$IncomeSource {

 String get category; int get amountMinor;
/// Create a copy of IncomeSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeSourceCopyWith<IncomeSource> get copyWith => _$IncomeSourceCopyWithImpl<IncomeSource>(this as IncomeSource, _$identity);

  /// Serializes this IncomeSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeSource&&(identical(other.category, category) || other.category == category)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amountMinor);

@override
String toString() {
  return 'IncomeSource(category: $category, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class $IncomeSourceCopyWith<$Res>  {
  factory $IncomeSourceCopyWith(IncomeSource value, $Res Function(IncomeSource) _then) = _$IncomeSourceCopyWithImpl;
@useResult
$Res call({
 String category, int amountMinor
});




}
/// @nodoc
class _$IncomeSourceCopyWithImpl<$Res>
    implements $IncomeSourceCopyWith<$Res> {
  _$IncomeSourceCopyWithImpl(this._self, this._then);

  final IncomeSource _self;
  final $Res Function(IncomeSource) _then;

/// Create a copy of IncomeSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? amountMinor = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeSource].
extension IncomeSourcePatterns on IncomeSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeSource value)  $default,){
final _that = this;
switch (_that) {
case _IncomeSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeSource value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  int amountMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeSource() when $default != null:
return $default(_that.category,_that.amountMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  int amountMinor)  $default,) {final _that = this;
switch (_that) {
case _IncomeSource():
return $default(_that.category,_that.amountMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  int amountMinor)?  $default,) {final _that = this;
switch (_that) {
case _IncomeSource() when $default != null:
return $default(_that.category,_that.amountMinor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncomeSource implements IncomeSource {
  const _IncomeSource({required this.category, required this.amountMinor});
  factory _IncomeSource.fromJson(Map<String, dynamic> json) => _$IncomeSourceFromJson(json);

@override final  String category;
@override final  int amountMinor;

/// Create a copy of IncomeSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeSourceCopyWith<_IncomeSource> get copyWith => __$IncomeSourceCopyWithImpl<_IncomeSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncomeSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeSource&&(identical(other.category, category) || other.category == category)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amountMinor);

@override
String toString() {
  return 'IncomeSource(category: $category, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class _$IncomeSourceCopyWith<$Res> implements $IncomeSourceCopyWith<$Res> {
  factory _$IncomeSourceCopyWith(_IncomeSource value, $Res Function(_IncomeSource) _then) = __$IncomeSourceCopyWithImpl;
@override @useResult
$Res call({
 String category, int amountMinor
});




}
/// @nodoc
class __$IncomeSourceCopyWithImpl<$Res>
    implements _$IncomeSourceCopyWith<$Res> {
  __$IncomeSourceCopyWithImpl(this._self, this._then);

  final _IncomeSource _self;
  final $Res Function(_IncomeSource) _then;

/// Create a copy of IncomeSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? amountMinor = null,}) {
  return _then(_IncomeSource(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExpenseSummary {

 int get totalExpenseMinor; List<ExpenseCategory> get byCategory;
/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSummaryCopyWith<ExpenseSummary> get copyWith => _$ExpenseSummaryCopyWithImpl<ExpenseSummary>(this as ExpenseSummary, _$identity);

  /// Serializes this ExpenseSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummary&&(identical(other.totalExpenseMinor, totalExpenseMinor) || other.totalExpenseMinor == totalExpenseMinor)&&const DeepCollectionEquality().equals(other.byCategory, byCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalExpenseMinor,const DeepCollectionEquality().hash(byCategory));

@override
String toString() {
  return 'ExpenseSummary(totalExpenseMinor: $totalExpenseMinor, byCategory: $byCategory)';
}


}

/// @nodoc
abstract mixin class $ExpenseSummaryCopyWith<$Res>  {
  factory $ExpenseSummaryCopyWith(ExpenseSummary value, $Res Function(ExpenseSummary) _then) = _$ExpenseSummaryCopyWithImpl;
@useResult
$Res call({
 int totalExpenseMinor, List<ExpenseCategory> byCategory
});




}
/// @nodoc
class _$ExpenseSummaryCopyWithImpl<$Res>
    implements $ExpenseSummaryCopyWith<$Res> {
  _$ExpenseSummaryCopyWithImpl(this._self, this._then);

  final ExpenseSummary _self;
  final $Res Function(ExpenseSummary) _then;

/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalExpenseMinor = null,Object? byCategory = null,}) {
  return _then(_self.copyWith(
totalExpenseMinor: null == totalExpenseMinor ? _self.totalExpenseMinor : totalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseSummary].
extension ExpenseSummaryPatterns on ExpenseSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseSummary value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalExpenseMinor,  List<ExpenseCategory> byCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
return $default(_that.totalExpenseMinor,_that.byCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalExpenseMinor,  List<ExpenseCategory> byCategory)  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummary():
return $default(_that.totalExpenseMinor,_that.byCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalExpenseMinor,  List<ExpenseCategory> byCategory)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
return $default(_that.totalExpenseMinor,_that.byCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseSummary implements ExpenseSummary {
  const _ExpenseSummary({required this.totalExpenseMinor, required final  List<ExpenseCategory> byCategory}): _byCategory = byCategory;
  factory _ExpenseSummary.fromJson(Map<String, dynamic> json) => _$ExpenseSummaryFromJson(json);

@override final  int totalExpenseMinor;
 final  List<ExpenseCategory> _byCategory;
@override List<ExpenseCategory> get byCategory {
  if (_byCategory is EqualUnmodifiableListView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byCategory);
}


/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseSummaryCopyWith<_ExpenseSummary> get copyWith => __$ExpenseSummaryCopyWithImpl<_ExpenseSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseSummary&&(identical(other.totalExpenseMinor, totalExpenseMinor) || other.totalExpenseMinor == totalExpenseMinor)&&const DeepCollectionEquality().equals(other._byCategory, _byCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalExpenseMinor,const DeepCollectionEquality().hash(_byCategory));

@override
String toString() {
  return 'ExpenseSummary(totalExpenseMinor: $totalExpenseMinor, byCategory: $byCategory)';
}


}

/// @nodoc
abstract mixin class _$ExpenseSummaryCopyWith<$Res> implements $ExpenseSummaryCopyWith<$Res> {
  factory _$ExpenseSummaryCopyWith(_ExpenseSummary value, $Res Function(_ExpenseSummary) _then) = __$ExpenseSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalExpenseMinor, List<ExpenseCategory> byCategory
});




}
/// @nodoc
class __$ExpenseSummaryCopyWithImpl<$Res>
    implements _$ExpenseSummaryCopyWith<$Res> {
  __$ExpenseSummaryCopyWithImpl(this._self, this._then);

  final _ExpenseSummary _self;
  final $Res Function(_ExpenseSummary) _then;

/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalExpenseMinor = null,Object? byCategory = null,}) {
  return _then(_ExpenseSummary(
totalExpenseMinor: null == totalExpenseMinor ? _self.totalExpenseMinor : totalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategory>,
  ));
}


}


/// @nodoc
mixin _$ExpenseCategory {

 String get category; int get amountMinor;
/// Create a copy of ExpenseCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCategoryCopyWith<ExpenseCategory> get copyWith => _$ExpenseCategoryCopyWithImpl<ExpenseCategory>(this as ExpenseCategory, _$identity);

  /// Serializes this ExpenseCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseCategory&&(identical(other.category, category) || other.category == category)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amountMinor);

@override
String toString() {
  return 'ExpenseCategory(category: $category, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class $ExpenseCategoryCopyWith<$Res>  {
  factory $ExpenseCategoryCopyWith(ExpenseCategory value, $Res Function(ExpenseCategory) _then) = _$ExpenseCategoryCopyWithImpl;
@useResult
$Res call({
 String category, int amountMinor
});




}
/// @nodoc
class _$ExpenseCategoryCopyWithImpl<$Res>
    implements $ExpenseCategoryCopyWith<$Res> {
  _$ExpenseCategoryCopyWithImpl(this._self, this._then);

  final ExpenseCategory _self;
  final $Res Function(ExpenseCategory) _then;

/// Create a copy of ExpenseCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? amountMinor = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseCategory].
extension ExpenseCategoryPatterns on ExpenseCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseCategory value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseCategory value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  int amountMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseCategory() when $default != null:
return $default(_that.category,_that.amountMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  int amountMinor)  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategory():
return $default(_that.category,_that.amountMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  int amountMinor)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategory() when $default != null:
return $default(_that.category,_that.amountMinor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseCategory implements ExpenseCategory {
  const _ExpenseCategory({required this.category, required this.amountMinor});
  factory _ExpenseCategory.fromJson(Map<String, dynamic> json) => _$ExpenseCategoryFromJson(json);

@override final  String category;
@override final  int amountMinor;

/// Create a copy of ExpenseCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCategoryCopyWith<_ExpenseCategory> get copyWith => __$ExpenseCategoryCopyWithImpl<_ExpenseCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseCategory&&(identical(other.category, category) || other.category == category)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amountMinor);

@override
String toString() {
  return 'ExpenseCategory(category: $category, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCategoryCopyWith<$Res> implements $ExpenseCategoryCopyWith<$Res> {
  factory _$ExpenseCategoryCopyWith(_ExpenseCategory value, $Res Function(_ExpenseCategory) _then) = __$ExpenseCategoryCopyWithImpl;
@override @useResult
$Res call({
 String category, int amountMinor
});




}
/// @nodoc
class __$ExpenseCategoryCopyWithImpl<$Res>
    implements _$ExpenseCategoryCopyWith<$Res> {
  __$ExpenseCategoryCopyWithImpl(this._self, this._then);

  final _ExpenseCategory _self;
  final $Res Function(_ExpenseCategory) _then;

/// Create a copy of ExpenseCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? amountMinor = null,}) {
  return _then(_ExpenseCategory(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BudgetPerformance {

 String get category; int get plannedMinor; int get actualMinor; int get adherencePercent;
/// Create a copy of BudgetPerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetPerformanceCopyWith<BudgetPerformance> get copyWith => _$BudgetPerformanceCopyWithImpl<BudgetPerformance>(this as BudgetPerformance, _$identity);

  /// Serializes this BudgetPerformance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetPerformance&&(identical(other.category, category) || other.category == category)&&(identical(other.plannedMinor, plannedMinor) || other.plannedMinor == plannedMinor)&&(identical(other.actualMinor, actualMinor) || other.actualMinor == actualMinor)&&(identical(other.adherencePercent, adherencePercent) || other.adherencePercent == adherencePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,plannedMinor,actualMinor,adherencePercent);

@override
String toString() {
  return 'BudgetPerformance(category: $category, plannedMinor: $plannedMinor, actualMinor: $actualMinor, adherencePercent: $adherencePercent)';
}


}

/// @nodoc
abstract mixin class $BudgetPerformanceCopyWith<$Res>  {
  factory $BudgetPerformanceCopyWith(BudgetPerformance value, $Res Function(BudgetPerformance) _then) = _$BudgetPerformanceCopyWithImpl;
@useResult
$Res call({
 String category, int plannedMinor, int actualMinor, int adherencePercent
});




}
/// @nodoc
class _$BudgetPerformanceCopyWithImpl<$Res>
    implements $BudgetPerformanceCopyWith<$Res> {
  _$BudgetPerformanceCopyWithImpl(this._self, this._then);

  final BudgetPerformance _self;
  final $Res Function(BudgetPerformance) _then;

/// Create a copy of BudgetPerformance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? plannedMinor = null,Object? actualMinor = null,Object? adherencePercent = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,plannedMinor: null == plannedMinor ? _self.plannedMinor : plannedMinor // ignore: cast_nullable_to_non_nullable
as int,actualMinor: null == actualMinor ? _self.actualMinor : actualMinor // ignore: cast_nullable_to_non_nullable
as int,adherencePercent: null == adherencePercent ? _self.adherencePercent : adherencePercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetPerformance].
extension BudgetPerformancePatterns on BudgetPerformance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetPerformance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetPerformance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetPerformance value)  $default,){
final _that = this;
switch (_that) {
case _BudgetPerformance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetPerformance value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetPerformance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  int plannedMinor,  int actualMinor,  int adherencePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetPerformance() when $default != null:
return $default(_that.category,_that.plannedMinor,_that.actualMinor,_that.adherencePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  int plannedMinor,  int actualMinor,  int adherencePercent)  $default,) {final _that = this;
switch (_that) {
case _BudgetPerformance():
return $default(_that.category,_that.plannedMinor,_that.actualMinor,_that.adherencePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  int plannedMinor,  int actualMinor,  int adherencePercent)?  $default,) {final _that = this;
switch (_that) {
case _BudgetPerformance() when $default != null:
return $default(_that.category,_that.plannedMinor,_that.actualMinor,_that.adherencePercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetPerformance implements BudgetPerformance {
  const _BudgetPerformance({required this.category, required this.plannedMinor, required this.actualMinor, required this.adherencePercent});
  factory _BudgetPerformance.fromJson(Map<String, dynamic> json) => _$BudgetPerformanceFromJson(json);

@override final  String category;
@override final  int plannedMinor;
@override final  int actualMinor;
@override final  int adherencePercent;

/// Create a copy of BudgetPerformance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetPerformanceCopyWith<_BudgetPerformance> get copyWith => __$BudgetPerformanceCopyWithImpl<_BudgetPerformance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetPerformanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetPerformance&&(identical(other.category, category) || other.category == category)&&(identical(other.plannedMinor, plannedMinor) || other.plannedMinor == plannedMinor)&&(identical(other.actualMinor, actualMinor) || other.actualMinor == actualMinor)&&(identical(other.adherencePercent, adherencePercent) || other.adherencePercent == adherencePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,plannedMinor,actualMinor,adherencePercent);

@override
String toString() {
  return 'BudgetPerformance(category: $category, plannedMinor: $plannedMinor, actualMinor: $actualMinor, adherencePercent: $adherencePercent)';
}


}

/// @nodoc
abstract mixin class _$BudgetPerformanceCopyWith<$Res> implements $BudgetPerformanceCopyWith<$Res> {
  factory _$BudgetPerformanceCopyWith(_BudgetPerformance value, $Res Function(_BudgetPerformance) _then) = __$BudgetPerformanceCopyWithImpl;
@override @useResult
$Res call({
 String category, int plannedMinor, int actualMinor, int adherencePercent
});




}
/// @nodoc
class __$BudgetPerformanceCopyWithImpl<$Res>
    implements _$BudgetPerformanceCopyWith<$Res> {
  __$BudgetPerformanceCopyWithImpl(this._self, this._then);

  final _BudgetPerformance _self;
  final $Res Function(_BudgetPerformance) _then;

/// Create a copy of BudgetPerformance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? plannedMinor = null,Object? actualMinor = null,Object? adherencePercent = null,}) {
  return _then(_BudgetPerformance(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,plannedMinor: null == plannedMinor ? _self.plannedMinor : plannedMinor // ignore: cast_nullable_to_non_nullable
as int,actualMinor: null == actualMinor ? _self.actualMinor : actualMinor // ignore: cast_nullable_to_non_nullable
as int,adherencePercent: null == adherencePercent ? _self.adherencePercent : adherencePercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GoalProgressReport {

 String get name; int get targetMinor; int get savedMinor; String get status;
/// Create a copy of GoalProgressReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalProgressReportCopyWith<GoalProgressReport> get copyWith => _$GoalProgressReportCopyWithImpl<GoalProgressReport>(this as GoalProgressReport, _$identity);

  /// Serializes this GoalProgressReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalProgressReport&&(identical(other.name, name) || other.name == name)&&(identical(other.targetMinor, targetMinor) || other.targetMinor == targetMinor)&&(identical(other.savedMinor, savedMinor) || other.savedMinor == savedMinor)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,targetMinor,savedMinor,status);

@override
String toString() {
  return 'GoalProgressReport(name: $name, targetMinor: $targetMinor, savedMinor: $savedMinor, status: $status)';
}


}

/// @nodoc
abstract mixin class $GoalProgressReportCopyWith<$Res>  {
  factory $GoalProgressReportCopyWith(GoalProgressReport value, $Res Function(GoalProgressReport) _then) = _$GoalProgressReportCopyWithImpl;
@useResult
$Res call({
 String name, int targetMinor, int savedMinor, String status
});




}
/// @nodoc
class _$GoalProgressReportCopyWithImpl<$Res>
    implements $GoalProgressReportCopyWith<$Res> {
  _$GoalProgressReportCopyWithImpl(this._self, this._then);

  final GoalProgressReport _self;
  final $Res Function(GoalProgressReport) _then;

/// Create a copy of GoalProgressReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? targetMinor = null,Object? savedMinor = null,Object? status = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetMinor: null == targetMinor ? _self.targetMinor : targetMinor // ignore: cast_nullable_to_non_nullable
as int,savedMinor: null == savedMinor ? _self.savedMinor : savedMinor // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalProgressReport].
extension GoalProgressReportPatterns on GoalProgressReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalProgressReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalProgressReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalProgressReport value)  $default,){
final _that = this;
switch (_that) {
case _GoalProgressReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalProgressReport value)?  $default,){
final _that = this;
switch (_that) {
case _GoalProgressReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int targetMinor,  int savedMinor,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalProgressReport() when $default != null:
return $default(_that.name,_that.targetMinor,_that.savedMinor,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int targetMinor,  int savedMinor,  String status)  $default,) {final _that = this;
switch (_that) {
case _GoalProgressReport():
return $default(_that.name,_that.targetMinor,_that.savedMinor,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int targetMinor,  int savedMinor,  String status)?  $default,) {final _that = this;
switch (_that) {
case _GoalProgressReport() when $default != null:
return $default(_that.name,_that.targetMinor,_that.savedMinor,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalProgressReport implements GoalProgressReport {
  const _GoalProgressReport({required this.name, required this.targetMinor, required this.savedMinor, required this.status});
  factory _GoalProgressReport.fromJson(Map<String, dynamic> json) => _$GoalProgressReportFromJson(json);

@override final  String name;
@override final  int targetMinor;
@override final  int savedMinor;
@override final  String status;

/// Create a copy of GoalProgressReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalProgressReportCopyWith<_GoalProgressReport> get copyWith => __$GoalProgressReportCopyWithImpl<_GoalProgressReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalProgressReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalProgressReport&&(identical(other.name, name) || other.name == name)&&(identical(other.targetMinor, targetMinor) || other.targetMinor == targetMinor)&&(identical(other.savedMinor, savedMinor) || other.savedMinor == savedMinor)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,targetMinor,savedMinor,status);

@override
String toString() {
  return 'GoalProgressReport(name: $name, targetMinor: $targetMinor, savedMinor: $savedMinor, status: $status)';
}


}

/// @nodoc
abstract mixin class _$GoalProgressReportCopyWith<$Res> implements $GoalProgressReportCopyWith<$Res> {
  factory _$GoalProgressReportCopyWith(_GoalProgressReport value, $Res Function(_GoalProgressReport) _then) = __$GoalProgressReportCopyWithImpl;
@override @useResult
$Res call({
 String name, int targetMinor, int savedMinor, String status
});




}
/// @nodoc
class __$GoalProgressReportCopyWithImpl<$Res>
    implements _$GoalProgressReportCopyWith<$Res> {
  __$GoalProgressReportCopyWithImpl(this._self, this._then);

  final _GoalProgressReport _self;
  final $Res Function(_GoalProgressReport) _then;

/// Create a copy of GoalProgressReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? targetMinor = null,Object? savedMinor = null,Object? status = null,}) {
  return _then(_GoalProgressReport(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetMinor: null == targetMinor ? _self.targetMinor : targetMinor // ignore: cast_nullable_to_non_nullable
as int,savedMinor: null == savedMinor ? _self.savedMinor : savedMinor // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BillReliability {

 int get paid; int get pending; int get missed;
/// Create a copy of BillReliability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillReliabilityCopyWith<BillReliability> get copyWith => _$BillReliabilityCopyWithImpl<BillReliability>(this as BillReliability, _$identity);

  /// Serializes this BillReliability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillReliability&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.missed, missed) || other.missed == missed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paid,pending,missed);

@override
String toString() {
  return 'BillReliability(paid: $paid, pending: $pending, missed: $missed)';
}


}

/// @nodoc
abstract mixin class $BillReliabilityCopyWith<$Res>  {
  factory $BillReliabilityCopyWith(BillReliability value, $Res Function(BillReliability) _then) = _$BillReliabilityCopyWithImpl;
@useResult
$Res call({
 int paid, int pending, int missed
});




}
/// @nodoc
class _$BillReliabilityCopyWithImpl<$Res>
    implements $BillReliabilityCopyWith<$Res> {
  _$BillReliabilityCopyWithImpl(this._self, this._then);

  final BillReliability _self;
  final $Res Function(BillReliability) _then;

/// Create a copy of BillReliability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paid = null,Object? pending = null,Object? missed = null,}) {
  return _then(_self.copyWith(
paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,missed: null == missed ? _self.missed : missed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BillReliability].
extension BillReliabilityPatterns on BillReliability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillReliability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillReliability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillReliability value)  $default,){
final _that = this;
switch (_that) {
case _BillReliability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillReliability value)?  $default,){
final _that = this;
switch (_that) {
case _BillReliability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int paid,  int pending,  int missed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillReliability() when $default != null:
return $default(_that.paid,_that.pending,_that.missed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int paid,  int pending,  int missed)  $default,) {final _that = this;
switch (_that) {
case _BillReliability():
return $default(_that.paid,_that.pending,_that.missed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int paid,  int pending,  int missed)?  $default,) {final _that = this;
switch (_that) {
case _BillReliability() when $default != null:
return $default(_that.paid,_that.pending,_that.missed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillReliability implements BillReliability {
  const _BillReliability({required this.paid, required this.pending, required this.missed});
  factory _BillReliability.fromJson(Map<String, dynamic> json) => _$BillReliabilityFromJson(json);

@override final  int paid;
@override final  int pending;
@override final  int missed;

/// Create a copy of BillReliability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillReliabilityCopyWith<_BillReliability> get copyWith => __$BillReliabilityCopyWithImpl<_BillReliability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillReliabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillReliability&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.missed, missed) || other.missed == missed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paid,pending,missed);

@override
String toString() {
  return 'BillReliability(paid: $paid, pending: $pending, missed: $missed)';
}


}

/// @nodoc
abstract mixin class _$BillReliabilityCopyWith<$Res> implements $BillReliabilityCopyWith<$Res> {
  factory _$BillReliabilityCopyWith(_BillReliability value, $Res Function(_BillReliability) _then) = __$BillReliabilityCopyWithImpl;
@override @useResult
$Res call({
 int paid, int pending, int missed
});




}
/// @nodoc
class __$BillReliabilityCopyWithImpl<$Res>
    implements _$BillReliabilityCopyWith<$Res> {
  __$BillReliabilityCopyWithImpl(this._self, this._then);

  final _BillReliability _self;
  final $Res Function(_BillReliability) _then;

/// Create a copy of BillReliability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paid = null,Object? pending = null,Object? missed = null,}) {
  return _then(_BillReliability(
paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,missed: null == missed ? _self.missed : missed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SharedLedger {

 int get openObligations; int get settledExternally; int get totalAmountMinor;
/// Create a copy of SharedLedger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedLedgerCopyWith<SharedLedger> get copyWith => _$SharedLedgerCopyWithImpl<SharedLedger>(this as SharedLedger, _$identity);

  /// Serializes this SharedLedger to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedLedger&&(identical(other.openObligations, openObligations) || other.openObligations == openObligations)&&(identical(other.settledExternally, settledExternally) || other.settledExternally == settledExternally)&&(identical(other.totalAmountMinor, totalAmountMinor) || other.totalAmountMinor == totalAmountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,openObligations,settledExternally,totalAmountMinor);

@override
String toString() {
  return 'SharedLedger(openObligations: $openObligations, settledExternally: $settledExternally, totalAmountMinor: $totalAmountMinor)';
}


}

/// @nodoc
abstract mixin class $SharedLedgerCopyWith<$Res>  {
  factory $SharedLedgerCopyWith(SharedLedger value, $Res Function(SharedLedger) _then) = _$SharedLedgerCopyWithImpl;
@useResult
$Res call({
 int openObligations, int settledExternally, int totalAmountMinor
});




}
/// @nodoc
class _$SharedLedgerCopyWithImpl<$Res>
    implements $SharedLedgerCopyWith<$Res> {
  _$SharedLedgerCopyWithImpl(this._self, this._then);

  final SharedLedger _self;
  final $Res Function(SharedLedger) _then;

/// Create a copy of SharedLedger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? openObligations = null,Object? settledExternally = null,Object? totalAmountMinor = null,}) {
  return _then(_self.copyWith(
openObligations: null == openObligations ? _self.openObligations : openObligations // ignore: cast_nullable_to_non_nullable
as int,settledExternally: null == settledExternally ? _self.settledExternally : settledExternally // ignore: cast_nullable_to_non_nullable
as int,totalAmountMinor: null == totalAmountMinor ? _self.totalAmountMinor : totalAmountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedLedger].
extension SharedLedgerPatterns on SharedLedger {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedLedger value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedLedger() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedLedger value)  $default,){
final _that = this;
switch (_that) {
case _SharedLedger():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedLedger value)?  $default,){
final _that = this;
switch (_that) {
case _SharedLedger() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int openObligations,  int settledExternally,  int totalAmountMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedLedger() when $default != null:
return $default(_that.openObligations,_that.settledExternally,_that.totalAmountMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int openObligations,  int settledExternally,  int totalAmountMinor)  $default,) {final _that = this;
switch (_that) {
case _SharedLedger():
return $default(_that.openObligations,_that.settledExternally,_that.totalAmountMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int openObligations,  int settledExternally,  int totalAmountMinor)?  $default,) {final _that = this;
switch (_that) {
case _SharedLedger() when $default != null:
return $default(_that.openObligations,_that.settledExternally,_that.totalAmountMinor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedLedger implements SharedLedger {
  const _SharedLedger({required this.openObligations, required this.settledExternally, required this.totalAmountMinor});
  factory _SharedLedger.fromJson(Map<String, dynamic> json) => _$SharedLedgerFromJson(json);

@override final  int openObligations;
@override final  int settledExternally;
@override final  int totalAmountMinor;

/// Create a copy of SharedLedger
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedLedgerCopyWith<_SharedLedger> get copyWith => __$SharedLedgerCopyWithImpl<_SharedLedger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedLedgerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedLedger&&(identical(other.openObligations, openObligations) || other.openObligations == openObligations)&&(identical(other.settledExternally, settledExternally) || other.settledExternally == settledExternally)&&(identical(other.totalAmountMinor, totalAmountMinor) || other.totalAmountMinor == totalAmountMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,openObligations,settledExternally,totalAmountMinor);

@override
String toString() {
  return 'SharedLedger(openObligations: $openObligations, settledExternally: $settledExternally, totalAmountMinor: $totalAmountMinor)';
}


}

/// @nodoc
abstract mixin class _$SharedLedgerCopyWith<$Res> implements $SharedLedgerCopyWith<$Res> {
  factory _$SharedLedgerCopyWith(_SharedLedger value, $Res Function(_SharedLedger) _then) = __$SharedLedgerCopyWithImpl;
@override @useResult
$Res call({
 int openObligations, int settledExternally, int totalAmountMinor
});




}
/// @nodoc
class __$SharedLedgerCopyWithImpl<$Res>
    implements _$SharedLedgerCopyWith<$Res> {
  __$SharedLedgerCopyWithImpl(this._self, this._then);

  final _SharedLedger _self;
  final $Res Function(_SharedLedger) _then;

/// Create a copy of SharedLedger
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? openObligations = null,Object? settledExternally = null,Object? totalAmountMinor = null,}) {
  return _then(_SharedLedger(
openObligations: null == openObligations ? _self.openObligations : openObligations // ignore: cast_nullable_to_non_nullable
as int,settledExternally: null == settledExternally ? _self.settledExternally : settledExternally // ignore: cast_nullable_to_non_nullable
as int,totalAmountMinor: null == totalAmountMinor ? _self.totalAmountMinor : totalAmountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ValidationChecklistItem {

 String get item; bool get completed;
/// Create a copy of ValidationChecklistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationChecklistItemCopyWith<ValidationChecklistItem> get copyWith => _$ValidationChecklistItemCopyWithImpl<ValidationChecklistItem>(this as ValidationChecklistItem, _$identity);

  /// Serializes this ValidationChecklistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationChecklistItem&&(identical(other.item, item) || other.item == item)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item,completed);

@override
String toString() {
  return 'ValidationChecklistItem(item: $item, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $ValidationChecklistItemCopyWith<$Res>  {
  factory $ValidationChecklistItemCopyWith(ValidationChecklistItem value, $Res Function(ValidationChecklistItem) _then) = _$ValidationChecklistItemCopyWithImpl;
@useResult
$Res call({
 String item, bool completed
});




}
/// @nodoc
class _$ValidationChecklistItemCopyWithImpl<$Res>
    implements $ValidationChecklistItemCopyWith<$Res> {
  _$ValidationChecklistItemCopyWithImpl(this._self, this._then);

  final ValidationChecklistItem _self;
  final $Res Function(ValidationChecklistItem) _then;

/// Create a copy of ValidationChecklistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,Object? completed = null,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidationChecklistItem].
extension ValidationChecklistItemPatterns on ValidationChecklistItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ValidationChecklistItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ValidationChecklistItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ValidationChecklistItem value)  $default,){
final _that = this;
switch (_that) {
case _ValidationChecklistItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ValidationChecklistItem value)?  $default,){
final _that = this;
switch (_that) {
case _ValidationChecklistItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String item,  bool completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidationChecklistItem() when $default != null:
return $default(_that.item,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String item,  bool completed)  $default,) {final _that = this;
switch (_that) {
case _ValidationChecklistItem():
return $default(_that.item,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String item,  bool completed)?  $default,) {final _that = this;
switch (_that) {
case _ValidationChecklistItem() when $default != null:
return $default(_that.item,_that.completed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ValidationChecklistItem implements ValidationChecklistItem {
  const _ValidationChecklistItem({required this.item, required this.completed});
  factory _ValidationChecklistItem.fromJson(Map<String, dynamic> json) => _$ValidationChecklistItemFromJson(json);

@override final  String item;
@override final  bool completed;

/// Create a copy of ValidationChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidationChecklistItemCopyWith<_ValidationChecklistItem> get copyWith => __$ValidationChecklistItemCopyWithImpl<_ValidationChecklistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValidationChecklistItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidationChecklistItem&&(identical(other.item, item) || other.item == item)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item,completed);

@override
String toString() {
  return 'ValidationChecklistItem(item: $item, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$ValidationChecklistItemCopyWith<$Res> implements $ValidationChecklistItemCopyWith<$Res> {
  factory _$ValidationChecklistItemCopyWith(_ValidationChecklistItem value, $Res Function(_ValidationChecklistItem) _then) = __$ValidationChecklistItemCopyWithImpl;
@override @useResult
$Res call({
 String item, bool completed
});




}
/// @nodoc
class __$ValidationChecklistItemCopyWithImpl<$Res>
    implements _$ValidationChecklistItemCopyWith<$Res> {
  __$ValidationChecklistItemCopyWithImpl(this._self, this._then);

  final _ValidationChecklistItem _self;
  final $Res Function(_ValidationChecklistItem) _then;

/// Create a copy of ValidationChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? completed = null,}) {
  return _then(_ValidationChecklistItem(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
