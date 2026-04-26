import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/shared/validation/validators.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_input.dart';

/// **FR-2.2.1 + FR-2.2.2** — Name input screen.
class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen>
    with OnboardingAnalyticsMixin<NameScreen> {
  @override
  int get phase => 2;

  @override
  String get stepId => 'phase2_step2';

  @override
  String get frdId => 'FR-2.2.1';

  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(onboardingStateControllerProvider).valueOrNull?.name ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Audit §3 — centralized validator: rejects digits/emoji/symbols,
    // collapses double spaces, accepts Unicode letters across scripts.
    final result = Validators.personalName(_controller.text);
    if (result.error != null) {
      setState(() => _error = result.error);
      await onValidationError(_classifyNameError(result.error!));
      return;
    }
    final name = result.normalized!;
    setState(() => _error = null);
    await ref
        .read(onboardingStateControllerProvider.notifier)
        .patch((s) => s.copyWith(name: name));
    await onContinue();
    if (!mounted) return;
    context.go('/onboarding-v2/permissions');
  }

  String _classifyNameError(String msg) {
    if (msg.contains('Enter')) return 'empty';
    if (msg.contains('too short')) return 'too_short';
    if (msg.contains('too long')) return 'too_long';
    if (msg.contains('letters')) return 'invalid_chars';
    return 'other';
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      title: 'What should we call you?',
      currentStep: 5,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/region');
      },
      bottomActions: FeloButton(label: 'Continue', onPressed: _submit),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Text(
            "Just a first name is fine — it's how the app will greet you.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FeloInput(
            label: 'Your name',
            controller: _controller,
            errorText: _error,
            autofocus: true,
          ),
        ],
      ),
    );
  }
}
