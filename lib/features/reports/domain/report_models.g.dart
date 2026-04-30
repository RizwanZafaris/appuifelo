// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyReport _$WeeklyReportFromJson(Map<String, dynamic> json) =>
    _WeeklyReport(
      period: ReportPeriod.fromJson(json['period'] as Map<String, dynamic>),
      moneyPulse: MoneyPulse.fromJson(
        json['moneyPulse'] as Map<String, dynamic>,
      ),
      topMovers: (json['topMovers'] as List<dynamic>)
          .map((e) => TopMover.fromJson(e as Map<String, dynamic>))
          .toList(),
      billsAhead: (json['billsAhead'] as List<dynamic>)
          .map((e) => BillAhead.fromJson(e as Map<String, dynamic>))
          .toList(),
      goalsAtRisk: (json['goalsAtRisk'] as List<dynamic>)
          .map((e) => GoalAtRisk.fromJson(e as Map<String, dynamic>))
          .toList(),
      sharedObligations: (json['sharedObligations'] as List<dynamic>)
          .map((e) => SharedObligation.fromJson(e as Map<String, dynamic>))
          .toList(),
      aiSuggestion: json['aiSuggestion'] as String,
    );

Map<String, dynamic> _$WeeklyReportToJson(_WeeklyReport instance) =>
    <String, dynamic>{
      'period': instance.period,
      'moneyPulse': instance.moneyPulse,
      'topMovers': instance.topMovers,
      'billsAhead': instance.billsAhead,
      'goalsAtRisk': instance.goalsAtRisk,
      'sharedObligations': instance.sharedObligations,
      'aiSuggestion': instance.aiSuggestion,
    };

_ReportPeriod _$ReportPeriodFromJson(Map<String, dynamic> json) =>
    _ReportPeriod(start: json['start'] as String, end: json['end'] as String);

Map<String, dynamic> _$ReportPeriodToJson(_ReportPeriod instance) =>
    <String, dynamic>{'start': instance.start, 'end': instance.end};

_MoneyPulse _$MoneyPulseFromJson(Map<String, dynamic> json) => _MoneyPulse(
  totalLoggedSpend: (json['totalLoggedSpend'] as num).toInt(),
  remainingBudget: (json['remainingBudget'] as num).toInt(),
  confidenceScore: (json['confidenceScore'] as num).toInt(),
);

Map<String, dynamic> _$MoneyPulseToJson(_MoneyPulse instance) =>
    <String, dynamic>{
      'totalLoggedSpend': instance.totalLoggedSpend,
      'remainingBudget': instance.remainingBudget,
      'confidenceScore': instance.confidenceScore,
    };

_TopMover _$TopMoverFromJson(Map<String, dynamic> json) => _TopMover(
  category: json['category'] as String,
  amount: (json['amount'] as num).toInt(),
  changePercent: (json['changePercent'] as num).toInt(),
);

Map<String, dynamic> _$TopMoverToJson(_TopMover instance) => <String, dynamic>{
  'category': instance.category,
  'amount': instance.amount,
  'changePercent': instance.changePercent,
};

