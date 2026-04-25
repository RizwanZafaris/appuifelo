import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final transactions = ref.watch(transactionsProvider);
    return FeloScaffold(
      title: l10n.transactionsTitle,
      selectedTab: FeloRootTab.activity,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.transactionsBody),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FeloChip(label: l10n.commonSearch, icon: Icons.search_rounded),
              FeloChip(label: l10n.budgetsTitle, icon: Icons.category_outlined),
              FeloChip(label: l10n.navActivity, icon: Icons.date_range_rounded),
            ],
          ),
          const SizedBox(height: 16),
          for (final transaction in transactions) ...[
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
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
