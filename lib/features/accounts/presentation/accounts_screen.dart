import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/accounts/data/accounts_repository.dart';
import 'package:felo/features/accounts/domain/felo_account.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_bottom_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final accountsAsync = ref.watch(accountsProvider);

    return FeloScaffold(
      title: l10n.accountsTitle,
      selectedTab: FeloRootTab.home,
      actions: [
        IconButton(
          tooltip: l10n.accountsConnect,
          onPressed: () {
            ref.read(accountConnectFlowProvider.notifier).reset();
            context.go('/accounts/connect');
          },
          icon: const Icon(Icons.add_link_rounded),
        ),
      ],
      child: accountsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(20),
          child: FeloEmptyState(
            title: 'Could not load accounts',
            body: error.toString(),
          ),
        ),
        data: (accounts) => accounts.isEmpty
            ? FeloEmptyState(
                title: l10n.accountsEmptyTitle,
                body: l10n.accountsEmptyBody,
                actionLabel: l10n.accountsConnect,
                onAction: () {
                  ref.read(accountConnectFlowProvider.notifier).reset();
                  context.go('/accounts/connect');
                },
              )
            : RefreshIndicator(
                onRefresh: () =>
                    ref.read(accountsProvider.notifier).refresh(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    return _AccountCard(
                      account: account,
                      onDisconnect: () {
                        _showDisconnectSheet(context, ref, account);
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: accounts.length,
                ),
              ),
      ),
    );
  }

  Future<void> _showDisconnectSheet(
    BuildContext context,
    WidgetRef ref,
    FeloAccount account,
  ) {
    final l10n = context.l10n;
    return showFeloBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.accountsDisconnectTitle,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(l10n.accountsDisconnectBody(account.displayName)),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.accountsDisconnect,
                icon: Icons.link_off_rounded,
                onPressed: () async {
                  await ref
                      .read(accountsProvider.notifier)
                      .disconnect(account.id);
                  if (sheetContext.mounted) {
                    Navigator.of(sheetContext).pop();
                  }
                },
              ),
              const SizedBox(height: 10),
              FeloButton(
                label: l10n.commonCancel,
                variant: FeloButtonVariant.ghost,
                onPressed: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.account, required this.onDisconnect});

  final FeloAccount account;
  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final materialLocalizations = MaterialLocalizations.of(context);
    final timestamp = l10n.accountsLastSynced(
      materialLocalizations.formatShortDate(account.lastSyncedAt),
      materialLocalizations.formatTimeOfDay(
        TimeOfDay.fromDateTime(account.lastSyncedAt),
      ),
    );

    return FeloCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(_providerIcon(account.provider)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        account.displayName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.accountsDisconnect,
                      onPressed: onDisconnect,
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FeloChip(label: _typeLabel(context, account.type)),
                    FeloChip(label: _statusLabel(context, account.syncStatus)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(timestamp, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10),
                Text(
                  formatMinorMoney(
                    minor: account.balanceMinor,
                    currency: account.currency,
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _providerIcon(FeloAccountProvider provider) {
    return switch (provider) {
      FeloAccountProvider.td => Icons.account_balance_outlined,
      FeloAccountProvider.rbc => Icons.credit_card_outlined,
      FeloAccountProvider.easypaisa => Icons.account_balance_wallet_outlined,
      FeloAccountProvider.jazzcash => Icons.wallet_outlined,
      FeloAccountProvider.manual => Icons.edit_note_outlined,
    };
  }

  String _typeLabel(BuildContext context, FeloAccountType type) {
    final l10n = context.l10n;
    return switch (type) {
      FeloAccountType.bank => l10n.accountsTypeBank,
      FeloAccountType.card => l10n.accountsTypeCard,
      FeloAccountType.wallet => l10n.accountsTypeWallet,
    };
  }

  String _statusLabel(BuildContext context, FeloAccountSyncStatus status) {
    final l10n = context.l10n;
    return switch (status) {
      FeloAccountSyncStatus.synced => l10n.accountsStatusSynced,
      FeloAccountSyncStatus.syncing => l10n.accountsStatusSyncing,
      FeloAccountSyncStatus.needsReview => l10n.accountsStatusNeedsReview,
    };
  }
}
