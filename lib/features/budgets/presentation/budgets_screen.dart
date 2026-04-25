import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgets = ref.watch(budgetsProvider);
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.budgetsTitle,
      selectedTab: FeloRootTab.budgets,
      actions: [
        IconButton(
          tooltip: l10n.budgetFormTitle,
          onPressed: () => context.go('/budgets/edit'),
          icon: const Icon(Icons.add_rounded),
        ),
      ],
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final budget = budgets[index];
          final progress = budget.spentMinor / budget.limitMinor;
          return FeloCard(
            onTap: () => context.go('/budgets/${budget.id}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        budget.category,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    Text(
                      formatMinorMoney(minor: budget.spentMinor, currency: budget.currency),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: progress.clamp(0, 1),
                  minHeight: 9,
                  borderRadius: BorderRadius.circular(99),
                ),
                const SizedBox(height: 8),
                Text(
                  '${formatMinorMoney(minor: budget.limitMinor - budget.spentMinor, currency: budget.currency)} ${l10n.homeBudgetLeft}',
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: budgets.length,
      ),
    );
  }
}