_BillAhead _$BillAheadFromJson(Map<String, dynamic> json) => _BillAhead(
  name: json['name'] as String,
  dueDate: json['dueDate'] as String,
  amountMinor: (json['amountMinor'] as num).toInt(),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$BillAheadToJson(_BillAhead instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dueDate': instance.dueDate,
      'amountMinor': instance.amountMinor,
      'currency': instance.currency,
    };

_GoalAtRisk _$GoalAtRiskFromJson(Map<String, dynamic> json) => _GoalAtRisk(
  name: json['name'] as String,
  progressPercent: (json['progressPercent'] as num).toInt(),
  projectedShortfall: (json['projectedShortfall'] as num).toInt(),
);

Map<String, dynamic> _$GoalAtRiskToJson(_GoalAtRisk instance) =>
    <String, dynamic>{
      'name': instance.name,
      'progressPercent': instance.progressPercent,
      'projectedShortfall': instance.projectedShortfall,
    };

_SharedObligation _$SharedObligationFromJson(Map<String, dynamic> json) =>
    _SharedObligation(
      splitName: json['splitName'] as String,
      pendingAmount: (json['pendingAmount'] as num).toInt(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$SharedObligationToJson(_SharedObligation instance) =>
    <String, dynamic>{
      'splitName': instance.splitName,
      'pendingAmount': instance.pendingAmount,
      'currency': instance.currency,
    };

_MonthlyReport _$MonthlyReportFromJson(Map<String, dynamic> json) =>
    _MonthlyReport(
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      incomeSummary: IncomeSummary.fromJson(
        json['incomeSummary'] as Map<String, dynamic>,
      ),
      expenseSummary: ExpenseSummary.fromJson(
        json['expenseSummary'] as Map<String, dynamic>,
      ),
      budgetPerformance: (json['budgetPerformance'] as List<dynamic>)
          .map((e) => BudgetPerformance.fromJson(e as Map<String, dynamic>))
          .toList(),
      goalProgress: (json['goalProgress'] as List<dynamic>)
          .map((e) => GoalProgressReport.fromJson(e as Map<String, dynamic>))
          .toList(),
      billReliability: BillReliability.fromJson(
        json['billReliability'] as Map<String, dynamic>,
      ),
      sharedLedger: SharedLedger.fromJson(
        json['sharedLedger'] as Map<String, dynamic>,
      ),
      validationChecklist: (json['validationChecklist'] as List<dynamic>)
          .map(
            (e) => ValidationChecklistItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$MonthlyReportToJson(_MonthlyReport instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'incomeSummary': instance.incomeSummary,
      'expenseSummary': instance.expenseSummary,
      'budgetPerformance': instance.budgetPerformance,
      'goalProgress': instance.goalProgress,
      'billReliability': instance.billReliability,
      'sharedLedger': instance.sharedLedger,
      'validationChecklist': instance.validationChecklist,
    };

_IncomeSummary _$IncomeSummaryFromJson(Map<String, dynamic> json) =>
    _IncomeSummary(
      totalIncomeMinor: (json['totalIncomeMinor'] as num).toInt(),
      sources: (json['sources'] as List<dynamic>)
          .map((e) => IncomeSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IncomeSummaryToJson(_IncomeSummary instance) =>
    <String, dynamic>{
      'totalIncomeMinor': instance.totalIncomeMinor,
      'sources': instance.sources,
    };

_IncomeSource _$IncomeSourceFromJson(Map<String, dynamic> json) =>
    _IncomeSource(
      category: json['category'] as String,
      amountMinor: (json['amountMinor'] as num).toInt(),
    );

Map<String, dynamic> _$IncomeSourceToJson(_IncomeSource instance) =>
    <String, dynamic>{
      'category': instance.category,
      'amountMinor': instance.amountMinor,
    };

_ExpenseSummary _$ExpenseSummaryFromJson(Map<String, dynamic> json) =>
    _ExpenseSummary(
      totalExpenseMinor: (json['totalExpenseMinor'] as num).toInt(),
      byCategory: (json['byCategory'] as List<dynamic>)
          .map((e) => ExpenseCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExpenseSummaryToJson(_ExpenseSummary instance) =>
    <String, dynamic>{
      'totalExpenseMinor': instance.totalExpenseMinor,
      'byCategory': instance.byCategory,
    };

_ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) =>
    _ExpenseCategory(
      category: json['category'] as String,
      amountMinor: (json['amountMinor'] as num).toInt(),
    );

Map<String, dynamic> _$ExpenseCategoryToJson(_ExpenseCategory instance) =>
    <String, dynamic>{
      'category': instance.category,
      'amountMinor': instance.amountMinor,
    };

_BudgetPerformance _$BudgetPerformanceFromJson(Map<String, dynamic> json) =>
    _BudgetPerformance(
      category: json['category'] as String,
      plannedMinor: (json['plannedMinor'] as num).toInt(),
      actualMinor: (json['actualMinor'] as num).toInt(),
      adherencePercent: (json['adherencePercent'] as num).toInt(),
    );

Map<String, dynamic> _$BudgetPerformanceToJson(_BudgetPerformance instance) =>
    <String, dynamic>{
      'category': instance.category,
      'plannedMinor': instance.plannedMinor,
      'actualMinor': instance.actualMinor,
      'adherencePercent': instance.adherencePercent,
    };

_GoalProgressReport _$GoalProgressReportFromJson(Map<String, dynamic> json) =>
    _GoalProgressReport(
      name: json['name'] as String,
      targetMinor: (json['targetMinor'] as num).toInt(),
      savedMinor: (json['savedMinor'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$GoalProgressReportToJson(_GoalProgressReport instance) =>
    <String, dynamic>{
      'name': instance.name,
      'targetMinor': instance.targetMinor,
      'savedMinor': instance.savedMinor,
      'status': instance.status,
    };

_BillReliability _$BillReliabilityFromJson(Map<String, dynamic> json) =>
    _BillReliability(
      paid: (json['paid'] as num).toInt(),
      pending: (json['pending'] as num).toInt(),
      missed: (json['missed'] as num).toInt(),
    );

Map<String, dynamic> _$BillReliabilityToJson(_BillReliability instance) =>
    <String, dynamic>{
      'paid': instance.paid,
      'pending': instance.pending,
      'missed': instance.missed,
    };

_SharedLedger _$SharedLedgerFromJson(Map<String, dynamic> json) =>
    _SharedLedger(
      openObligations: (json['openObligations'] as num).toInt(),
      settledExternally: (json['settledExternally'] as num).toInt(),
      totalAmountMinor: (json['totalAmountMinor'] as num).toInt(),
    );

Map<String, dynamic> _$SharedLedgerToJson(_SharedLedger instance) =>
    <String, dynamic>{
      'openObligations': instance.openObligations,
      'settledExternally': instance.settledExternally,
      'totalAmountMinor': instance.totalAmountMinor,
    };

_ValidationChecklistItem _$ValidationChecklistItemFromJson(
  Map<String, dynamic> json,
) => _ValidationChecklistItem(
  item: json['item'] as String,
  completed: json['completed'] as bool,
);

Map<String, dynamic> _$ValidationChecklistItemToJson(
  _ValidationChecklistItem instance,
) => <String, dynamic>{'item': instance.item, 'completed': instance.completed};
