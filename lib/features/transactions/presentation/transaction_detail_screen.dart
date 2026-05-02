import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/transactions/data/transactions_repository.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';

class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({required this.transactionId, super.key});

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final txnsAsync = ref.watch(transactionsProvider);
    return txnsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Could not load transaction: $error')),
      ),
      data: (transactions) {
        final match = transactions.where((t) => t.id == transactionId);
        if (match.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Transaction not found')),
          );
        }
        final transaction = match.first;
        return FeloFeaturePlaceholder(
          title: l10n.transactionDetailTitle,
          body: l10n.transactionsBody,
          icon: Icons.receipt_long_rounded,
          children: [
            Text(
              transaction.merchant,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
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
            const SizedBox(height: 10),
            if (transaction.receiptId != null) Text(l10n.receiptAttached),
            if (transaction.receiptId != null) const SizedBox(height: 10),
            FeloButton(
              label: l10n.receiptCaptureTitle,
              icon: Icons.photo_camera_outlined,
              variant: FeloButtonVariant.secondary,
              onPressed: () =>
                  context.go('/transactions/${transaction.id}/receipt'),
            ),
          ],
        );
      },
    );
  }
}
