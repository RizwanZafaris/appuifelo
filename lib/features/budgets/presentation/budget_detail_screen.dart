import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/budgets/data/budgets_repository.dart';
import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';
import 'package:felo/shared/widgets/felo_progress_ring.dart';

class BudgetDetailScreen extends ConsumerWidget {
  const BudgetDetailScreen({required this.budgetId, super.key});

  final String budgetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final budgetsAsync = ref.watch(budgetsProvider);
    return budgetsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Could not load budget: $error')),
      ),
      data: (budgets) {
        final Budget? budget = budgets.where((b) => b.id == budgetId).isEmpty
            ? null
            : budgets.firstWhere((b) => b.id == budgetId);
        if (budget == null) {
          return const Scaffold(
            body: Center(child: Text('Budget not found')),
          );
        }
        final progress = budget.limitMinor == 0
            ? 0.0
            : (budget.spentMinor / budget.limitMinor).clamp(0.0, 1.0);
        return FeloFeaturePlaceholder(
          title: l10n.budgetDetailTitle,
          body: l10n.budgetsBody,
          icon: Icons.pie_chart_rounded,
          children: [
            FeloProgressRing(
              progress: progress,
              label: budget.category,
              size: 128,
            ),
            const SizedBox(height: 16),
            Text(
              '${budget.category}: ${formatMinorMoney(minor: budget.spentMinor, currency: budget.currency)}',
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
