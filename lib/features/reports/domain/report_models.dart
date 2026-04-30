import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_models.freezed.dart';
part 'report_models.g.dart';

@freezed
class WeeklyReport with _$WeeklyReport {
  const factory WeeklyReport({
    required ReportPeriod period,
    required MoneyPulse moneyPulse,
    required List<TopMover> topMovers,
    required List<BillAhead> billsAhead,
    required List<GoalAtRisk> goalsAtRisk,
    required List<SharedObligation> sharedObligations,
    required String aiSuggestion,
  }) = _WeeklyReport;

  factory WeeklyReport.fromJson(Map<String, Object?> json) =>
      _$WeeklyReportFromJson(json);
}

@freezed
class ReportPeriod with _$ReportPeriod {
  const factory ReportPeriod({
    required String start,
    required String end,
  }) = _ReportPeriod;

  factory ReportPeriod.fromJson(Map<String, Object?> json) =>
      _$ReportPeriodFromJson(json);
}

@freezed
class MoneyPulse with _$MoneyPulse {
  const factory MoneyPulse({
    required int totalLoggedSpend,
    required int remainingBudget,
    required int confidenceScore,
  }) = _MoneyPulse;

  factory MoneyPulse.fromJson(Map<String, Object?> json) =>
      _$MoneyPulseFromJson(json);
}

@freezed
class TopMover with _$TopMover {
  const factory TopMover({
    required String category,
    required int amount,
    required int changePercent,
  }) = _TopMover;

  factory TopMover.fromJson(Map<String, Object?> json) =>
      _$TopMoverFromJson(json);
}

@freezed
class BillAhead with _$BillAhead {
  const factory BillAhead({
    required String name,
    required String dueDate,
    required int amountMinor,
    required String currency,
  }) = _BillAhead;

  factory BillAhead.fromJson(Map<String, Object?> json) =>
      _$BillAheadFromJson(json);
}

@freezed
class GoalAtRisk with _$GoalAtRisk {
  const factory GoalAtRisk({
    required String name,
    required int progressPercent,
    required int projectedShortfall,
  }) = _GoalAtRisk;

  factory GoalAtRisk.fromJson(Map<String, Object?> json) =>
      _$GoalAtRiskFromJson(json);
}

@freezed
class SharedObligation with _$SharedObligation {
  const factory SharedObligation({
    required String splitName,
    required int pendingAmount,
    required String currency,
  }) = _SharedObligation;

  factory SharedObligation.fromJson(Map<String, Object?> json) =>
      _$SharedObligationFromJson(json);
}

@freezed
class MonthlyReport with _$MonthlyReport {
  const factory MonthlyReport({
    required int year,
    required int month,
    required IncomeSummary incomeSummary,
    required ExpenseSummary expenseSummary,
    required List<BudgetPerformance> budgetPerformance,
    required List<GoalProgressReport> goalProgress,
    required BillReliability billReliability,
    required SharedLedger sharedLedger,
    required List<ValidationChecklistItem> validationChecklist,
  }) = _MonthlyReport;

  factory MonthlyReport.fromJson(Map<String, Object?> json) =>
      _$MonthlyReportFromJson(json);
}

@freezed
class IncomeSummary with _$IncomeSummary {
  const factory IncomeSummary({
    required int totalIncomeMinor,
    required List<IncomeSource> sources,
  }) = _IncomeSummary;

  factory IncomeSummary.fromJson(Map<String, Object?> json) =>
      _$IncomeSummaryFromJson(json);
}

@freezed
class IncomeSource with _$IncomeSource {
  const factory IncomeSource({
    required String category,
    required int amountMinor,
  }) = _IncomeSource;

  factory IncomeSource.fromJson(Map<String, Object?> json) =>
      _$IncomeSourceFromJson(json);
}

@freezed
class ExpenseSummary with _$ExpenseSummary {
  const factory ExpenseSummary({
    required int totalExpenseMinor,
    required List<ExpenseCategory> byCategory,
  }) = _ExpenseSummary;

  factory ExpenseSummary.fromJson(Map<String, Object?> json) =>
      _$ExpenseSummaryFromJson(json);
}

@freezed
class ExpenseCategory with _$ExpenseCategory {
  const factory ExpenseCategory({
    required String category,
    required int amountMinor,
  }) = _ExpenseCategory;

  factory ExpenseCategory.fromJson(Map<String, Object?> json) =>
      _$ExpenseCategoryFromJson(json);
}

@freezed
class BudgetPerformance with _$BudgetPerformance {
  const factory BudgetPerformance({
    required String category,
    required int plannedMinor,
    required int actualMinor,
    required int adherencePercent,
  }) = _BudgetPerformance;

  factory BudgetPerformance.fromJson(Map<String, Object?> json) =>
      _$BudgetPerformanceFromJson(json);
}

@freezed
class GoalProgressReport with _$GoalProgressReport {
  const factory GoalProgressReport({
    required String name,
    required int targetMinor,
    required int savedMinor,
    required String status,
  }) = _GoalProgressReport;

  factory GoalProgressReport.fromJson(Map<String, Object?> json) =>
      _$GoalProgressReportFromJson(json);
}

@freezed
class BillReliability with _$BillReliability {
  const factory BillReliability({
    required int paid,
    required int pending,
    required int missed,
  }) = _BillReliability;

  factory BillReliability.fromJson(Map<String, Object?> json) =>
      _$BillReliabilityFromJson(json);
}

@freezed
class SharedLedger with _$SharedLedger {
  const factory SharedLedger({
    required int openObligations,
    required int settledExternally,
    required int totalAmountMinor,
  }) = _SharedLedger;

  factory SharedLedger.fromJson(Map<String, Object?> json) =>
      _$SharedLedgerFromJson(json);
}

@freezed
class ValidationChecklistItem with _$ValidationChecklistItem {
  const factory ValidationChecklistItem({
    required String item,
    required bool completed,
  }) = _ValidationChecklistItem;

  factory ValidationChecklistItem.fromJson(Map<String, Object?> json) =>
      _$ValidationChecklistItemFromJson(json);
}
