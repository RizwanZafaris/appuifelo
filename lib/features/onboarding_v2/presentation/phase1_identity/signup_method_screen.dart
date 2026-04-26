import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/option_card.dart';

/// **FR-1.2.1** — Sign-up method picker.
///
/// 5 stacked method cards. Apple is iOS-only (hidden on Android/Web).
/// OAuth methods complete in 1 tap (Phase 2 follows directly). Email
/// and Mobile both flow into the OTP screen (FR-1.3.1).
///
/// OAuth handler integration with Supabase Auth happens in the
/// follow-up sub-checkpoint when Google/Apple/Facebook are configured
/// in the Supabase dashboard. For E1 we ship the UI + analytics +
/// routing scaffold; the actual OAuth call is a TODO that the next
/// commit closes.
class SignupMethodScreen extends ConsumerStatefulWidget {
  const SignupMethodScreen({super.key});

  @override
  ConsumerState<SignupMethodScreen> createState() => _SignupMethodScreenState();
}

class _SignupMethodScreenState extends ConsumerState<SignupMethodScreen>
    with OnboardingAnalyticsMixin<SignupMethodScreen> {
  @override
  int get phase => 1;

  @override
  String get stepId => 'phase1_step2';

  @override
  String get frdId => 'FR-1.2.1';

  bool get _appleAvailable {
    if (kIsWeb) return false;
    return Platform.isIOS || Platform.isMacOS;
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(onboardingConfigProvider);
    final strings =
        configAsync.valueOrNull?['strings'] as Map<String, dynamic>?;

    String s(String key, String fallback) =>
        strings?[key]?.toString() ?? fallback;

    return OnboardingShell(
      title: 'Create your account',
      currentStep: 2,
      totalSteps: 14, // domestic-only baseline; recalculates dynamically later
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2');
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'Pick how you want to sign up.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          OptionCard(
            icon: Icons.g_mobiledata_rounded,
            label: s('signup.with_google', 'Continue with Google'),
            onTap: () => _onMethodSelected('google'),
          ),
          const SizedBox(height: 12),
          if (_appleAvailable)
            OptionCard(
              icon: Icons.apple_rounded,
              label: s('signup.with_apple', 'Continue with Apple'),
              onTap: () => _onMethodSelected('apple'),
            ),
          if (_appleAvailable) const SizedBox(height: 12),
          OptionCard(
            icon: Icons.facebook_rounded,
            label: s('signup.with_facebook', 'Continue with Facebook'),
            onTap: () => _onMethodSelected('facebook'),
          ),
          const SizedBox(height: 12),
          OptionCard(
            icon: Icons.email_outlined,
            label: s('signup.with_email', 'Continue with Email'),
            onTap: () => _onMethodSelected('email'),
          ),
          const SizedBox(height: 12),
          OptionCard(
            icon: Icons.phone_outlined,
            label: s('signup.with_mobile', 'Continue with Mobile'),
            onTap: () => _onMethodSelected('mobile'),
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () => context.go('/auth'),
              child: const Text('I already have an account → Sign in'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onMethodSelected(String method) async {
    // FR-1.2.2..6 — fire `signup_method_selected` event with the chosen
    // method. OAuth (google/apple/facebook) completes in 1 tap → jump
    // to Phase 2. Email/Mobile go via OTP screen.
    await ref
        .read(onboardingAnalyticsServiceProvider.notifier)
        .fire(
          CanonicalEvent(
            eventName: 'signup_method_selected',
            frdId: frdId,
            stepId: stepId,
            phase: phase,
            sessionId: OnboardingAnalyticsMixin.sessionId,
            occurredAt: DateTime.now(),
            properties: {'method': method},
          ),
        );

    if (!mounted) return;

    switch (method) {
      case 'google':
      case 'apple':
      case 'facebook':
        // OAuth — actual Supabase Auth call wires in next sub-checkpoint
        // when providers are configured in the Supabase dashboard.
        // For now: stub navigates to Phase 2 with the method recorded.
        // TODO(E1.OAuth): invoke ref.read(supabaseClientProvider).auth.signInWithOAuth(...)
        await onContinue({'method': method});
        if (!mounted) return;
        context.go('/onboarding-v2/region');
        break;
      case 'email':
      case 'mobile':
        await onContinue({'method': method});
        if (!mounted) return;
        context.go('/onboarding-v2/otp', extra: method);
        break;
    }
  }
}
