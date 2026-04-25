import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/category_row.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/money_input.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-5.1.1..5** — Set monthly budget.
///
/// Pre-fills categories from `budget_templates_by_key[region:earning_type]`
/// per D-019. D-020 bidirectional family-contribution semantic. Continue
/// non-blocking even with mismatched total.
class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen>
    with OnboardingAnalyticsMixin<BudgetScreen> {
  @override
  int get phase => 5;

  @override
  String get stepId => 'phase5_step1';

  @override
  String get frdId => 'FR-5.1.1';

  int _totalMinor = 0;
  String _currency = 'PKR';
  final List<_CategoryEntry> _categories = [];
  bool _initialized = false;
  String? _templateUsed;

  void _hydrate(Map<String, dynamic>? config, OnboardingState? stored) {
    if (_initialized) return;
    if (stored?.primaryRegion == null) return;
    _initialized = true;

    final primaryRegion = stored!.primaryRegion!;
    _currency = stored.budgetCurrency ?? _currencyFor(primaryRegion);
    _totalMinor = stored.budgetTotalMinor ?? 0;

    // Resume case: existing categories
    if (stored.budgetCategories.isNotEmpty) {
      for (final c in stored.budgetCategories) {
        _categories.add(_CategoryEntry(
          slug: c.categorySlug,
          amountMinor: c.amountMinor,
          semantic: c.semantic,
          controller: TextEditingController(
            text: (c.amountMinor / 100).toStringAsFixed(0),
          ),
        ));
      }
      return;
    }

    // First-pass: load template
    final earning = stored.earningTypes.isEmpty
        ? 'salaried'
        : _topEarningType(stored.earningTypes);
    final templates = config?['budget_templates_by_key']
        as Map<String, dynamic>?;
    final key = '$primaryRegion:$earning';
    final fallbackKey = '$primaryRegion:salaried';
    final rows = (templates?[key] ?? templates?[fallbackKey]) as List<dynamic>?;

    if (rows != null) {
      _templateUsed = key;
      // Pre-fill at a baseline 100k for PKR / 5000 for CAD/USD/AED — user
      // adjusts the total at the top and percentages re-apply.
      const baselineByCurrency = {
        'PKR': 100000,
        'INR': 30000,
        'BDT': 30000,
        'NPR': 30000,
        'LKR': 50000,
        'CAD': 5000,
        'USD': 5000,
        'GBP': 4000,
        'AED': 8000,
        'SAR': 10000,
      };
      _totalMinor = (baselineByCurrency[_currency] ?? 5000) * 100;
      for (final r in rows) {
        final pct = r['default_pct'] as int;
        final amount = (_totalMinor * pct / 100).round();
        _categories.add(_CategoryEntry(
          slug: r['category_slug'].toString(),
          amountMinor: amount,
          semantic: r['semantic'].toString(),
          controller: TextEditingController(
            text: (amount / 100).toStringAsFixed(0),
          ),
        ));
      }
    } else {
      // No template — minimal default categories
      _totalMinor = 1000 * 100;
      _categories.addAll([
        _CategoryEntry(
          slug: 'food',
          amountMinor: 30000,
          semantic: 'outflow',
          controller: TextEditingController(text: '300'),
        ),
        _CategoryEntry(
          slug: 'transport',
          amountMinor: 10000,
          semantic: 'outflow',
          controller: TextEditingController(text: '100'),
        ),
        _CategoryEntry(
          slug: 'savings',
          amountMinor: 60000,
          semantic: 'outflow',
          controller: TextEditingController(text: '600'),
        ),
      ]);
    }
  }

  static String _topEarningType(List<String> types) {
    // D-015 precedence: Salaried > Business owner > Freelancer > Investor >
    // Finance pro > Student > Homemaker > Other.
    const precedence = [
      'salaried',
      'business_owner',
      'freelancer',
      'investor',
      'finance_professional',
      'student',
      'homemaker',
      'other',
    ];
    for (final p in precedence) {
      if (types.contains(p)) return p;
    }
    return types.first;
  }

  static String _currencyFor(String iso2) {
    return switch (iso2) {
      'PK' => 'PKR',
      'IN' => 'INR',
      'BD' => 'BDT',
      'NP' => 'NPR',
      'LK' => 'LKR',
      'CA' => 'CAD',
      'GB' => 'GBP',
      'US' => 'USD',
      'AE' => 'AED',
      'SA' => 'SAR',
      _ => 'USD',
    };
  }

  static String _categoryLabel(String slug) {
    return switch (slug) {
      'food' => 'Food',
      'transport' => 'Transport',
      'rent' => 'Rent',
      'rent_mortgage' => 'Rent / Mortgage',
      'family_support' => 'Family support',
      'family_allowance' => 'Family allowance',
      'shopping' => 'Shopping',
      'health' => 'Health',
      'education' => 'Education',
      'entertainment' => 'Entertainment',
      'savings' => 'Savings',
      'buffer' => 'Buffer',
      'daycare' => 'Daycare',
      _ => slug.split('_').map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}').join(' '),
    };
  }

  static IconData _categoryIcon(String slug) {
    return switch (slug) {
      'food' => Icons.restaurant_outlined,
      'transport' => Icons.directions_car_outlined,
      'rent' || 'rent_mortgage' => Icons.home_outlined,
      'family_support' => Icons.family_restroom_rounded,
      'family_allowance' => Icons.savings_outlined,
      'shopping' => Icons.shopping_bag_outlined,
      'health' => Icons.health_and_safety_outlined,
      'education' => Icons.school_outlined,
      'entertainment' => Icons.movie_outlined,
      'savings' => Icons.account_balance_wallet_outlined,
      'buffer' => Icons.shield_outlined,
      'daycare' => Icons.child_care_outlined,
      _ => Icons.label_outline_rounded,
    };
  }

  int get _allocated {
    return _categories
        .where((c) => c.semantic == 'outflow')
        .fold<int>(0, (sum, c) => sum + c.amountMinor);
  }

  int get _diff => _totalMinor - _allocated;

  Future<void> _continue() async {
    if (_totalMinor <= 0) {
      await onValidationError('zero_total');
      return;
    }
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(
            budgetTotalMinor: _totalMinor,
            budgetCurrency: _currency,
            budgetCategories: _categories
                .map((c) => OnboardingBudgetCategory(
                      categorySlug: c.slug,
                      amountMinor: c.amountMinor,
                      semantic: c.semantic,
                    ))
                .toList(),
          ),
        );
    await onContinue({
      'total': _totalMinor,
      'currency': _currency,
      'categories_count': _categories.length,
      'template_used': _templateUsed,
    });
    if (!mounted) return;
    context.go('/onboarding-v2/goals');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final stored = ref.watch(onboardingStateControllerProvider).valueOrNull;
    _hydrate(config, stored);

    return OnboardingShell(
      title: 'Set your monthly budget',
      currentStep: 11,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        final invests = stored?.invests == true;
        context.go(invests
            ? '/onboarding-v2/invest-types'
            : '/onboarding-v2/invest-gate');
      },
      bottomActions: FeloButton(
        label: 'Continue',
        onPressed: _totalMinor <= 0 ? null : _continue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'We pre-filled some defaults — adjust to match your reality.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'This stays private and is only used on your dashboard.',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(height: 20),
          MoneyInput(
            label: 'Total monthly budget',
            currency: _currency,
            initialMinor: _totalMinor,
            onChanged: (v) => setState(() => _totalMinor = v),
          ),
          const SizedBox(height: 12),
          if (_diff != 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _diff < 0
                    ? Colors.amber.shade100
                    : FeloColors.mintBase.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _diff < 0
                    ? '$_currency ${(-_diff / 100).toStringAsFixed(0)} over budget'
                    : '$_currency ${(_diff / 100).toStringAsFixed(0)} unallocated',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          const SizedBox(height: 20),
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final entry = _categories[i];
              return CategoryRow(
                icon: _categoryIcon(entry.slug),
                label: _categoryLabel(entry.slug),
                amountController: entry.controller,
                currency: _currency,
                semantic: entry.semantic,
                onChanged: (v) => setState(() => entry.amountMinor = v),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryEntry {
  _CategoryEntry({
    required this.slug,
    required this.amountMinor,
    required this.semantic,
    required this.controller,
  });
  final String slug;
  int amountMinor;
  final String semantic;
  final TextEditingController controller;
}
