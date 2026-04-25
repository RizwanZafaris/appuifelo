import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/pill_multiselect.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_input.dart';

/// **FR-4.1.1..3** — How do you earn? (multi-select pills)
class EarningTypeScreen extends ConsumerStatefulWidget {
  const EarningTypeScreen({super.key});

  @override
  ConsumerState<EarningTypeScreen> createState() => _EarningTypeScreenState();
}

class _EarningTypeScreenState extends ConsumerState<EarningTypeScreen>
    with OnboardingAnalyticsMixin<EarningTypeScreen> {
  @override
  int get phase => 4;

  @override
  String get stepId => 'phase4_step1';

  @override
  String get frdId => 'FR-4.1.1';

  Set<String> _selected = {};
  String _customValue = '';

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    _selected = (stored?.earningTypes ?? const []).toSet();
    _customValue = stored?.earningTypeCustom ?? '';
  }

  static String _label(String slug) {
    return switch (slug) {
      'salaried' => 'Salaried',
      'freelancer' => 'Freelancer',
      'business_owner' => 'Business owner',
      'investor' => 'Investor',
      'finance_professional' => 'Finance professional',
      'student' => 'Student',
      'homemaker' => 'Homemaker',
      'other' => 'Other',
      _ => slug,
    };
  }

  static IconData _icon(String slug) {
    return switch (slug) {
      'salaried' => Icons.business_center_outlined,
      'freelancer' => Icons.laptop_mac_outlined,
      'business_owner' => Icons.storefront_outlined,
      'investor' => Icons.show_chart_outlined,
      'finance_professional' => Icons.account_balance_outlined,
      'student' => Icons.school_outlined,
      'homemaker' => Icons.home_outlined,
      'other' => Icons.more_horiz_rounded,
      _ => Icons.work_outline_rounded,
    };
  }

  Future<void> _continue() async {
    if (_selected.isEmpty) {
      await onValidationError('no_selection');
      return;
    }
    if (_selected.contains('other') && _customValue.trim().isEmpty) {
      await onValidationError('other_empty');
      return;
    }
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(
            earningTypes: _selected.toList(),
            earningTypeCustom:
                _selected.contains('other') ? _customValue.trim() : null,
          ),
        );
    await onContinue({
      'types': _selected.toList(),
      'custom_value': _selected.contains('other'),
    });
    if (!mounted) return;
    context.go('/onboarding-v2/accounts');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final earningTypes = (config?['earning_types'] as List<dynamic>?)
            ?.map((e) => e['slug'].toString())
            .toList() ??
        [
          'salaried',
          'freelancer',
          'business_owner',
          'investor',
          'finance_professional',
          'student',
          'homemaker',
          'other',
        ];

    return OnboardingShell(
      title: 'How do you earn?',
      currentStep: 7,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/permissions');
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
            'Pick all that apply. Real life is hybrid — feel free to choose more than one.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "We use this to suggest budget categories.",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(height: 20),
          PillMultiselect<String>(
            options: earningTypes,
            selectedValues: _selected,
            onChanged: (next) => setState(() => _selected = next),
            labelOf: _label,
            iconOf: _icon,
          ),
          if (_selected.contains('other')) ...[
            const SizedBox(height: 16),
            FeloInput(
              label: 'Tell us a bit more',
              onChanged: (v) => setState(() => _customValue = v),
            ),
          ],
        ],
      ),
    );
  }
}
