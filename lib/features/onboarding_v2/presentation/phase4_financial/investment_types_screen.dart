import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/pill_multiselect.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-4.4.1 + FR-4.4.2** — What do you invest in? (multi-select pills)
class InvestmentTypesScreen extends ConsumerStatefulWidget {
  const InvestmentTypesScreen({super.key});

  @override
  ConsumerState<InvestmentTypesScreen> createState() =>
      _InvestmentTypesScreenState();
}

class _InvestmentTypesScreenState extends ConsumerState<InvestmentTypesScreen>
    with OnboardingAnalyticsMixin<InvestmentTypesScreen> {
  @override
  int get phase => 4;

  @override
  String get stepId => 'phase4_step4';

  @override
  String get frdId => 'FR-4.4.1';

  Set<String> _selected = {};

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    _selected = (stored?.investmentTypes ?? const []).toSet();
  }

  static String _label(String slug) {
    return switch (slug) {
      'stocks' => 'Stocks',
      'mutual_funds' => 'Mutual Funds',
      'crypto' => 'Crypto',
      'gold' => 'Gold',
      'real_estate' => 'Real Estate',
      'bonds_sukuk' => 'Bonds / Sukuk',
      'other' => 'Other',
      _ => slug,
    };
  }

  static IconData _icon(String slug) {
    return switch (slug) {
      'stocks' => Icons.show_chart_rounded,
      'mutual_funds' => Icons.pie_chart_outline_rounded,
      'crypto' => Icons.currency_bitcoin_rounded,
      'gold' => Icons.workspace_premium_rounded,
      'real_estate' => Icons.home_work_outlined,
      'bonds_sukuk' => Icons.account_balance_wallet_outlined,
      'other' => Icons.more_horiz_rounded,
      _ => Icons.candlestick_chart_outlined,
    };
  }

  Future<void> _continue() async {
    if (_selected.isEmpty) {
      await onValidationError('no_selection');
      return;
    }
    await ref
        .read(onboardingStateControllerProvider.notifier)
        .patch((s) => s.copyWith(investmentTypes: _selected.toList()));
    await onContinue({'types': _selected.toList()});
    if (!mounted) return;
    context.go('/onboarding-v2/budget');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final types =
        (config?['investment_types'] as List<dynamic>?)
            ?.map((e) => e['slug'].toString())
            .toList() ??
        [
          'stocks',
          'mutual_funds',
          'crypto',
          'gold',
          'real_estate',
          'bonds_sukuk',
          'other',
        ];

    return OnboardingShell(
      title: 'What do you invest in?',
      currentStep: 10,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/invest-gate');
      },
      bottomActions: FeloButton(
        label: 'Continue',
        onPressed: _selected.isEmpty ? null : _continue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'Pick all that apply. We use this to show the right widgets.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          PillMultiselect<String>(
            options: types,
            selectedValues: _selected,
            onChanged: (next) => setState(() => _selected = next),
            labelOf: _label,
            iconOf: _icon,
          ),
        ],
      ),
    );
  }
}
