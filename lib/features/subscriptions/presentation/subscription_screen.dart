import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/subscriptions/application/subscription_providers.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final tierAsync = ref.watch(userTierProvider);
    final paywallAsync = ref.watch(paywallConfigProvider);

    return FeloScaffold(
      title: l10n.subscriptionTitle,
      selectedTab: FeloRootTab.home,
      child: tierAsync.when(
        data: (tier) => _TierContent(
          tier: tier,
          paywallAsync: paywallAsync,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => FeloEmptyState(
          title: l10n.errorGenericTitle,
          body: l10n.errorGeneric(e.toString()),
        ),
      ),
    );
  }
}

class _TierContent extends ConsumerWidget {
  const _TierContent({
    required this.tier,
    required this.paywallAsync,
  });

  final Map<String, dynamic> tier;
  final AsyncValue<Map<String, dynamic>> paywallAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final currentTier = tier['tier'] as String? ?? 'free';
    final usage = tier['usage'] as Map<String, dynamic>? ?? {};
    final limits = tier['limits'] as Map<String, dynamic>? ?? {};

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Current tier badge
        Center(
          child: Chip(
            label: Text(
              currentTier.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            backgroundColor: _tierColor(currentTier),
            padding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 24),

        // Usage overview
        Text(
          l10n.subscriptionUsageTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _UsageMeter(
          label: l10n.subscriptionUsageExpenses,
          used: usage['expensesThisMonth'] as int? ?? 0,
          limit: limits['maxExpensesPerMonth'] as int? ?? 50,
        ),
        const SizedBox(height: 8),
        _UsageMeter(
          label: l10n.subscriptionUsageAiQueries,
          used: usage['aiQueriesThisMonth'] as int? ?? 0,
          limit: limits['maxAiQueriesPerMonth'] as int? ?? 10,
        ),
        const SizedBox(height: 8),
        _UsageMeter(
          label: l10n.subscriptionUsageGoals,
          used: usage['goalsActive'] as int? ?? 0,
          limit: limits['maxGoals'] as int? ?? 1,
        ),
        const SizedBox(height: 8),
        _UsageMeter(
          label: l10n.subscriptionUsageGroups,
          used: usage['groupsActive'] as int? ?? 0,
          limit: limits['maxGroups'] as int? ?? 1,
        ),
        const SizedBox(height: 24),

        // Paywall plans
        paywallAsync.when(
          data: (config) => _PaywallPlans(
            plans: (config['plans'] as List?)?.cast<Map<String, dynamic>>() ?? const [],
            currentTier: currentTier,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text(l10n.errorGeneric(e.toString())),
        ),

        const SizedBox(height: 24),

        // Coupon + Restore
        _CouponSection(),
        const SizedBox(height: 12),
        FeloButton(
          label: l10n.subscriptionRestorePurchases,
          icon: Icons.restore_rounded,
          variant: FeloButtonVariant.secondary,
          onPressed: () => ref.read(purchaseRestoreProvider.notifier).restore(),
        ),
      ],
    );
  }

  Color _tierColor(String tier) {
    switch (tier) {
      case 'plus':
        return Colors.blue[100]!;
      case 'plus-plus':
        return Colors.purple[100]!;
      case 'founding-family':
        return Colors.amber[100]!;
      default:
        return Colors.grey[200]!;
    }
  }
}

class _PaywallPlans extends ConsumerWidget {
  const _PaywallPlans({
    required this.plans,
    required this.currentTier,
  });

  final List<Map<String, dynamic>> plans;
  final String currentTier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.subscriptionUpgradeTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        for (final plan in plans) ...[
          _PlanCard(
            name: plan['name'] as String? ?? 'Plan',
            price: _formatPrice(plan['monthlyPrice'] as Map<String, dynamic>?),
            period: l10n.subscriptionPeriodMonthly,
            features: (plan['features'] as List?)?.cast<String>() ?? const [],
            isCurrent: currentTier == (plan['id'] as String? ?? ''),
            isRecommended: plan['recommended'] == true,
            onSelect: () => ref
                .read(checkoutSessionProvider.notifier)
                .create(
                  planId: plan['id'] as String? ?? '',
                  currency: (plan['monthlyPrice'] as Map<String, dynamic>?)?['currency'] as String? ?? 'CAD',
                ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  String _formatPrice(Map<String, dynamic>? price) {
    if (price == null) return '';
    final minor = price['amountMinor'] as int? ?? 0;
    final currency = price['currency'] as String? ?? 'CAD';
    final major = minor / 100;
    return '$currency ${major.toStringAsFixed(2)}';
  }
}

class _UsageMeter extends StatelessWidget {
  final String label;
  final int used;
  final int limit;

  const _UsageMeter({required this.label, required this.used, required this.limit});

  @override
  Widget build(BuildContext context) {
    final isUnlimited = limit >= 999999;
    final progress = isUnlimited ? 0.0 : (used / limit).clamp(0.0, 1.0);
    final isNearLimit = !isUnlimited && progress > 0.8;

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(
                isUnlimited ? '$used / ${context.l10n.subscriptionUnlimited}' : '$used / $limit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isNearLimit ? Colors.red : null,
                ),
              ),
            ],
          ),
          if (!isUnlimited) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(
                isNearLimit ? Colors.red : progress > 0.5 ? Colors.orange : Colors.green,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isCurrent;
  final bool isRecommended;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    required this.onSelect,
    this.isCurrent = false,
    this.isRecommended = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Text(
                l10n.subscriptionRecommendedLabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: theme.textTheme.titleLarge),
                    if (isCurrent)
                      Chip(
                        label: Text(l10n.subscriptionCurrentLabel),
                        backgroundColor: Colors.green[100],
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(period, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                ...features.map((f) => Row(
                  children: [
                    const Icon(Icons.check, size: 16, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(f, style: theme.textTheme.bodySmall)),
                  ],
                )),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: isCurrent
                      ? OutlinedButton(
                          onPressed: null,
                          child: Text(l10n.subscriptionCurrentPlanButton),
                        )
                      : FilledButton(
                          onPressed: onSelect,
                          child: Text(l10n.subscriptionUpgradeButton),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CouponSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends ConsumerState<_CouponSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final couponState = ref.watch(couponApplierProvider);

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.subscriptionCouponTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: FeloInput(
                  label: l10n.subscriptionCouponLabel,
                  controller: _controller,
                ),
              ),
              const SizedBox(width: 8),
              FeloButton(
                label: l10n.subscriptionCouponApply,
                onPressed: () {
                  final code = _controller.text.trim();
                  if (code.isNotEmpty) {
                    ref.read(couponApplierProvider.notifier).apply(code);
                  }
                },
              ),
            ],
          ),
          if (couponState.valueOrNull != null) ...[
            const SizedBox(height: 8),
            Text(
              (couponState.valueOrNull?['valid'] == true)
                  ? l10n.subscriptionCouponSuccess(
                      couponState.valueOrNull?['discountPercent']?.toString() ?? '')
                  : l10n.subscriptionCouponInvalid,
              style: TextStyle(
                color: (couponState.valueOrNull?['valid'] == true)
                    ? Colors.green
                    : Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
