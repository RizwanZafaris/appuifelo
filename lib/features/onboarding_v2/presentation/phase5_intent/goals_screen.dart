import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/goal_card.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-5.2.1 + FR-5.2.2** — Goals card grid (D-008 hard limit: exactly 2).
///
/// Tapping a 3rd card deselects the FIRST selected (FIFO) with the
/// upsell seed inline note (D-028 — exactly one premium-tier mention
/// in onboarding).
class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen>
    with OnboardingAnalyticsMixin<GoalsScreen> {
  @override
  int get phase => 5;

  @override
  String get stepId => 'phase5_step2';

  @override
  String get frdId => 'FR-5.2.1';

  // Ordered list (by selection time) so we can FIFO at 3rd tap.
  final List<String> _selectedSlugs = [];
  bool _showUpsellNote = false;

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    if (stored != null) {
      _selectedSlugs.addAll(stored.goals.map((g) => g.templateSlug));
    }
  }

  void _toggle(String slug) {
    setState(() {
      if (_selectedSlugs.contains(slug)) {
        _selectedSlugs.remove(slug);
        return;
      }
      if (_selectedSlugs.length < 2) {
        _selectedSlugs.add(slug);
        return;
      }
      // 3rd tap → FIFO: remove the first-selected, add the new one.
      _selectedSlugs.removeAt(0);
      _selectedSlugs.add(slug);
      _showUpsellNote = true;
    });
  }

  Future<void> _continue() async {
    if (_selectedSlugs.length != 2) {
      await onValidationError('not_two');
      return;
    }
    // Persist goal slots (without amount/date yet — captured in detail screen)
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(
            goals: [
              for (var i = 0; i < 2; i++)
                OnboardingGoal(
                  slot: i + 1,
                  templateSlug: _selectedSlugs[i],
                  targetAmountMinor: 0, // captured next screen
                  currency: s.budgetCurrency ?? 'USD',
                  targetDate: DateTime.now().add(const Duration(days: 365)),
                ),
            ],
          ),
        );
    await onContinue({'slot_1': _selectedSlugs[0], 'slot_2': _selectedSlugs[1]});
    if (!mounted) return;
    context.go('/onboarding-v2/goal-detail/1');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final templates = (config?['goal_templates'] as List<dynamic>?) ??
        const [
          {'slug': 'home', 'default_label': 'Buy a home', 'icon_key': 'home'},
          {'slug': 'vehicle', 'default_label': 'Buy a vehicle', 'icon_key': 'car'},
          {'slug': 'education_fund', 'default_label': 'Education fund', 'icon_key': 'graduation_cap'},
          {'slug': 'travel', 'default_label': 'Travel', 'icon_key': 'plane'},
          {'slug': 'wedding', 'default_label': 'Wedding', 'icon_key': 'rings'},
          {'slug': 'family_planning', 'default_label': 'Family planning', 'icon_key': 'family'},
          {'slug': 'retirement', 'default_label': 'Retirement', 'icon_key': 'sun'},
          {'slug': 'build_wealth', 'default_label': 'Build wealth', 'icon_key': 'trending_up'},
          {'slug': 'emergency_fund', 'default_label': 'Emergency fund', 'icon_key': 'shield'},
          {'slug': 'hajj_umrah', 'default_label': 'Hajj/Umrah', 'icon_key': 'kaaba'},
          {'slug': 'custom', 'default_label': 'Custom', 'icon_key': 'pencil'},
        ];

    return OnboardingShell(
      title: 'Pick 2 goals',
      currentStep: 12,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/budget');
      },
      bottomActions: FeloButton(
        label: 'Continue (${_selectedSlugs.length}/2)',
        onPressed: _selectedSlugs.length == 2 ? _continue : null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'Two is the sweet spot — research shows users with 2 goals achieve them more often.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          if (_showUpsellNote) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: FeloColors.mintBase.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.workspace_premium_rounded,
                      size: 18, color: FeloColors.feloiTeal),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'FELO Plus members can set unlimited goals.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemCount: templates.length,
            itemBuilder: (context, i) {
              final template = templates[i] as Map<String, dynamic>;
              final slug = template['slug'].toString();
              final selectedIndex = _selectedSlugs.indexOf(slug);
              return GoalCard(
                icon: iconForGoalKey(template['icon_key'].toString()),
                label: template['default_label'].toString(),
                selected: selectedIndex >= 0,
                slot: selectedIndex >= 0 ? selectedIndex + 1 : null,
                onTap: () => _toggle(slug),
              );
            },
          ),
        ],
      ),
    );
  }
}
