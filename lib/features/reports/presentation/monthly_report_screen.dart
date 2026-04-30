import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/features/reports/application/reports_providers.dart';
import 'package:felo/features/reports/domain/report_models.dart';

class MonthlyReportScreen extends ConsumerStatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  ConsumerState<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends ConsumerState<MonthlyReportScreen> {
  late int _year;
  late int _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
  }

  void _previousMonth() {
    setState(() {
      if (_month == 1) {
        _month = 12;
        _year--;
      } else {
        _month--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (_month == 12) {
        _month = 1;
        _year++;
      } else {
        _month++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthlyAsync = ref.watch(monthlyReportProvider(_year, _month));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Close'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Month selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _previousMonth,
                ),
                Text(
                  DateFormat('MMMM yyyy').format(DateTime(_year, _month)),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),

          // Report content
          Expanded(
            child: monthlyAsync.when(
              data: (report) => _MonthlyReportContent(report: report),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => FeloEmptyState(
                title: 'Could not load report',
                body: e.toString(),
                actionLabel: 'Retry',
                onAction: () => ref.invalidate(monthlyReportProvider(_year, _month)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyReportContent extends StatelessWidget {
  final MonthlyReport report;
  const _MonthlyReportContent({required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Income vs Expense summary
        FeloCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Income vs Expenses', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _SummaryMetric(
                      label: 'Income',
                      value: formatter.format(report.incomeSummary.totalIncomeMinor / 100),
                      color: Colors.green,
                      icon: Icons.arrow_downward,
                    ),
                  ),
                  Expanded(
                    child: _SummaryMetric(
                      label: 'Expenses',
                      value: formatter.format(report.expenseSummary.totalExpenseMinor / 100),
                      color: Colors.red,
                      icon: Icons.arrow_upward,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Budget Performance
        if (report.budgetPerformance.isNotEmpty) ...[
          Text('Budget Performance', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          ...report.budgetPerformance.map((b) => _BudgetPerformanceCard(performance: b)),
          const SizedBox(height: 16),
        ],

        // Goal Progress
        if (report.goalProgress.isNotEmpty) ...[
          Text('Goal Progress', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          ...report.goalProgress.map((g) => _GoalProgressCard(goal: g)),
          const SizedBox(height: 16),
        ],

        // Bill Reliability
        FeloCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bill Reliability', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BillReliabilityMetric(label: 'Paid', value: report.billReliability.paid, color: Colors.green),
                  _BillReliabilityMetric(label: 'Pending', value: report.billReliability.pending, color: Colors.orange),
                  _BillReliabilityMetric(label: 'Missed', value: report.billReliability.missed, color: Colors.red),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Validation Checklist
        Text('Validation Checklist', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        ...report.validationChecklist.map((item) => _ChecklistItemWidget(item: item)),
        const SizedBox(height: 24),

        // Close Month Button
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.lock_outline),
            label: const Text('Validate & Close This Month'),
          ),
        ),
      ],
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}

class _BudgetPerformanceCard extends StatelessWidget {
  final BudgetPerformance performance;
  const _BudgetPerformanceCard({required this.performance});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final adherence = performance.adherencePercent;

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(performance.category),
            subtitle: Text(
              'Planned: ${formatter.format(performance.plannedMinor / 100)} '
              '| Actual: ${formatter.format(performance.actualMinor / 100)}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LinearProgressIndicator(
              value: (100 - adherence.clamp(0, 100)) / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(
                adherence >= 80 ? Colors.green : adherence >= 50 ? Colors.orange : Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              adherence >= 80 ? 'On track' : adherence >= 50 ? 'Over budget' : 'Well over budget',
              style: TextStyle(
                color: adherence >= 80 ? Colors.green : adherence >= 50 ? Colors.orange : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalProgressCard extends StatelessWidget {
  final GoalProgressReport goal;
  const _GoalProgressCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final progress = goal.targetMinor > 0
        ? (goal.savedMinor / goal.targetMinor).clamp(0.0, 1.0)
        : 0.0;

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(goal.name),
            subtitle: Text('${formatter.format(goal.savedMinor / 100)} of ${formatter.format(goal.targetMinor / 100)}'),
            trailing: Chip(
              label: Text(goal.status == 'on_track' ? 'On Track' : goal.status == 'slipping' ? 'Slipping' : 'Missed'),
              backgroundColor: goal.status == 'on_track'
                  ? Colors.green[100]
                  : goal.status == 'slipping'
                      ? Colors.orange[100]
                      : Colors.red[100],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(
                goal.status == 'on_track'
                    ? Colors.green
                    : goal.status == 'slipping'
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BillReliabilityMetric extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _BillReliabilityMetric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}

class _ChecklistItemWidget extends StatelessWidget {
  final ValidationChecklistItem item;
  const _ChecklistItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      child: CheckboxListTile(
        value: item.completed,
        onChanged: null,
        title: Text(
          item.item,
          style: TextStyle(
            decoration: item.completed ? TextDecoration.lineThrough : null,
            color: item.completed ? Colors.grey : null,
          ),
        ),
        secondary: Icon(
          item.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: item.completed ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
