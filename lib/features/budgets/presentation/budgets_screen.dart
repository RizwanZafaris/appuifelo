import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/budgets/data/budgets_repository.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsAsync = ref.watch(budgetsProvider);
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.budgetsTitle,
      selectedTab: FeloRootTab.doHub,
      actions: [
        IconButton(
          tooltip: l10n.budgetFormTitle,
          onPressed: () => context.go('/budgets/edit'),
          icon: const Icon(Icons.add_rounded),
        ),
      ],
      child: budgetsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(20),
          child: FeloEmptyState(
            title: 'Could not load budgets',
            body: error.toString(),
          ),
        ),
        data: (budgets) {
          if (budgets.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: FeloEmptyState(
                title: l10n.budgetsTitle,
                body: l10n.budgetsBody,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(budgetsProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final budget = budgets[index];
                final progress = budget.limitMinor == 0
                    ? 0.0
                    : (budget.spentMinor / budget.limitMinor).clamp(0.0, 1.0);
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
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ),
                          Text(
                            formatMinorMoney(
                              minor: budget.spentMinor,
                              currency: budget.currency,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progress,
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
        },
      ),
    );
  }
}
