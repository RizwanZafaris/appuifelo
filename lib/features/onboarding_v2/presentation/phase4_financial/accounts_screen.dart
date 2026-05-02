import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/pill_multiselect.dart';
import 'package:felo/shared/widgets/felo_button.dart';

class _AccountChoice {
  const _AccountChoice({
    required this.kind,
    required this.slug,
    required this.name,
    required this.regionIso2,
    required this.icon,
  });

  final String kind; // 'bank' | 'wallet'
  final String slug;
  final String name;
  final String regionIso2;
  final IconData icon;

  String get key => '$regionIso2.$kind.$slug';
}

/// **FR-4.2.1..4** — Where do you keep money?
///
/// Region-filtered banks + wallets list (D-016). Toggle reveals
/// secondary-region banks. Footer link defers entirely (D-017).
class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({super.key});

  @override
  ConsumerState<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends ConsumerState<AccountsScreen>
    with OnboardingAnalyticsMixin<AccountsScreen> {
  @override
  int get phase => 4;

  @override
  String get stepId => 'phase4_step2';

  @override
  String get frdId => 'FR-4.2.1';

  Set<String> _selectedKeys = {};
  bool _showSecondary = false;
  String _query = '';

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    _selectedKeys = (stored?.accounts ?? const [])
        .map((a) => '${a.regionIso2}.${a.accountKind}.${a.providerSlug}')
        .toSet();
  }

  List<_AccountChoice> _choicesFor(
    Map<String, dynamic>? config,
    String? primary,
    Set<String> secondary,
  ) {
    if (config == null || primary == null) return const [];
    final regions = <String>{primary};
    if (_showSecondary) regions.addAll(secondary);

    final banksByRegion =
        config['banks_by_region'] as Map<String, dynamic>? ?? {};
    final walletsByRegion =
        config['wallets_by_region'] as Map<String, dynamic>? ?? {};

    final out = <_AccountChoice>[];
    for (final iso2 in regions) {
      final banks = banksByRegion[iso2] as List<dynamic>? ?? [];
      for (final b in banks) {
        out.add(
          _AccountChoice(
            kind: 'bank',
            slug: b['slug'].toString(),
            name: b['name'].toString(),
            regionIso2: iso2,
            icon: Icons.account_balance_outlined,
          ),
        );
      }
      final wallets = walletsByRegion[iso2] as List<dynamic>? ?? [];
      for (final w in wallets) {
        out.add(
          _AccountChoice(
            kind: 'wallet',
            slug: w['slug'].toString(),
            name: w['name'].toString(),
            regionIso2: iso2,
            icon: Icons.account_balance_wallet_outlined,
          ),
        );
      }
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      return out
          .where(
            (c) =>
                c.name.toLowerCase().contains(q) ||
                c.slug.toLowerCase().contains(q),
          )
          .toList();
    }
    return out;
  }

  Future<void> _continue({bool deferred = false}) async {
    if (!deferred && _selectedKeys.isEmpty) {
      await onValidationError('no_selection');
      return;
    }
    final selectedAccounts = deferred
        ? <OnboardingAccount>[]
        : _selectedKeys.map((key) {
            final parts = key.split('.');
            return OnboardingAccount(
              regionIso2: parts[0],
              accountKind: parts[1],
              providerSlug: parts[2],
            );
          }).toList();
    await ref
        .read(onboardingStateControllerProvider.notifier)
        .patch(
          (s) => s.copyWith(
            accounts: selectedAccounts,
            accountsDeferred: deferred,
          ),
        );
    await onContinue({'count': selectedAccounts.length, 'deferred': deferred});
    if (!mounted) return;
    context.go('/onboarding-v2/invest-gate');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final stored = ref.watch(onboardingStateControllerProvider).valueOrNull;
    final primary = stored?.primaryRegion;
    final secondary = stored?.secondaryRegions.toSet() ?? {};
    final choices = _choicesFor(config, primary, secondary);
    final hasSecondary = secondary.isNotEmpty;

    return OnboardingShell(
      title: 'Where do you keep money?',
      currentStep: 8,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/earning-type');
      },
      bottomActions: FeloButton(
        label: 'Continue',
        onPressed: _selectedKeys.isEmpty ? null : () => _continue(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'Pick all that apply. You can add more later.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "We use this to organize your dashboard. We don't access your bank yet.",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          if (choices.length > 8)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Search banks and wallets',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
          if (hasSecondary)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SwitchListTile.adaptive(
                value: _showSecondary,
                onChanged: (v) => setState(() => _showSecondary = v),
                contentPadding: EdgeInsets.zero,
                title: const Text('Show banks from my secondary regions'),
              ),
            ),
          PillMultiselect<_AccountChoice>(
            options: choices,
            selectedValues: choices
                .where((c) => _selectedKeys.contains(c.key))
                .toSet(),
            onChanged: (next) {
              setState(() {
                _selectedKeys = next.map((c) => c.key).toSet();
              });
            },
            labelOf: (c) => c.name,
            iconOf: (c) => c.icon,
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton.icon(
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text("I'll add accounts later"),
              onPressed: () => _continue(deferred: true),
            ),
          ),
        ],
      ),
    );
  }
}
