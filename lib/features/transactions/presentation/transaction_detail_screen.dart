import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';

class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({required this.transactionId, super.key});

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final transaction = ref
        .watch(transactionsProvider)
        .firstWhere((item) => item.id == transactionId);
    return FeloFeaturePlaceholder(
      title: l10n.transactionDetailTitle,
      body: l10n.transactionsBody,
      icon: Icons.receipt_long_rounded,
      children: [
        Text(
          transaction.merchant,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          formatMinorMoney(
            minor: transaction.amountMinor,
            currency: transaction.currency,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        FeloButton(label: l10n.transactionRecategorize, onPressed: () {}),
        const SizedBox(height: 10),
        FeloButton(
          label: l10n.transactionSplit,
          variant: FeloButtonVariant.secondary,
          onPressed: () {},
        ),
      ],
    );
  }
}
