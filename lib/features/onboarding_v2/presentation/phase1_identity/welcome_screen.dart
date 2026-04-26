import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-1.1.1** — Welcome screen.
///
/// First screen of the v2 journey. Renders hero/subtitle/CTAs from
/// `journey-config.strings` (D-029) — no hardcoded copy.
///
/// Analytics:
/// - `welcome_viewed` (auto-fired by mixin on initState)
/// - `welcome_cta_tapped` (manual, on Get Started tap)
/// - `welcome_signin_link_tapped` (manual, on Sign in tap)
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with OnboardingAnalyticsMixin<WelcomeScreen> {
  @override
  int get phase => 0;

  @override
  String get stepId => 'welcome';

  @override
  String get frdId => 'FR-1.1.1';

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(onboardingConfigProvider);
    final strings = configAsync.valueOrNull?['strings'] as Map<String, dynamic>?;

    String s(String key, String fallback) =>
        strings?[key]?.toString() ?? fallback;

    final hero = s('welcome.hero', 'Your money, simply seen.');
    final subtitle = s(
      'welcome.subtitle',
      'Track every rupee, every wallet, every bank — in one app.',
    );
    final cta = s('welcome.cta', 'Get started');
    final signinLink = s(
      'welcome.signin_link',
      'I already have an account → Sign in',
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              // Hero illustration / brand mark — Stitch design system
              // ships the real asset; for E0 we use the brand teal accent.
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: FeloColors.mintBase.withValues(alpha: 0.4),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 64,
                  color: FeloColors.feloiTeal,
                ),
              ),
              const SizedBox(height: 36),
              Text(
                hero,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 14),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const Spacer(flex: 3),
              FeloButton(
                label: cta,
                onPressed: () async {
                  await onContinue();
                  if (!mounted) return;
                  context.go('/onboarding-v2/signup-method');
                },
              ),
              const SizedBox(height: 14),
              TextButton(
                onPressed: () {
                  // Sign-in link — fires analytics + routes to existing
                  // auth screen. The legacy /auth route remains the
                  // sign-in entry until v2 ships its own.
                  ref
                      .read(onboardingAnalyticsServiceProvider.notifier)
                      .fire(
                        CanonicalEvent(
                          eventName: 'welcome_signin_link_tapped',
                          frdId: frdId,
                          stepId: stepId,
                          phase: phase,
                          sessionId: OnboardingAnalyticsMixin.sessionId,
                          occurredAt: DateTime.now(),
                        ),
                      );
                  context.go('/auth');
                },
                child: Text(signinLink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
