import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';
import 'package:felo/features/subscriptions/application/subscription_providers.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tierAsync = ref.watch(userTierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FELO Plus'),
        centerTitle: true,
      ),
      body: tierAsync.when(
        data: (tier) => _TierContent(tier: tier),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _TierContent extends StatelessWidget {
  final Map<String, dynamic> tier;

  const _TierContent({required this.tier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentTier = tier['tier'] as String? ?? 'free';
    final usage = tier['usage'] as Map<String, dynamic>? ?? {};
    final limits = tier['limits'] as Map<String, dynamic>? ?? {};

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Current tier badge
        Center(
          child: Chip(
            label: Text(
              currentTier.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            backgroundColor: _tierColor(currentTier),
            padding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 24),

        // Usage overview
        Text('Your Usage', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        _UsageMeter(
          label: 'Expenses This Month',
          used: usage['expensesThisMonth'] as int? ?? 0,
          limit: limits['maxExpensesPerMonth'] as int? ?? 50,
        ),
        const SizedBox(height: 8),
        _UsageMeter(
          label: 'AI Questions',
          used: usage['aiQueriesThisMonth'] as int? ?? 0,
          limit: limits['maxAiQueriesPerMonth'] as int? ?? 10,
        ),
        const SizedBox(height: 8),
        _UsageMeter(
          label: 'Goals',
          used: usage['goalsActive'] as int? ?? 0,
          limit: limits['maxGoals'] as int? ?? 1,
        ),
        const SizedBox(height: 8),
        _UsageMeter(
          label: 'Groups',
          used: usage['groupsActive'] as int? ?? 0,
          limit: limits['maxGroups'] as int? ?? 1,
        ),
        const SizedBox(height: 24),

        // Upgrade options
        Text('Upgrade', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        _PlanCard(
          name: 'FELO Plus',
          price: 'PKR 799 / CAD 4.99',
          period: 'per month',
          features: const [
            'Unlimited expenses',
            '5 goals',
            '3 shared groups',
            'Weekly AI insights',
            'Monthly reports',
            'Data export',
            '20 receipt scans/month',
          ],
          isCurrent: currentTier == 'plus',
          onSelect: () {},
        ),
        const SizedBox(height: 12),
        _PlanCard(
          name: 'FELO Plus+',
          price: 'PKR 1,499 / CAD 8.99',
          period: 'per month',
          features: const [
            'Everything in Plus',
            'Unlimited goals & groups',
            'Advanced AI coaching',
            'Receipt OCR (100/month)',
            'Remittance notebook',
            'Family roles',
            'Priority support',
          ],
          isRecommended: true,
          isCurrent: currentTier == 'plus-plus',
          onSelect: () {},
        ),
        const SizedBox(height: 12),
        _PlanCard(
          name: 'Founding Family',
          price: 'PKR 7,999 / CAD 49',
          period: 'per year',
          features: const [
            'All Plus+ features',
            'Annual discount (save 56%)',
            'Early access to new features',
            'Founding Family badge',
          ],
          isCurrent: currentTier == 'founding-family',
          onSelect: () {},
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
                isUnlimited ? '$used / Unlimited' : '$used / $limit',
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
              child: const Text(
                'RECOMMENDED',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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
                        label: const Text('Current'),
                        backgroundColor: Colors.green[100],
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(price, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                          child: const Text('Current Plan'),
                        )
                      : FilledButton(
                          onPressed: onSelect,
                          child: const Text('Upgrade'),
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
