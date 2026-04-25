import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/budgets/domain/budget.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/features/transactions/domain/spending_insights.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

part 'money_extension_screens.g.dart';

/// Categories management — list + add/edit affordances.
class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

/// Default category seed list. Stored as a stable key + icon; the
/// localized label is resolved at render time. Real user-defined
/// categories will replace this when /v1/categories ships.
const _seedCategoryKeys = <_SeedCategory>[
  _SeedCategory(key: 'groceries', icon: Icons.shopping_cart_outlined),
  _SeedCategory(key: 'family_support', icon: Icons.favorite_outline),
  _SeedCategory(key: 'transport', icon: Icons.directions_car_outlined),
  _SeedCategory(key: 'bills', icon: Icons.receipt_outlined),
  _SeedCategory(key: 'eating_out', icon: Icons.restaurant_outlined),
  _SeedCategory(key: 'income', icon: Icons.savings_outlined),
];

class _SeedCategory {
  const _SeedCategory({required this.key, required this.icon});
  final String key;
  final IconData icon;
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final List<_CategoryItem> _categories = _seedCategoryKeys
      .map((s) => _CategoryItem(seedKey: s.key, icon: s.icon))
      .toList();

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
                  Expanded(child: Text(cat.displayName(l10n))),
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
    final n = _categories.length + 1;
    setState(() {
      _categories.add(
        _CategoryItem(
          customLabel: '__new_category_$n', // resolved via l10n at render
          icon: Icons.label_outline_rounded,
        ),
      );
    });
  }
}

class _CategoryItem {
  _CategoryItem({this.seedKey, this.customLabel, required this.icon})
      : assert(seedKey != null || customLabel != null);

  /// Stable key for built-in categories — display label looked up via l10n.
  final String? seedKey;

  /// User-added category sentinel; in this Phase-1 stub we render an
  /// l10n-templated "New category N" string. Real user-typed names will
  /// replace this when /v1/categories ships.
  final String? customLabel;
  final IconData icon;

  String displayName(AppLocalizations l10n) {
    if (seedKey != null) {
      switch (seedKey!) {
        case 'groceries':
          return l10n.categoryGroceries;
        case 'family_support':
          return l10n.categoryFamilySupport;
        case 'transport':
          return l10n.categoryTransport;
        case 'bills':
          return l10n.categoryBills;
        case 'eating_out':
          return l10n.categoryEatingOut;
        case 'income':
          return l10n.categoryIncome;
      }
    }
    // Custom: derive index from sentinel and render localized template.
    final n = int.tryParse(customLabel!.split('_').last) ?? 1;
    return l10n.categoryNewLabel(n);
  }
}

/// Recurring transactions / subscriptions tracker.
class RecurringScreen extends ConsumerWidget {
  const RecurringScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    // Seed examples for empty-state preview only. Real data will come
    // from FeloApiClient.listRecurringBills() when the wiring lands.
    // Merchant names are deliberately literal (proper nouns are not
    // translated). Frequency labels go through l10n via _frequencyLabel.
    final recurring = const [
      ('Spotify Premium', 'monthly', 'CAD', 1099, Icons.music_note_outlined),
      ('Netflix', 'monthly', 'CAD', 1899, Icons.movie_outlined),
      ('Mobile postpaid', 'monthly', 'CAD', 5500, Icons.smartphone_outlined),
      ('Internet', 'monthly', 'CAD', 7999, Icons.router_outlined),
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
                        Text(
                          _frequencyLabel(l10n, r.$2),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
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

enum InsightsPeriod {
  week('week'),
  month('month'),
  quarter('quarter');

  const InsightsPeriod(this.apiValue);
  final String apiValue;
}

@riverpod
Future<SpendingInsights> spendingInsights(
  SpendingInsightsRef ref,
  InsightsPeriod period,
) {
  return ref.watch(feloApiClientProvider).getSpendingInsights(period.apiValue);
}

/// Spending insights from SMS and transaction activity.
class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  InsightsPeriod _period = InsightsPeriod.month;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final insights = ref.watch(spendingInsightsProvider(_period));

    return FeloScaffold(
      title: l10n.insightsTitle,
      selectedTab: FeloRootTab.doHub,
      child: insights.when(
        loading: () => const _InsightsSkeleton(),
        error: (error, stackTrace) => Padding(
          padding: const EdgeInsets.all(20),
          child: FeloEmptyState(
            title: l10n.insightsErrorTitle,
            body: l10n.insightsErrorBody,
          ),
        ),
        data: (data) => RefreshIndicator(
          onRefresh: () =>
              ref.refresh(spendingInsightsProvider(_period).future),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _PeriodPicker(
                period: _period,
                onChanged: (period) => setState(() => _period = period),
              ),
              const SizedBox(height: 16),
              FeloCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _periodLabel(l10n, _period),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatMinorMoney(
                        minor: data.totalMinor,
                        currency: data.currency,
                      ),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionLabel(label: l10n.insightsByCategory),
              _CategoryBars(insights: data),
              const SizedBox(height: 16),
              _SectionLabel(label: l10n.insightsTopMerchants),
              _MerchantList(insights: data),
              const SizedBox(height: 16),
              _SectionLabel(label: l10n.insightsTrend),
              _TrendChart(insights: data),
            ],
          ),
        ),
      ),
    );
  }

  String _periodLabel(AppLocalizations l10n, InsightsPeriod period) {
    return switch (period) {
      InsightsPeriod.week => l10n.insightsSpentThisWeek,
      InsightsPeriod.month => l10n.insightsSpentThisMonth,
      InsightsPeriod.quarter => l10n.insightsSpentThisQuarter,
    };
  }
}

