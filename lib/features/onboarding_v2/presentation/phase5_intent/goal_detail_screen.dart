import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/goal_card.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/money_input.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_input.dart';

/// **FR-5.2.3..6** — Per-goal detail (target amount + currency + date).
///
/// Multi-currency goal target per D-021 — currency dropdown defaults to
/// budget currency, allows secondary regions + USD/EUR.
/// D-022 date validation (min 30 days; native picker ≤1y, custom MM/YYYY >1y).
class GoalDetailScreen extends ConsumerStatefulWidget {
  const GoalDetailScreen({required this.slot, super.key});

  /// 1 or 2.
  final int slot;

  @override
  ConsumerState<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends ConsumerState<GoalDetailScreen>
    with OnboardingAnalyticsMixin<GoalDetailScreen> {
  @override
  int get phase => 5;

  @override
  String get stepId => 'phase5_step2_detail';

  @override
  String get frdId => 'FR-5.2.3';

  int _targetMinor = 0;
  String _currency = 'USD';
  DateTime? _targetDate;
  String? _customLabel;
  String? _dateError;
  String? _amountError;
  String _slug = '';

  static const _customCurrencies = ['USD', 'EUR'];

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    if (stored == null) return;
    final goal = stored.goals.firstWhere(
      (g) => g.slot == widget.slot,
      orElse: () => OnboardingGoal(
        slot: widget.slot,
        templateSlug: '',
        targetAmountMinor: 0,
        currency: stored.budgetCurrency ?? 'USD',
        targetDate: DateTime.now().add(const Duration(days: 365)),
      ),
    );
    _slug = goal.templateSlug;
    _targetMinor = goal.targetAmountMinor;
    _currency = goal.currency;
    _targetDate = goal.targetDate;
    _customLabel = goal.customLabel;
  }

