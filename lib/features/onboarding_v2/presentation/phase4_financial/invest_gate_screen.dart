import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/option_card.dart';

/// **FR-4.3.1 + FR-4.3.2** — Do you invest? Yes / No gate.
class InvestGateScreen extends ConsumerStatefulWidget {
  const InvestGateScreen({super.key});

  @override
  ConsumerState<InvestGateScreen> createState() => _InvestGateScreenState();
}

class _InvestGateScreenState extends ConsumerState<InvestGateScreen>
    with OnboardingAnalyticsMixin<InvestGateScreen> {
  @override
  int get phase => 4;

  @override
  String get stepId => 'phase4_step3';

  @override
  String get frdId => 'FR-4.3.1';

  Future<void> _select(bool invests) async {
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(invests: invests),
        );
    await onContinue({'invests': invests});
    if (!mounted) return;
    if (invests) {
      context.go('/onboarding-v2/invest-types');
    } else {
      context.go('/onboarding-v2/budget');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      title: 'Do you invest?',
      currentStep: 9,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/accounts');
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'Stocks, crypto, gold, real estate, bonds — anything counts.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 28),
          OptionCard(
            icon: Icons.trending_up_rounded,
            label: 'Yes, I invest',
            subtitle: "We'll show you investment widgets on your dashboard.",
            onTap: () => _select(true),
          ),
          const SizedBox(height: 12),
          OptionCard(
            icon: Icons.savings_outlined,
            label: 'Not yet',
            subtitle: "Skip the investment questions and stay focused on budgets.",
            onTap: () => _select(false),
          ),
        ],
      ),
    );
  }
}
