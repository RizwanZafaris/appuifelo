import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/investments/data/investments_repository.dart';
import 'package:felo/features/investments/domain/investment.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_bottom_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class InvestmentsScreen extends ConsumerWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final holdings = ref.watch(investmentsProvider).maybeWhen(
          data: (items) =>
              items.where((holding) => !holding.archived).toList(),
          orElse: () => const <Investment>[],
        );
    final portfolio = ref.watch(investmentPortfolioProvider).maybeWhen(
          data: (p) => p,
          orElse: () => null,
        );

    return FeloScaffold(
      title: l10n.investmentsTitle,
      selectedTab: FeloRootTab.goals,
      actions: [
        IconButton(
          tooltip: l10n.investmentsRefreshPrices,
          onPressed: holdings.isEmpty
              ? null
              : () => _showRefreshPricesSheet(context, ref, holdings),
          icon: const Icon(Icons.sync_rounded),
        ),
      ],
      child: Scaffold(
        body: holdings.isEmpty
            ? FeloEmptyState(
                title: l10n.investmentsEmptyTitle,
                body: l10n.investmentsEmptyBody,
                actionLabel: l10n.investmentsAddAsset,
                onAction: () => context.go('/investments/new'),
              )
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _TrackerOnlyChip(),
                  const SizedBox(height: 12),
                  if (portfolio != null) _PortfolioSummaryCard(portfolio: portfolio),
                  if (portfolio != null) const SizedBox(height: 12),
                  if (portfolio != null) _AllocationChart(portfolio: portfolio),
                  const SizedBox(height: 12),
                  Text(
                    l10n.investmentsHoldings,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final holding in holdings) ...[
                    _HoldingCard(holding: holding),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
        floatingActionButton: FloatingActionButton(
          tooltip: l10n.investmentsAddAsset,
          onPressed: () => context.go('/investments/new'),
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }

  Future<void> _showRefreshPricesSheet(
    BuildContext context,
    WidgetRef ref,
    List<Investment> holdings,
  ) async {
    final l10n = context.l10n;
    final controllers = {
      for (final holding in holdings)
        holding.id: TextEditingController(
          text: (holding.latestPriceMinor / 100).toStringAsFixed(2),
        ),
    };

    await showFeloBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 20,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                l10n.investmentsRefreshPrices,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(l10n.investmentsRefreshPricesBody),
              const SizedBox(height: 16),
              for (final holding in holdings) ...[
                FeloInput(
                  label: '${holding.symbol} ${l10n.investmentsLatestPrice}',
                  controller: controllers[holding.id],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              FeloButton(
                label: l10n.commonSave,
                icon: Icons.check_rounded,
                onPressed: () {
                  for (final holding in holdings) {
                    final major = _parseMajor(controllers[holding.id]!.text);
                    if (major != null) {
                      ref
                          .read(investmentsProvider.notifier)
                          .updatePrice(
                            investmentId: holding.id,
                            priceMinor: (major * 100).round(),
                          );
                    }
                  }
                  Navigator.of(sheetContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );

    for (final controller in controllers.values) {
      controller.dispose();
    }
  }
}

class InvestmentAddScreen extends ConsumerStatefulWidget {
  const InvestmentAddScreen({super.key});

  @override
  ConsumerState<InvestmentAddScreen> createState() =>
      _InvestmentAddScreenState();
}

class _InvestmentAddScreenState extends ConsumerState<InvestmentAddScreen> {
  final _symbolController = TextEditingController();
  final _nameController = TextEditingController();
  // Form fields start empty; user must enter values explicitly.
  // Hardcoded defaults ('CAD', '1') were removed per senior review.
  final _currencyController = TextEditingController();
  final _unitsController = TextEditingController();
  final _costBasisController = TextEditingController();
  final _notesController = TextEditingController();
  var _assetClass = InvestmentAssetClass.stockEtf;

  @override
  void dispose() {
    _symbolController.dispose();
    _nameController.dispose();
    _currencyController.dispose();
    _unitsController.dispose();
    _costBasisController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.investmentsAddAsset,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _TrackerOnlyChip(),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final assetClass in InvestmentAssetClass.values)
                FeloChip(
                  label: context.assetClassLabel(assetClass),
                  icon: _assetClassIcon(assetClass),
                  selected: _assetClass == assetClass,
                  onTap: () => setState(() => _assetClass = assetClass),
                ),
            ],
          ),
          const SizedBox(height: 16),
          FeloInput(
            label: l10n.investmentsSymbolLabel,
            controller: _symbolController,
          ),
          const SizedBox(height: 12),
          FeloInput(
            label: l10n.investmentsNameLabel,
            controller: _nameController,
          ),
          const SizedBox(height: 12),
          FeloInput(
            label: l10n.investmentsCurrencyLabel,
            controller: _currencyController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 12),
          FeloInput(
            label: l10n.investmentsUnitsLabel,
            controller: _unitsController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          FeloInput(
            label: l10n.investmentsCostBasisLabel,
            controller: _costBasisController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(labelText: l10n.investmentsNotesLabel),
          ),
          const SizedBox(height: 20),
          FeloButton(
            label: l10n.investmentsSaveAsset,
            icon: Icons.check_rounded,
            onPressed: _save,
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final units = double.tryParse(_unitsController.text.trim()) ?? 0;
    final costBasisMajor = _parseMajor(_costBasisController.text) ?? 0;
    final investment = await ref
        .read(investmentsProvider.notifier)
        .create(
          symbol: _symbolController.text.trim().isEmpty
              ? l10n.investmentsManualSymbolFallback
              : _symbolController.text.trim().toUpperCase(),
          name: _nameController.text.trim().isEmpty
              ? l10n.investmentsManualNameFallback
              : _nameController.text.trim(),
          assetClass: _assetClass,
          currency: _currencyController.text.trim().isEmpty
              ? 'CAD'
              : _currencyController.text.trim().toUpperCase(),
          units: units,
          costBasisMinor: (costBasisMajor * 100).round(),
          notes: _notesController.text.trim(),
        );
    if (!mounted) return;
    context.go('/investments/${investment.id}');
  }
}

class InvestmentDetailScreen extends ConsumerWidget {
  const InvestmentDetailScreen({required this.investmentId, super.key});

  final String investmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final investmentsAsync = ref.watch(investmentsProvider);
    final investment = investmentsAsync.maybeWhen(
      data: (items) => items
          .where((item) => item.id == investmentId)
          .firstOrNull,
      orElse: () => null,
    );

    if (investment == null) {
      return FeloScaffold(
        title: l10n.investmentsDetailTitle,
        child: FeloEmptyState(
          title: l10n.investmentsMissingTitle,
          body: l10n.investmentsMissingBody,
          actionLabel: l10n.commonBack,
          onAction: () => context.go('/investments'),
        ),
      );
    }

    return FeloScaffold(
      title: investment.symbol,
      actions: [
        IconButton(
          tooltip: l10n.investmentsUpdatePrice,
          onPressed: () => _showUpdatePriceSheet(context, ref, investment),
          icon: const Icon(Icons.edit_note_rounded),
        ),
        IconButton(
          tooltip: l10n.investmentsArchive,
          onPressed: () {
            ref.read(investmentsProvider.notifier).archive(investment.id);
            context.go('/investments');
          },
          icon: const Icon(Icons.archive_outlined),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _TrackerOnlyChip(),
          const SizedBox(height: 12),
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  investment.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                FeloChip(
                  label: context.assetClassLabel(investment.assetClass),
                  icon: _assetClassIcon(investment.assetClass),
                ),
                const SizedBox(height: 16),
                _StatsGrid(investment: investment),
                if (investment.notes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    l10n.investmentsNotesLabel,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(investment.notes),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          FeloButton(
            label: l10n.commonEdit,
            icon: Icons.edit_rounded,
            variant: FeloButtonVariant.secondary,
            onPressed: () => _showUpdatePriceSheet(context, ref, investment),
          ),
          const SizedBox(height: 8),
          FeloButton(
            label: l10n.investmentsArchive,
            icon: Icons.archive_outlined,
            variant: FeloButtonVariant.ghost,
            onPressed: () {
              ref.read(investmentsProvider.notifier).archive(investment.id);
              context.go('/investments');
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showUpdatePriceSheet(
    BuildContext context,
    WidgetRef ref,
    Investment investment,
  ) async {
    final l10n = context.l10n;
    final controller = TextEditingController(
      text: (investment.latestPriceMinor / 100).toStringAsFixed(2),
    );
    await showFeloBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.investmentsUpdatePrice,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              FeloInput(
                label: l10n.investmentsLatestPrice,
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.commonSave,
                icon: Icons.check_rounded,
                onPressed: () {
                  final major = _parseMajor(controller.text);
                  if (major != null) {
                    ref
                        .read(investmentsProvider.notifier)
                        .updatePrice(
                          investmentId: investment.id,
                          priceMinor: (major * 100).round(),
                        );
                  }
                  Navigator.of(sheetContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
    controller.dispose();
  }
}

class _PortfolioSummaryCard extends StatelessWidget {
  const _PortfolioSummaryCard({required this.portfolio});

  final InvestmentPortfolioSummary portfolio;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final gain = portfolio.totalProfitLossMinor >= 0;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.investmentsPortfolioValue),
          const SizedBox(height: 6),
          Text(
            formatMinorMoney(
              minor: portfolio.totalMarketValueMinor,
              currency: 'CAD',
            ),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  label: l10n.investmentsProfitLoss,
                  value: formatMinorMoney(
                    minor: portfolio.totalProfitLossMinor,
                    currency: 'CAD',
                  ),
                  color: gain ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricTile(
                  label: l10n.investmentsReturnPercent,
                  value: '${portfolio.returnPercent.toStringAsFixed(1)}%',
                  color: gain ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AllocationChart extends StatelessWidget {
  const _AllocationChart({required this.portfolio});

  final InvestmentPortfolioSummary portfolio;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final entries = portfolio.allocationByAssetClass.entries
        .where((entry) => entry.value > 0)
        .toList();
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.investmentsAllocation,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 190,
            child: entries.isEmpty
                ? Center(child: Text(l10n.investmentsNoAllocation))
                : PieChart(
                    PieChartData(
                      centerSpaceRadius: 42,
                      sectionsSpace: 2,
                      sections: [
                        for (var i = 0; i < entries.length; i++)
                          PieChartSectionData(
                            value: entries[i].value.toDouble(),
                            title:
                                '${(entries[i].value / portfolio.totalMarketValueMinor * 100).toStringAsFixed(0)}%',
                            radius: 58,
                            color: _chartColor(i),
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < entries.length; i++)
                FeloChip(
                  label: context.assetClassLabel(entries[i].key),
                  icon: Icons.circle,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoldingCard extends StatelessWidget {
  const _HoldingCard({required this.holding});

  final Investment holding;

  @override
  Widget build(BuildContext context) {
    final gain = holding.profitLossMinor >= 0;
    return FeloCard(
      onTap: () => context.go('/investments/${holding.id}'),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(_assetClassIcon(holding.assetClass)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holding.symbol,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  holding.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatMinorMoney(
                  minor: holding.marketValueMinor,
                  currency: holding.currency,
                ),
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              Text(
                '${holding.returnPercent.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: gain ? Colors.green.shade700 : Colors.red.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.investment});

  final Investment investment;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _MetricTile(
          label: l10n.investmentsMarketValue,
          value: formatMinorMoney(
            minor: investment.marketValueMinor,
            currency: investment.currency,
          ),
        ),
        _MetricTile(
          label: l10n.investmentsLatestPrice,
          value: formatMinorMoney(
            minor: investment.latestPriceMinor,
            currency: investment.currency,
          ),
        ),
        _MetricTile(
          label: l10n.investmentsUnitsLabel,
          value: investment.units.toStringAsFixed(3),
        ),
        _MetricTile(
          label: l10n.investmentsProfitLoss,
          value: formatMinorMoney(
            minor: investment.profitLossMinor,
            currency: investment.currency,
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 132, minHeight: 76),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 4),
              FittedBox(
                alignment: AlignmentDirectional.centerStart,
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrackerOnlyChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FeloChip(
      label: context.l10n.investmentsTrackerOnly,
      icon: Icons.visibility_outlined,
    );
  }
}

extension _InvestmentLabels on BuildContext {
  String assetClassLabel(InvestmentAssetClass assetClass) {
    final l10n = this.l10n;
    return switch (assetClass) {
      InvestmentAssetClass.stockEtf => l10n.investmentsAssetStockEtf,
      InvestmentAssetClass.crypto => l10n.investmentsAssetCrypto,
      InvestmentAssetClass.rrspTfsa => l10n.investmentsAssetRrspTfsa,
      InvestmentAssetClass.retirementAbroad =>
        l10n.investmentsAssetRetirementAbroad,
      InvestmentAssetClass.realEstate => l10n.investmentsAssetRealEstate,
      InvestmentAssetClass.gold => l10n.investmentsAssetGold,
    };
  }
}

IconData _assetClassIcon(InvestmentAssetClass assetClass) {
  return switch (assetClass) {
    InvestmentAssetClass.stockEtf => Icons.show_chart_rounded,
    InvestmentAssetClass.crypto => Icons.currency_bitcoin_rounded,
    InvestmentAssetClass.rrspTfsa => Icons.account_balance_rounded,
    InvestmentAssetClass.retirementAbroad => Icons.public_rounded,
    InvestmentAssetClass.realEstate => Icons.home_work_rounded,
    InvestmentAssetClass.gold => Icons.workspace_premium_rounded,
  };
}

Color _chartColor(int index) {
  // Pulled from FeloColors design tokens — no inline hex values.
  const colors = <Color>[
    FeloColors.lavenderPrimary,
    FeloColors.mintText,
    FeloColors.skyText,
    FeloColors.butterText,
    FeloColors.roseText,
    FeloColors.sageText,
  ];
  return colors[index % colors.length];
}

double? _parseMajor(String value) {
  return double.tryParse(value.replaceAll(RegExp('[^0-9.]'), ''));
}