  List<String> get _availableCurrencies {
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    final base = <String>{};
    if (stored?.budgetCurrency != null) base.add(stored!.budgetCurrency!);
    final regionCurrencies = {
      'PK': 'PKR', 'IN': 'INR', 'BD': 'BDT', 'NP': 'NPR', 'LK': 'LKR',
      'CA': 'CAD', 'GB': 'GBP', 'US': 'USD', 'AE': 'AED', 'SA': 'SAR',
    };
    if (stored?.primaryRegion != null) {
      final c = regionCurrencies[stored!.primaryRegion!];
      if (c != null) base.add(c);
    }
    for (final iso in stored?.secondaryRegions ?? const []) {
      final c = regionCurrencies[iso];
      if (c != null) base.add(c);
    }
    base.addAll(_customCurrencies);
    return base.toList();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final earliest = now.add(const Duration(days: 30));
    final initial = _targetDate != null && _targetDate!.isAfter(earliest)
        ? _targetDate!
        : earliest;
    // D-022: native picker for ≤1y, custom MM/YYYY for >1y. For E5 we ship
    // a unified native picker spanning 30 days → 30 years; the custom
    // MM/YYYY picker is a polish-cycle follow-up.
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: earliest,
      lastDate: now.add(const Duration(days: 365 * 30)),
      helpText: 'Pick your target date',
    );
    if (picked != null) {
      setState(() {
        _targetDate = picked;
        _dateError = null;
      });
    }
  }

  Future<void> _continue() async {
    if (_targetMinor <= 0) {
      setState(() => _amountError = 'Set a target amount');
      await onValidationError('zero_amount');
      return;
    }
    if (_targetDate == null) {
      setState(() => _dateError = 'Pick a target date');
      await onValidationError('no_date');
      return;
    }
    final earliest = DateTime.now().add(const Duration(days: 30));
    if (_targetDate!.isBefore(earliest)) {
      setState(() => _dateError = 'Pick a date at least a month from today');
      await onValidationError('date_too_close');
      return;
    }
    setState(() {
      _amountError = null;
      _dateError = null;
    });

    final stored = ref.read(onboardingStateControllerProvider).valueOrNull!;
    final updatedGoals = stored.goals.map((g) {
      if (g.slot != widget.slot) return g;
      return g.copyWith(
        targetAmountMinor: _targetMinor,
        currency: _currency,
        targetDate: _targetDate!,
        customLabel: _slug == 'custom' ? _customLabel : null,
      );
    }).toList();
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(goals: updatedGoals),
        );
    await onContinue({
      'slot': widget.slot,
      'slug': _slug,
      'currency': _currency,
      'target_minor': _targetMinor,
      'target_date': _targetDate!.toIso8601String().split('T')[0],
    });
    if (!mounted) return;
    if (widget.slot == 1) {
      context.go('/onboarding-v2/goal-detail/2');
    } else {
      context.go('/onboarding-v2/family-remittance');
    }
  }

  int? _monthlyContribution() {
    if (_targetMinor <= 0 || _targetDate == null) return null;
    final months = (_targetDate!.difference(DateTime.now()).inDays / 30.4).round();
    if (months <= 0) return null;
    return (_targetMinor / months).round();
  }

  String _label() {
    if (_slug == 'custom') return _customLabel ?? 'Custom goal';
    return switch (_slug) {
      'home' => 'Buy a home',
      'vehicle' => 'Buy a vehicle',
      'education_fund' => 'Education fund',
      'travel' => 'Travel',
      'wedding' => 'Wedding',
      'family_planning' => 'Family planning',
      'retirement' => 'Retirement',
      'build_wealth' => 'Build wealth',
      'emergency_fund' => 'Emergency fund',
      'hajj_umrah' => 'Hajj / Umrah',
      _ => 'Goal',
    };
  }

  String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final monthly = _monthlyContribution();
    final iconKey = switch (_slug) {
      'home' => 'home',
      'vehicle' => 'car',
      'education_fund' => 'graduation_cap',
      'travel' => 'plane',
      'wedding' => 'rings',
      'family_planning' => 'family',
      'retirement' => 'sun',
      'build_wealth' => 'trending_up',
      'emergency_fund' => 'shield',
      'hajj_umrah' => 'kaaba',
      'custom' => 'pencil',
      _ => 'trending_up',
    };

    return OnboardingShell(
      title: 'Goal ${widget.slot} of 2',
      currentStep: 12 + widget.slot,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        if (widget.slot == 1) {
          context.go('/onboarding-v2/goals');
        } else {
          context.go('/onboarding-v2/goal-detail/1');
        }
      },
      bottomActions: FeloButton(label: 'Continue', onPressed: _continue),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: 160,
              child: GoalCard(
                icon: iconForGoalKey(iconKey),
                label: _label(),
                selected: true,
                slot: widget.slot,
              ),
            ),
          ),
          const SizedBox(height: 28),
          if (_slug == 'custom') ...[
            FeloInput(
              label: 'Goal name',
              onChanged: (v) => setState(() => _customLabel = v),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Expanded(
                flex: 7,
                child: MoneyInput(
                  label: 'Target amount',
                  currency: _currency,
                  initialMinor: _targetMinor > 0 ? _targetMinor : null,
                  onChanged: (v) => setState(() => _targetMinor = v),
                  error: _amountError,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: DropdownButtonFormField<String>(
                  initialValue: _availableCurrencies.contains(_currency)
                      ? _currency
                      : _availableCurrencies.first,
                  decoration: const InputDecoration(
                    labelText: 'Currency',
                    border: OutlineInputBorder(),
                  ),
                  items: _availableCurrencies
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => _currency = v);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _pickDate,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Target date',
                border: const OutlineInputBorder(),
                errorText: _dateError,
                suffixIcon: const Icon(Icons.calendar_today_outlined),
              ),
              child: Text(
                _targetDate == null ? 'Tap to pick' : _formatDate(_targetDate!),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
          if (monthly != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: FeloColors.mintBase.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To hit this goal',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_currency ${(monthly / 100).toStringAsFixed(0)} / month',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: FeloColors.feloiTeal,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
