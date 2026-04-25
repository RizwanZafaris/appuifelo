import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/option_card.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-6.1.1..3** — Family & remittances multi-select with D-023 truth
/// table evaluation deciding whether to fire FR-6.2 (corridor).
class FamilyRemittanceScreen extends ConsumerStatefulWidget {
  const FamilyRemittanceScreen({super.key});

  @override
  ConsumerState<FamilyRemittanceScreen> createState() =>
      _FamilyRemittanceScreenState();
}

class _FamilyRemittanceScreenState
    extends ConsumerState<FamilyRemittanceScreen>
    with OnboardingAnalyticsMixin<FamilyRemittanceScreen> {
  @override
  int get phase => 6;

  @override
  String get stepId => 'phase6_step1';

  @override
  String get frdId => 'FR-6.1.1';

  Set<String> _selected = {};

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    _selected = (stored?.remittanceOptions ?? const []).toSet();
  }

  /// D-023 truth table — returns true iff Phase 6.2 should fire.
  bool _shouldFireStep2({
    required Set<String> selections,
    required String? primary,
    required Set<String> secondary,
  }) {
    if (selections.contains('none')) return false;

    final hasSendRegularly = selections.contains('send_regularly');
    final hasReceiveAbroad = selections.contains('receive_abroad');
    final hasSupport = selections.contains('support_financially');
    final hasManageHousehold = selections.contains('manage_household');

    if (hasSendRegularly) return true;
    if (hasReceiveAbroad) return true;

    // "Support" only with cross-border secondary regions → fire defensively.
    if (hasSupport && secondary.isNotEmpty) {
      // Treat any secondary as a corridor signal.
      return true;
    }

    // "Manage household" / "Support" only without secondary → skip.
    if (hasManageHousehold && !hasSendRegularly && !hasReceiveAbroad) {
      return false;
    }

    return false;
  }

  void _toggle(String slug) {
    setState(() {
      if (slug == 'none') {
        _selected = {'none'};
        return;
      }
      _selected.remove('none');
      if (_selected.contains(slug)) {
        _selected.remove(slug);
      } else {
        _selected.add(slug);
      }
    });
  }

  Future<void> _continue() async {
    if (_selected.isEmpty) {
      await onValidationError('no_selection');
      return;
    }
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    final fireStep2 = _shouldFireStep2(
      selections: _selected,
      primary: stored?.primaryRegion,
      secondary: stored?.secondaryRegions.toSet() ?? {},
    );
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(remittanceOptions: _selected.toList()),
        );
    await onContinue({
      'options': _selected.toList(),
      'step2_will_fire': fireStep2,
    });
    if (!mounted) return;
    if (fireStep2) {
      context.go('/onboarding-v2/corridor');
    } else {
      context.go('/onboarding-v2/personalize');
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final options = (config?['family_remittance_options'] as List<dynamic>?)
            ?.map((e) => e['slug'].toString())
            .toList() ??
        const [
          'send_regularly',
          'receive_abroad',
          'support_financially',
          'manage_household',
          'none',
        ];

    return OnboardingShell(
      title: 'Family & remittances',
      currentStep: 14,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/goal-detail/2');
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
            'Pick all that apply.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'This helps us show the right corridor for you.',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(height: 20),
          for (final slug in options) ...[
            OptionCard(
              icon: _icon(slug),
              label: _label(slug),
              selected: _selected.contains(slug),
              onTap: () => _toggle(slug),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  static String _label(String slug) {
    return switch (slug) {
      'send_regularly' => 'I send money to family regularly',
      'receive_abroad' => 'I receive money from abroad',
      'support_financially' => 'I support family members financially',
      'manage_household' => 'I manage shared household expenses',
      'none' => 'None of the above',
      _ => slug,
    };
  }

  static IconData _icon(String slug) {
    return switch (slug) {
      'send_regularly' => Icons.arrow_upward_rounded,
      'receive_abroad' => Icons.arrow_downward_rounded,
      'support_financially' => Icons.volunteer_activism_outlined,
      'manage_household' => Icons.house_outlined,
      'none' => Icons.do_not_disturb_on_outlined,
      _ => Icons.help_outline_rounded,
    };
  }
}
