import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final budgets = ref.watch(budgetsProvider);
    final transactions = ref.watch(transactionsProvider);
    final goals = ref.watch(goalsProvider);
    final unreadNotifications = ref.watch(unreadNotificationCountProvider);

    // Aggregate totals from real data instead of hardcoded strings.
    final totalLimitMinor = budgets.fold<int>(0, (s, b) => s + b.limitMinor);
    final totalSpentMinor = budgets.fold<int>(0, (s, b) => s + b.spentMinor);
    final totalLeftMinor = totalLimitMinor - totalSpentMinor;
    final progress = totalLimitMinor == 0
        ? 0.0
        : (totalSpentMinor / totalLimitMinor).clamp(0.0, 1.0);
    final primaryCurrency = budgets.isNotEmpty ? budgets.first.currency : 'CAD';

    return FeloScaffold(
      title: l10n.homeTitle,
      selectedTab: FeloRootTab.home,
      actions: [
        IconButton(
          tooltip: l10n.notificationsBellTooltip,
          onPressed: () => context.go('/notifications'),
          icon: Badge(
            isLabelVisible: unreadNotifications > 0,
            label: Text(unreadNotifications.toString()),
            child: const Icon(Icons.notifications_none_rounded),
          ),
        ),
        IconButton(
          tooltip: l10n.profileTitle,
          onPressed: () => context.go('/profile'),
          icon: const Icon(Icons.person_outline_rounded),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.homeGreeting,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          FeloCard(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.homeNetPosition),
                const SizedBox(height: 8),
                Text(
                  formatMinorMoney(
                    minor: totalLeftMinor,
                    currency: primaryCurrency,
                  ),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(99),
                  color: FeloColors.feloiTeal,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: l10n.homeSpendThisMonth,
                  value: formatMinorMoney(
                    minor: totalSpentMinor,
                    currency: primaryCurrency,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: l10n.homeBudgetLeft,
                  value: formatMinorMoney(
                    minor: totalLeftMinor,
                    currency: primaryCurrency,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _SectionHeader(
            title: l10n.homeTopBudgets,
            onView: () => context.go('/budgets'),
          ),
          const SizedBox(height: 10),
          for (final budget in budgets.take(3)) ...[
            FeloCard(
              onTap: () => context.go('/budgets/${budget.id}'),
              child: Row(
                children: [
                  const Icon(Icons.pie_chart_outline_rounded),
                  const SizedBox(width: 12),
                  Expanded(child: Text(budget.category)),
                  Text(
                    formatMinorMoney(
                      minor: budget.limitMinor - budget.spentMinor,
                      currency: budget.currency,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 14),
          _SectionHeader(
            title: l10n.homeRecent,
            onView: () => context.go('/transactions'),
          ),
          const SizedBox(height: 10),
          for (final transaction in transactions.take(3)) ...[
            Builder(
              builder: (context) {
                final isCredit =
                    transaction.direction == TransactionDirection.credit;
                final amountColor = isCredit
                    ? Colors.green.shade400
                    : Theme.of(context).colorScheme.onSurface;
                final sign = isCredit ? '+' : '-';
                return FeloCard(
                  onTap: () => context.go('/transactions/${transaction.id}'),
                  child: Row(
                    children: [
                      Icon(
                        isCredit
                            ? Icons.south_west_rounded
                            : Icons.north_east_rounded,
                        color: amountColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transaction.merchant),
                            Text(
                              transaction.category,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$sign${formatMinorMoney(minor: transaction.amountMinor, currency: transaction.currency)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: amountColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 14),
          Text(
            l10n.hubTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _ActionTile(
                label: l10n.homeFamilyMode,
                icon: Icons.groups_2_outlined,
                onTap: () => context.go('/family'),
              ),
              _ActionTile(
                label: l10n.homeSmsStatus,
                icon: Icons.sms_outlined,
                onTap: () => context.go('/sms-parser'),
              ),
              _ActionTile(
                label: l10n.accountsTitle,
                icon: Icons.account_balance_outlined,
                onTap: () => context.go('/accounts'),
              ),
              _ActionTile(
                label: l10n.billsTitle,
                icon: Icons.event_note_outlined,
                onTap: () => context.go('/bills'),
              ),
              _ActionTile(
                label: l10n.sendTitle,
                icon: Icons.send_outlined,
                onTap: () => context.go('/send'),
              ),
              _ActionTile(
                label: l10n.homeRemittanceStub,
                icon: Icons.public_rounded,
                onTap: () => context.go('/remittance'),
              ),
              _ActionTile(
                label: l10n.goalsTitle,
                icon: Icons.flag_outlined,
                onTap: () => context.go('/goals'),
              ),
            ],
          ),
          if (goals.isNotEmpty) ...[
            const SizedBox(height: 22),
            _SectionHeader(
              title: l10n.goalsTitle,
              onView: () => context.go('/goals'),
            ),
            const SizedBox(height: 10),
            for (final goal in goals.take(2)) ...[
              FeloCard(
                onTap: () => context.go('/goals/${goal.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.flag_outlined),
                        const SizedBox(width: 12),
                        Expanded(child: Text(goal.name)),
                        Text(
                          '${((goal.savedMinor / goal.targetMinor) * 100).clamp(0, 100).toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: (goal.savedMinor / goal.targetMinor).clamp(
                        0.0,
                        1.0,
                      ),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(99),
                      color: FeloColors.feloiTeal,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onView});

  final String title;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        TextButton(onPressed: onView, child: Text(context.l10n.commonView)),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(label, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
