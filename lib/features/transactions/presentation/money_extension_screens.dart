import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

/// Categories management — list + add/edit affordances.
class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final List<_CategoryItem> _categories = [
    _CategoryItem(name: 'Groceries', icon: Icons.shopping_cart_outlined),
    _CategoryItem(name: 'Family support', icon: Icons.favorite_outline),
    _CategoryItem(name: 'Transport', icon: Icons.directions_car_outlined),
    _CategoryItem(name: 'Bills', icon: Icons.receipt_outlined),
    _CategoryItem(name: 'Eating out', icon: Icons.restaurant_outlined),
    _CategoryItem(name: 'Income', icon: Icons.savings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.categoriesTitle,
      selectedTab: FeloRootTab.home,
      actions: [
        IconButton(
          icon: const Icon(Icons.add_rounded),
          onPressed: _addCategory,
          tooltip: l10n.categoriesAdd,
        ),
      ],
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _categories.length,
        itemBuilder: (context, i) {
          final cat = _categories[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FeloCard(
              child: Row(
                children: [
                  Icon(cat.icon),
                  const SizedBox(width: 12),
                  Expanded(child: Text(cat.name)),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    onPressed: () {},
                    tooltip: l10n.commonView,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addCategory() {
    setState(() {
      _categories.add(
        _CategoryItem(
          name: 'New category ${_categories.length + 1}',
          icon: Icons.label_outline_rounded,
        ),
      );
    });
  }
}

class _CategoryItem {
  _CategoryItem({required this.name, required this.icon});
  final String name;
  final IconData icon;
}

/// Recurring transactions / subscriptions tracker.
class RecurringScreen extends ConsumerWidget {
  const RecurringScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final recurring = const [
      ('Spotify Premium', 'Monthly', 'CAD', 1099, Icons.music_note_outlined),
      ('Netflix', 'Monthly', 'CAD', 1899, Icons.movie_outlined),
      ('Mobile postpaid', 'Monthly', 'CAD', 5500, Icons.smartphone_outlined),
      ('Internet', 'Monthly', 'CAD', 7999, Icons.router_outlined),
    ];

    return FeloScaffold(
      title: l10n.recurringTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.recurringBody),
          const SizedBox(height: 16),
          for (final r in recurring) ...[
            FeloCard(
              child: Row(
                children: [
                  Icon(r.$5, color: FeloColors.feloiTeal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.$1),
                        Text(r.$2,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Text(
                    formatMinorMoney(minor: r.$4, currency: r.$3),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

/// Spending insights — bar chart placeholder + category breakdown.
class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final budgets = ref.watch(budgetsProvider);
    final totalSpent =
        budgets.fold<int>(0, (s, b) => s + b.spentMinor);
    final totalLimit =
        budgets.fold<int>(0, (s, b) => s + b.limitMinor);
    final currency = budgets.isNotEmpty ? budgets.first.currency : 'CAD';

    return FeloScaffold(
      title: l10n.insightsTitle,
      selectedTab: FeloRootTab.doHub,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.insightsThisMonth,
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Text(
                  formatMinorMoney(minor: totalSpent, currency: currency),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 16),
                _MiniBarChart(budgets: budgets),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.insightsByCategory,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          for (final b in budgets) ...[
            FeloCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(b.category)),
                      Text(
                        formatMinorMoney(
                          minor: b.spentMinor,
                          currency: b.currency,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: totalLimit == 0
                        ? 0
                        : (b.spentMinor / b.limitMinor).clamp(0.0, 1.0),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(99),
                    color: FeloColors.feloiTeal,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart({required this.budgets});
  final List<Budget> budgets;

  @override
  Widget build(BuildContext context) {
    final maxV = budgets.isEmpty
        ? 1
        : budgets.map((b) => b.spentMinor).reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final b in budgets)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: maxV == 0
                    ? 4
                    : ((b.spentMinor / maxV) * 80).clamp(4.0, 80.0),
                decoration: BoxDecoration(
                  color: FeloColors.feloiTeal.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Global search across transactions, budgets, goals, family.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _query = _controller.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final txns = ref.watch(transactionsProvider);
    final budgets = ref.watch(budgetsProvider);
    final goals = ref.watch(goalsProvider);

    final txnHits = _query.isEmpty
        ? const <FeloTransaction>[]
        : txns
            .where(
              (t) =>
                  t.merchant.toLowerCase().contains(_query) ||
                  t.category.toLowerCase().contains(_query),
            )
            .take(5)
            .toList();
    final budgetHits = _query.isEmpty
        ? const <Budget>[]
        : budgets
            .where((b) => b.category.toLowerCase().contains(_query))
            .toList();
    final goalHits = _query.isEmpty
        ? const <Goal>[]
        : goals.where((g) => g.name.toLowerCase().contains(_query)).toList();

    final empty = _query.isNotEmpty &&
        txnHits.isEmpty &&
        budgetHits.isEmpty &&
        goalHits.isEmpty;

    return FeloScaffold(
      title: l10n.searchTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloInput(
            label: l10n.searchLabel,
            hint: l10n.searchHint,
            controller: _controller,
          ),
          const SizedBox(height: 16),
          if (empty)
            FeloEmptyState(
              title: l10n.searchEmptyTitle,
              body: l10n.searchEmptyBody,
            )
          else if (_query.isEmpty)
            Text(l10n.searchPrompt,
                style: Theme.of(context).textTheme.bodySmall)
          else ...[
            if (txnHits.isNotEmpty) ...[
              _SectionLabel(label: l10n.searchTransactions),
              for (final t in txnHits)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FeloCard(
                    onTap: () => context.go('/transactions/${t.id}'),
                    child: Row(
                      children: [
                        const Icon(Icons.receipt_long_outlined),
                        const SizedBox(width: 12),
                        Expanded(child: Text(t.merchant)),
                        Text(formatMinorMoney(
                            minor: t.amountMinor, currency: t.currency)),
                      ],
                    ),
                  ),
                ),
            ],
            if (budgetHits.isNotEmpty) ...[
              _SectionLabel(label: l10n.searchBudgets),
              for (final b in budgetHits)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FeloCard(
                    onTap: () => context.go('/budgets/${b.id}'),
                    child: Row(
                      children: [
                        const Icon(Icons.pie_chart_outline_rounded),
                        const SizedBox(width: 12),
                        Expanded(child: Text(b.category)),
                      ],
                    ),
                  ),
                ),
            ],
            if (goalHits.isNotEmpty) ...[
              _SectionLabel(label: l10n.searchGoals),
              for (final g in goalHits)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FeloCard(
                    onTap: () => context.go('/goals/${g.id}'),
                    child: Row(
                      children: [
                        const Icon(Icons.flag_outlined),
                        const SizedBox(width: 12),
                        Expanded(child: Text(g.name)),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