class _PeriodPicker extends StatelessWidget {
  const _PeriodPicker({required this.period, required this.onChanged});

  final InsightsPeriod period;
  final ValueChanged<InsightsPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ChoiceChip(
          label: Text(l10n.insightsPeriodWeek),
          selected: period == InsightsPeriod.week,
          onSelected: (_) => onChanged(InsightsPeriod.week),
        ),
        ChoiceChip(
          label: Text(l10n.insightsPeriodMonth),
          selected: period == InsightsPeriod.month,
          onSelected: (_) => onChanged(InsightsPeriod.month),
        ),
        ChoiceChip(
          label: Text(l10n.insightsPeriodQuarter),
          selected: period == InsightsPeriod.quarter,
          onSelected: (_) => onChanged(InsightsPeriod.quarter),
        ),
      ],
    );
  }
}

class _CategoryBars extends StatelessWidget {
  const _CategoryBars({required this.insights});

  final SpendingInsights insights;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (insights.byCategory.isEmpty) {
      return FeloEmptyState(
        title: l10n.insightsEmptyTitle,
        body: l10n.insightsEmptyBody,
      );
    }

    final maxValue = insights.byCategory
        .map((item) => item.totalMinor)
        .fold<int>(0, (max, value) => value > max ? value : max);

    return Column(
      children: [
        for (final item in insights.byCategory) ...[
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(item.category)),
                    Text(
                      formatMinorMoney(
                        minor: item.totalMinor,
                        currency: insights.currency,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: maxValue == 0 ? 0 : item.totalMinor / maxValue,
                    minHeight: 8,
                    color: FeloColors.feloiTeal,
                    backgroundColor: FeloColors.feloiTeal.withValues(
                      alpha: 0.16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _MerchantList extends StatelessWidget {
  const _MerchantList({required this.insights});

  final SpendingInsights insights;

  @override
  Widget build(BuildContext context) {
    final merchants = insights.byMerchant.take(10).toList();
    final l10n = context.l10n;

    if (merchants.isEmpty) {
      return FeloEmptyState(
        title: l10n.insightsNoMerchantsTitle,
        body: l10n.insightsNoMerchantsBody,
      );
    }

    return Column(
      children: [
        for (final entry in merchants.indexed) ...[
          FeloCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: FeloColors.feloiTeal.withValues(alpha: 0.16),
                  child: Text('${entry.$1 + 1}'),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(entry.$2.merchant)),
                Text(
                  formatMinorMoney(
                    minor: entry.$2.totalMinor,
                    currency: insights.currency,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.insights});

  final SpendingInsights insights;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (insights.trends.isEmpty) {
      return FeloEmptyState(
        title: l10n.insightsNoTrendTitle,
        body: l10n.insightsNoTrendBody,
      );
    }

    final maxY = insights.trends
        .map((trend) => trend.totalMinor)
        .fold<int>(0, (max, value) => value > max ? value : max)
        .toDouble();

    return FeloCard(
      child: SizedBox(
        height: 180,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: maxY <= 0 ? 1 : maxY,
            gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) => FlLine(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                strokeWidth: 1,
              ),
            ),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (spots) => spots
                    .map(
                      (spot) => LineTooltipItem(
                        formatMinorMoney(
                          minor: spot.y.round(),
                          currency: insights.currency,
                        ),
                        Theme.of(context).textTheme.bodySmall ??
                            const TextStyle(),
                      ),
                    )
                    .toList(),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                barWidth: 3,
                color: FeloColors.feloiTeal,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: FeloColors.feloiTeal.withValues(alpha: 0.12),
                ),
                spots: [
                  for (final entry in insights.trends.indexed)
                    FlSpot(entry.$1.toDouble(), entry.$2.totalMinor.toDouble()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightsSkeleton extends StatelessWidget {
  const _InsightsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Wrap(
          spacing: 8,
          children: [
            _SkeletonBox(width: 72, height: 36),
            _SkeletonBox(width: 84, height: 36),
            _SkeletonBox(width: 96, height: 36),
          ],
        ),
        const SizedBox(height: 16),
        const FeloCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SkeletonBox(width: 120, height: 14),
              SizedBox(height: 14),
              _SkeletonBox(width: 190, height: 38),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < 3; i++) ...[
          const FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletonBox(width: 180, height: 16),
                SizedBox(height: 10),
                _SkeletonBox(width: double.infinity, height: 8),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        const SizedBox(height: 8),
        const FeloCard(
          child: _SkeletonBox(width: double.infinity, height: 160),
        ),
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
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

    final empty =
        _query.isNotEmpty &&
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
            Text(
              l10n.searchPrompt,
              style: Theme.of(context).textTheme.bodySmall,
            )
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
                        Text(
                          formatMinorMoney(
                            minor: t.amountMinor,
                            currency: t.currency,
                          ),
                        ),
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
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

String _frequencyLabel(AppLocalizations l10n, String key) {
  switch (key) {
    case 'weekly':
      return l10n.recurringFreqWeekly;
    case 'monthly':
      return l10n.recurringFreqMonthly;
    case 'quarterly':
      return l10n.recurringFreqQuarterly;
    case 'yearly':
      return l10n.recurringFreqYearly;
    default:
      return key;
  }
}
