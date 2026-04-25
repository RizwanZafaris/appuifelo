import 'package:flutter/material.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';
import 'package:felo/shared/widgets/felo_input.dart';

class BudgetFormScreen extends StatelessWidget {
  const BudgetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloFeaturePlaceholder(
      title: l10n.budgetFormTitle,
      body: l10n.budgetsBody,
      icon: Icons.add_chart_rounded,
      children: [
        FeloInput(label: l10n.budgetsTitle),
        const SizedBox(height: 12),
        FeloInput(label: l10n.currencyCad),
        const SizedBox(height: 12),
        SwitchListTile.adaptive(
          value: true,
          onChanged: (_) {},
          title: Text(l10n.budgetRollover),
        ),
        const SizedBox(height: 12),
        FeloButton(label: l10n.commonSave, onPressed: () {}),
      ],
    );
  }
}
