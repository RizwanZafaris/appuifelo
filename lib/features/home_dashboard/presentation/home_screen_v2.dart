import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/budgets/data/budgets_repository.dart';
import 'package:felo/features/goals/data/goals_repository.dart';
import 'package:felo/features/transactions/data/transactions_repository.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';
import 'package:felo/shared/utils/money_format.dart';

/// Wio-inspired home dashboard with FELO branding.
/// Deep purple hero, bold balance, rounded cards, hub grid.
class HomeScreenV2 extends ConsumerWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final budgetsAsync = ref.watch(budgetsProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final goalsAsync = ref.watch(goalsProvider);
    final budgets = budgetsAsync.valueOrNull ?? const [];
    final transactions = transactionsAsync.valueOrNull ?? const [];
    final goals = goalsAsync.valueOrNull ?? const [];
    final allLoading = budgetsAsync.isLoading && transactionsAsync.isLoading && goalsAsync.isLoading;

    final totalLimitMinor = budgets.fold<int>(0, (s, b) => s + b.limitMinor);
    final totalSpentMinor = budgets.fold<int>(0, (s, b) => s + b.spentMinor);
    final totalLeftMinor = totalLimitMinor - totalSpentMinor;
    final progress = totalLimitMinor == 0 ? 0.0 : (totalSpentMinor / totalLimitMinor).clamp(0.0, 1.0);
    final primaryCurrency = budgets.isNotEmpty ? budgets.first.currency : 'CAD';

    return Scaffold(
      backgroundColor: FeloColors.surface,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait<void>([
            ref.refresh(budgetsProvider.future),
            ref.read(transactionsProvider.notifier).refresh(),
            ref.refresh(goalsProvider.future),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            // Hero header with gradient
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: FeloColors.heroGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => context.go('/notifications'),
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.go('/profile'),
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.homeGreeting,
                      style: const TextStyle(
                        color: FeloColors.heroTextMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatMinorMoney(
                        minor: totalLeftMinor,
                        currency: primaryCurrency,
                      ),
                      style: const TextStyle(
                        color: FeloColors.heroText,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: totalLeftMinor >= 0
                            ? FeloColors.floFinance.withOpacity(0.2)
                            : FeloColors.signalCrimson.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        totalLeftMinor >= 0 ? 'On track this month' : 'Over budget',
                        style: TextStyle(
                          color: totalLeftMinor >= 0
                              ? FeloColors.floFinance
                              : FeloColors.signalCrimson,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Quick Actions — horizontal scroll
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _QuickActionButton(
                            label: 'Send Money',
                            icon: Icons.send_rounded,
                            color: FeloColors.floTrust,
                            onTap: () => context.go('/send'),
                          ),
                          const SizedBox(width: 12),
                          _QuickActionButton(
                            label: 'Add Budget',
                            icon: Icons.add_chart_rounded,
                            color: FeloColors.floGrowth,
                            onTap: () => context.go('/budgets'),
                          ),
                          const SizedBox(width: 12),
                          _QuickActionButton(
                            label: 'Scan Receipt',
                            icon: Icons.document_scanner_rounded,
                            color: FeloColors.floFinance,
                            onTap: () => context.go('/receipt-capture'),
                          ),
                          const SizedBox(width: 12),
                          _QuickActionButton(
                            label: 'Split Bill',
                            icon: Icons.group_rounded,
                            color: FeloColors.floSplit,
                            onTap: () => context.go('/splits'),
                          ),
                          const SizedBox(width: 12),
                          _QuickActionButton(
                            label: 'Insights',
                            icon: Icons.insights_rounded,
                            color: FeloColors.floInvest,
                            onTap: () => context.go('/investments'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Hub Grid — all features
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hub',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _HubTile(
                          label: l10n.accountsTitle,
                          icon: Icons.account_balance_wallet_rounded,
                          color: FeloColors.floTrust,
                          onTap: () => context.go('/accounts'),
                        ),
                        _HubTile(
                          label: l10n.billsTitle,
                          icon: Icons.receipt_long_rounded,
                          color: FeloColors.floGrowth,
                          onTap: () => context.go('/bills'),
                        ),
                        _HubTile(
                          label: l10n.goalsTitle,
                          icon: Icons.flag_rounded,
                          color: FeloColors.floFinance,
                          onTap: () => context.go('/goals'),
                        ),
                        _HubTile(
                          label: l10n.splitsTitle,
                          icon: Icons.groups_2_rounded,
                          color: FeloColors.floSplit,
                          onTap: () => context.go('/splits'),
                        ),
                        _HubTile(
                          label: l10n.homeFamilyMode,
                          icon: Icons.family_restroom_rounded,
                          color: FeloColors.floInvest,
                          onTap: () => context.go('/family'),
                        ),
                        _HubTile(
                          label: l10n.homeSmsStatus,
                          icon: Icons.sms_rounded,
                          color: FeloColors.lavenderPrimary,
                          onTap: () => context.go('/sms-parser'),
                        ),
                        _HubTile(
                          label: l10n.homeRemittanceStub,
                          icon: Icons.public_rounded,
                          color: FeloColors.floTrust,
                          onTap: () => context.go('/remittance'),
                        ),
                        _HubTile(
                          label: 'AI Coach',
                          icon: Icons.smart_toy_rounded,
                          color: FeloColors.floInvest,
                          onTap: () => context.go('/coach'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Recent Transactions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          l10n.homeRecent,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => context.go('/transactions'),
                          child: Text(l10n.commonView),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    for (final tx in transactions.take(5)) ...[
                      _TransactionTile(transaction: tx),
                      const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
            ),

            // Budget Progress
            if (budgets.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            l10n.homeTopBudgets,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.go('/budgets'),
                            child: Text(l10n.commonView),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (final budget in budgets.take(3)) ...[
                        _BudgetTile(budget: budget),
                        const SizedBox(height: 8),
                      ],
                    ],
                  ),
                ),
              ),
            ],

            // Goals Progress
            if (goals.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            l10n.goalsTitle,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.go('/goals'),
                            child: Text(l10n.commonView),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (final goal in goals.take(2)) ...[
                        _GoalTile(goal: goal),
                        const SizedBox(height: 8),
                      ],
                    ],
                  ),
                ),
              ),
            ],

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HubTile extends StatelessWidget {
  const _HubTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final FeloTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.direction == TransactionDirection.credit;
    final amountColor = isCredit ? FeloColors.floFinance : Theme.of(context).colorScheme.onSurface;
    final sign = isCredit ? '+' : '-';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isCredit
                  ? FeloColors.floFinance.withOpacity(0.1)
                  : FeloColors.ink500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isCredit ? Icons.south_west_rounded : Icons.north_east_rounded,
              color: amountColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.merchant,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.category,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$sign${formatMinorMoney(minor: transaction.amountMinor, currency: transaction.currency)}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetTile extends StatelessWidget {
  const _BudgetTile({required this.budget});

  final dynamic budget;

  @override
  Widget build(BuildContext context) {
    final progress = budget.limitMinor == 0
        ? 0.0
        : (budget.spentMinor / budget.limitMinor).clamp(0.0, 1.0);
    final remaining = budget.limitMinor - budget.spentMinor;
    final isOver = remaining < 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: FeloColors.floFinance.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.pie_chart_outline_rounded,
                  color: FeloColors.floFinance,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  budget.category,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isOver ? FeloColors.signalCrimson : FeloColors.floFinance,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: FeloColors.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOver ? FeloColors.signalCrimson : FeloColors.floFinance,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${formatMinorMoney(minor: budget.spentMinor, currency: budget.currency)} of ${formatMinorMoney(minor: budget.limitMinor, currency: budget.currency)}',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalTile extends StatelessWidget {
  const _GoalTile({required this.goal});

  final dynamic goal;

  @override
  Widget build(BuildContext context) {
    final progress = goal.savedMinor / goal.targetMinor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: FeloColors.floGrowth.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.flag_rounded,
              color: FeloColors.floGrowth,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: FeloColors.surfaceContainerHighest,
                    valueColor: const AlwaysStoppedAnimation<Color>(FeloColors.floGrowth),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${(progress * 100).clamp(0, 100).toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: FeloColors.floGrowth,
            ),
          ),
        ],
      ),
    );
  }
}
