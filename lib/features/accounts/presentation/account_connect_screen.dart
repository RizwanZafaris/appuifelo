import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/accounts/domain/felo_account.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class AccountConnectScreen extends ConsumerWidget {
  const AccountConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(accountConnectFlowProvider);
    final flow = ref.read(accountConnectFlowProvider.notifier);

    return FeloScaffold(
      title: l10n.accountsConnectTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          switch (state) {
            AccountConnectPicker() => _ProviderPicker(
              onSelected: flow.selectProvider,
            ),
            AccountConnectOAuth(:final provider) => _MockOAuthStep(
              provider: provider,
              onBack: flow.reset,
              onContinue: flow.complete,
            ),
            AccountConnectSuccess(:final account) => _SuccessStep(
              accountName: account.displayName,
              onViewAccounts: () => context.go('/accounts'),
            ),
          },
        ],
      ),
    );
  }
}

class _ProviderPicker extends StatelessWidget {
  const _ProviderPicker({required this.onSelected});

  final ValueChanged<FeloAccountProvider> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.accountsProviderPickerTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        for (final provider in FeloAccountProvider.values) ...[
          FeloCard(
            onTap: () => onSelected(provider),
            child: Row(
              children: [
                Icon(_providerIcon(provider)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _providerLabel(context, provider),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _MockOAuthStep extends StatelessWidget {
  const _MockOAuthStep({
    required this.provider,
    required this.onBack,
    required this.onContinue,
  });

  final FeloAccountProvider provider;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(_providerIcon(provider), size: 48),
          const SizedBox(height: 16),
          Text(
            l10n.accountsMockOAuthTitle(_providerLabel(context, provider)),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(l10n.accountsMockOAuthBody, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          FeloButton(
            label: l10n.accountsConnectContinue,
            icon: Icons.lock_open_rounded,
            onPressed: onContinue,
          ),
          const SizedBox(height: 10),
          FeloButton(
            label: l10n.commonBack,
            variant: FeloButtonVariant.ghost,
            onPressed: onBack,
          ),
        ],
      ),
    );
  }
}

class _SuccessStep extends StatelessWidget {
  const _SuccessStep({required this.accountName, required this.onViewAccounts});

  final String accountName;
  final VoidCallback onViewAccounts;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 56,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.accountsConnectSuccessTitle,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.accountsConnectSuccessBody(accountName),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FeloButton(
            label: l10n.accountsViewAccounts,
            onPressed: onViewAccounts,
          ),
        ],
      ),
    );
  }
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

String _providerLabel(BuildContext context, FeloAccountProvider provider) {
  final l10n = context.l10n;
  return switch (provider) {
    FeloAccountProvider.td => l10n.accountsProviderTd,
    FeloAccountProvider.rbc => l10n.accountsProviderRbc,
    FeloAccountProvider.easypaisa => l10n.accountsProviderEasypaisa,
    FeloAccountProvider.jazzcash => l10n.accountsProviderJazzcash,
    FeloAccountProvider.manual => l10n.accountsProviderManual,
  };
}
