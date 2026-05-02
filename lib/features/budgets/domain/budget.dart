import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget.freezed.dart';
part 'budget.g.dart';

enum BudgetPeriod { weekly, monthly }

@freezed
abstract class Budget with _$Budget {
  const factory Budget({
    required String id,
    required String category,
    required String currency,
    required int limitMinor,
    required int spentMinor,
    required BudgetPeriod period,
    required bool rolloverEnabled,
    required int alertThresholdPercent,
  }) = _Budget;

  factory Budget.fromJson(Map<String, Object?> json) => _$BudgetFromJson(json);
}
