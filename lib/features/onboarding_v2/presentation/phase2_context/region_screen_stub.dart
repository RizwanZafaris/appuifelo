import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **E2 stub** — Phase 2 Region screen placeholder.
///
/// Full implementation lands in the next sub-checkpoint (FR-2.1.0 IP
/// resolver + FR-2.1.1 confirm region card + FR-2.1.3 add secondary
/// region sheet). For now, this stub fires the right analytics event
/// so the funnel works end-to-end on a happy-path walkthrough.
class RegionScreenStub extends ConsumerStatefulWidget {
  const RegionScreenStub({super.key});

  @override
  ConsumerState<RegionScreenStub> createState() => _RegionScreenStubState();
}

class _RegionScreenStubState extends ConsumerState<RegionScreenStub>
    with OnboardingAnalyticsMixin<RegionScreenStub> {
  @override
  int get phase => 2;

  @override
  String get stepId => 'phase2_step1';

  @override
  String get frdId => 'FR-2.1.1';

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      title: 'Where are you?',
      currentStep: 4,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/signup-method');
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.public_rounded,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Phase 2 — region detection ships in the next sub-checkpoint.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'FR-2.1.0 (IP resolver), FR-2.1.1 (confirm card), FR-2.1.3 (add secondary)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FeloButton(
            label: 'Continue (stub)',
            onPressed: () async {
              await onContinue({'stub': true});
              if (!mounted) return;
              // For now, route back to legacy home so the v2 flow doesn't
              // dead-end. When E2-E8 ship, this becomes the proper next step.
              context.go('/');
            },
          ),
        ],
      ),
    );
  }
}
