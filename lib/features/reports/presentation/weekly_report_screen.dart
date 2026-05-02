import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/features/reports/application/reports_providers.dart';
import 'package:felo/features/reports/domain/report_models.dart';

class WeeklyReportScreen extends ConsumerWidget {
  const WeeklyReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyAsync = ref.watch(weeklyReportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Money Pulse'),
        centerTitle: true,
      ),
      body: weeklyAsync.when(
        data: (report) => _ReportContent(report: report),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => FeloEmptyState(
          title: 'Could not load report',
          body: e.toString(),
          actionLabel: 'Retry',
          onAction: () => ref.invalidate(weeklyReportProvider),
        ),
      ),
    );
  }
}

class _ReportContent extends StatelessWidget {
  final WeeklyReport report;

  const _ReportContent({required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Period header
          _PeriodChip(period: report.period),
          const SizedBox(height: 16),

          // Money Pulse Card
          _MoneyPulseCard(pulse: report.moneyPulse),
          const SizedBox(height: 16),

          // AI Suggestion
          _AiSuggestionCard(suggestion: report.aiSuggestion),
          const SizedBox(height: 16),

          // Top Movers
          if (report.topMovers.isNotEmpty) ...[
            Text('Top Movers', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            ...report.topMovers.map((m) => _TopMoverCard(mover: m)),
            const SizedBox(height: 16),
          ],

          // Bills Ahead
          if (report.billsAhead.isNotEmpty) ...[
            Text('Bills Ahead', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            ...report.billsAhead.map((b) => _BillAheadCard(bill: b)),
            const SizedBox(height: 16),
          ],

          // Goals At Risk
          if (report.goalsAtRisk.isNotEmpty) ...[
            Text('Goals At Risk', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            ...report.goalsAtRisk.map((g) => _GoalAtRiskCard(goal: g)),
            const SizedBox(height: 16),
          ],

          // Shared Obligations
          if (report.sharedObligations.isNotEmpty) ...[
            Text('Shared Obligations', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            ...report.sharedObligations.map((s) => _SharedObligationCard(obligation: s)),
          ],
        ],
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final ReportPeriod period;
  const _PeriodChip({required this.period});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      avatar: const Icon(Icons.date_range, size: 18),
      label: Text('${period.start} — ${period.end}'),
      backgroundColor: theme.colorScheme.primaryContainer,
    );
  }
}

class _MoneyPulseCard extends StatelessWidget {
  final MoneyPulse pulse;
  const _MoneyPulseCard({required this.pulse});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Money Pulse', style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _PulseMetric(
                  label: 'Spent',
                  value: formatter.format(pulse.totalLoggedSpend / 100),
                  icon: Icons.trending_down,
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: _PulseMetric(
                  label: 'Remaining',
                  value: formatter.format(pulse.remainingBudget / 100),
                  icon: Icons.account_balance_wallet,
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: _PulseMetric(
                  label: 'Confidence',
                  value: '${pulse.confidenceScore}%',
                  icon: Icons.verified,
                  color: pulse.confidenceScore > 70 ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: pulse.confidenceScore / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(
              pulse.confidenceScore > 70 ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseMetric extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _PulseMetric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _AiSuggestionCard extends StatelessWidget {
  final String suggestion;
  const _AiSuggestionCard({required this.suggestion});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FeloCard(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Suggestion', style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(suggestion, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopMoverCard extends StatelessWidget {
  final TopMover mover;
  const _TopMoverCard({required this.mover});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final isPositive = mover.changePercent >= 0;

    return FeloCard(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(mover.category[0].toUpperCase()),
        ),
        title: Text(mover.category),
        subtitle: Text(formatter.format(mover.amount / 100)),
        trailing: Chip(
          label: Text(
            '${isPositive ? '+' : ''}${mover.changePercent}%',
            style: TextStyle(color: isPositive ? Colors.red : Colors.green),
          ),
          backgroundColor: isPositive ? Colors.red[50] : Colors.green[50],
        ),
      ),
    );
  }
}

class _BillAheadCard extends StatelessWidget {
  final BillAhead bill;
  const _BillAheadCard({required this.bill});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return FeloCard(
      child: ListTile(
        leading: const Icon(Icons.calendar_today, color: Colors.orange),
        title: Text(bill.name),
        subtitle: Text('Due: ${bill.dueDate}'),
        trailing: Text(
          formatter.format(bill.amountMinor / 100),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _GoalAtRiskCard extends StatelessWidget {
  final GoalAtRisk goal;
  const _GoalAtRiskCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.flag, color: Colors.red),
            title: Text(goal.name),
            subtitle: Text('${goal.progressPercent}% complete'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LinearProgressIndicator(
              value: goal.progressPercent / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(
                goal.progressPercent > 50 ? Colors.orange : Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Shortfall: ${formatter.format(goal.projectedShortfall / 100)}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _SharedObligationCard extends StatelessWidget {
  final SharedObligation obligation;
  const _SharedObligationCard({required this.obligation});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return FeloCard(
      child: ListTile(
        leading: const Icon(Icons.people, color: Colors.blue),
        title: Text(obligation.splitName),
        trailing: Text(
          formatter.format(obligation.pendingAmount / 100),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
