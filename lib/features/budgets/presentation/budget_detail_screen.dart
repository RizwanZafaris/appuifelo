import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';
import 'package:felo/shared/widgets/felo_progress_ring.dart';

class BudgetDetailScreen extends ConsumerWidget {
  const BudgetDetailScreen({required this.budgetId, super.key});

  final String budgetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final budget = ref
        .watch(budgetsProvider)
        .firstWhere((item) => item.id == budgetId);
    return FeloFeaturePlaceholder(
      title: l10n.budgetDetailTitle,
      body: l10n.budgetsBody,
      icon: Icons.pie_chart_rounded,
      children: [
        FeloProgressRing(
          progress: budget.spentMinor / budget.limitMinor,
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
  }
}
