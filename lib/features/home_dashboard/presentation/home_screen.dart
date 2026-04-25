import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
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

    return FeloScaffold(
      title: l10n.homeTitle,
      selectedTab: FeloRootTab.home,
      actions: [
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
                  l10n.sampleDashboardAmount,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 18),
                LinearProgressIndicator(
                  value: 0.62,
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
                child: _MetricCard(label: l10n.homeSpendThisMonth, value: 'CAD 1,360'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(label: l10n.homeBudgetLeft, value: 'CAD 1,840'),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _SectionHeader(title: l10n.homeTopBudgets, onView: () => context.go('/budgets')),
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
            FeloCard(
              onTap: () => context.go('/transactions/${transaction.id}'),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long_outlined),
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
                    formatMinorMoney(
                      minor: transaction.amountMinor,
                      currency: transaction.currency,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 14),
          Text(
            l10n.hubTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
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
              _ActionTile(label: l10n.homeFamilyMode, icon: Icons.groups_2_outlined, onTap: () => context.go('/family')),
              _ActionTile(label: l10n.homeSmsStatus, icon: Icons.sms_outlined, onTap: () => context.go('/sms-parser')),
              _ActionTile(label: l10n.homeRemittanceStub, icon: Icons.public_rounded, onTap: () => context.go('/remittance')),
              _ActionTile(label: l10n.goalsTitle, icon: Icons.flag_outlined, onTap: () => context.go('/goals')),
            ],
          ),
          if (goals.isNotEmpty) const SizedBox(height: 4),
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
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
