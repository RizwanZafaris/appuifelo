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

class _FamilyRemittanceScreenState extends ConsumerState<FamilyRemittanceScreen>
    with OnboardingAnalyticsMixin<FamilyRemittanceScreen> {
  @override
  int get phase => 6;

  @override
  String get stepId => 'phase6_step1';

  @override
  String get frdId => 'FR-6.1.1';

  Set<String> _selected = {};

  /// Audit §10 — when "support_financially" or "manage_household" is
  /// selected, ask whether it's local or cross-border. Only cross-border
  /// triggers the corridor screen. Local routes straight to personalize
  /// (the support shows up as a budget category instead).
  bool? _supportIsCrossBorder;

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    _selected = (stored?.remittanceOptions ?? const []).toSet();
  }

  bool get _needsLocalCrossBorderQuestion {
    if (_selected.contains('none')) return false;
    if (_selected.contains('send_regularly'))
      return false; // implicitly cross-border
    if (_selected.contains('receive_abroad'))
      return false; // implicitly cross-border
    return _selected.contains('support_financially') ||
        _selected.contains('manage_household');
  }

  /// D-023 truth table + Audit §10 local-vs-cross-border refinement.
  /// Returns true iff Phase 6.2 (corridor) should fire.
  ///
  /// Decision tree:
  ///   "none"                       → false
  ///   "send_regularly" present     → true  (implicitly cross-border)
  ///   "receive_abroad" present     → true  (implicitly cross-border)
  ///   "support" / "manage" only    → ask user; only cross-border fires
  bool _shouldFireStep2({
    required Set<String> selections,
    required bool? supportIsCrossBorder,
  }) {
    if (selections.contains('none')) return false;
    if (selections.contains('send_regularly')) return true;
    if (selections.contains('receive_abroad')) return true;

    // Support / manage household — defer to user's local-vs-cross-border
    // answer. If they said local → skip corridor; cross-border → fire.
    final hasSupport = selections.contains('support_financially');
    final hasManage = selections.contains('manage_household');
    if (hasSupport || hasManage) {
      return supportIsCrossBorder ?? false;
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
    // Audit §10 — if user selected support/manage but didn't answer
    // local-vs-cross-border, prompt them inline first.
    if (_needsLocalCrossBorderQuestion && _supportIsCrossBorder == null) {
      await onValidationError('local_or_cross_border_required');
      // Build will render the inline question; no nav.
      setState(() {});
      return;
    }
    final fireStep2 = _shouldFireStep2(
      selections: _selected,
      supportIsCrossBorder: _supportIsCrossBorder,
    );
    await ref
        .read(onboardingStateControllerProvider.notifier)
        .patch((s) => s.copyWith(remittanceOptions: _selected.toList()));
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
    final options =
        (config?['family_remittance_options'] as List<dynamic>?)
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
          if (_needsLocalCrossBorderQuestion) ...[
            const SizedBox(height: 14),
            Text(
              'Is this within your country, or across borders?',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _LocalCrossBorderChip(
                    label: 'Within my country',
                    selected: _supportIsCrossBorder == false,
                    onTap: () => setState(() => _supportIsCrossBorder = false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _LocalCrossBorderChip(
                    label: 'Across borders',
                    selected: _supportIsCrossBorder == true,
                    onTap: () => setState(() => _supportIsCrossBorder = true),
                  ),
                ),
              ],
            ),
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

/// Audit §10 — local-vs-cross-border picker chip used inline when the
/// user selected "support" or "manage household" without an explicit
/// remittance signal. Local → no corridor; cross-border → corridor screen.
class _LocalCrossBorderChip extends StatelessWidget {
  const _LocalCrossBorderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outlineVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: selected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
