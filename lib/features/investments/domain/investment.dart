// ignore_for_file: sort_constructors_first

import 'package:collection/collection.dart';

enum InvestmentAssetClass {
  stockEtf,
  crypto,
  rrspTfsa,
  retirementAbroad,
  realEstate,
  gold,
}

extension InvestmentAssetClassJson on InvestmentAssetClass {
  String get wireName => switch (this) {
    InvestmentAssetClass.stockEtf => 'stock_etf',
    InvestmentAssetClass.crypto => 'crypto',
    InvestmentAssetClass.rrspTfsa => 'rrsp_tfsa',
    InvestmentAssetClass.retirementAbroad => 'retirement_abroad',
    InvestmentAssetClass.realEstate => 'real_estate',
    InvestmentAssetClass.gold => 'gold',
  };

  static InvestmentAssetClass fromJson(Object? value) {
    final normalized = value.toString().toLowerCase();
    return InvestmentAssetClass.values.firstWhereOrNull(
          (assetClass) =>
              assetClass.wireName == normalized ||
              assetClass.name.toLowerCase() == normalized,
        ) ??
        InvestmentAssetClass.stockEtf;
  }
}

class Investment {
  const Investment({
    required this.id,
    required this.symbol,
    required this.name,
    required this.assetClass,
    required this.currency,
    required this.units,
    required this.costBasisMinor,
    required this.latestPriceMinor,
    required this.marketValueMinor,
    required this.notes,
    required this.updatedAt,
    this.archived = false,
  });

  final String id;
  final String symbol;
  final String name;
  final InvestmentAssetClass assetClass;
  final String currency;
  final double units;
  final int costBasisMinor;
  final int latestPriceMinor;
  final int marketValueMinor;
  final String notes;
  final DateTime updatedAt;
  final bool archived;

  int get profitLossMinor => marketValueMinor - costBasisMinor;

  double get returnPercent =>
      costBasisMinor == 0 ? 0 : profitLossMinor / costBasisMinor * 100;

  Investment copyWith({
    String? id,
    String? symbol,
    String? name,
    InvestmentAssetClass? assetClass,
    String? currency,
    double? units,
    int? costBasisMinor,
    int? latestPriceMinor,
    int? marketValueMinor,
    String? notes,
    DateTime? updatedAt,
    bool? archived,
  }) {
    return Investment(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      assetClass: assetClass ?? this.assetClass,
      currency: currency ?? this.currency,
      units: units ?? this.units,
      costBasisMinor: costBasisMinor ?? this.costBasisMinor,
      latestPriceMinor: latestPriceMinor ?? this.latestPriceMinor,
      marketValueMinor: marketValueMinor ?? this.marketValueMinor,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
      archived: archived ?? this.archived,
    );
  }

  factory Investment.fromJson(Map<String, Object?> json) {
    final units = _doubleFrom(json['units'] ?? json['quantity']);
    final latestPriceMinor = _intFrom(
      json['latest_price_minor'] ?? json['latestPriceMinor'],
    );
    final marketValueMinor =
        _intFrom(json['market_value_minor'] ?? json['marketValueMinor']) ??
        (units * (latestPriceMinor ?? 0)).round();
    return Investment(
      id: json['id'].toString(),
      symbol: (json['symbol'] ?? '').toString(),
      name: (json['name'] ?? json['display_name'] ?? '').toString(),
      assetClass: InvestmentAssetClassJson.fromJson(
        json['asset_class'] ?? json['assetClass'],
      ),
      currency: (json['currency'] ?? 'CAD').toString(),
      units: units,
      costBasisMinor:
          _intFrom(json['cost_basis_minor'] ?? json['costBasisMinor']) ?? 0,
      latestPriceMinor: latestPriceMinor ?? 0,
      marketValueMinor: marketValueMinor,
      notes: (json['notes'] ?? '').toString(),
      updatedAt:
          DateTime.tryParse(
            (json['updated_at'] ?? json['updatedAt'] ?? '').toString(),
          ) ??
          DateTime.now(),
      archived: json['archived'] == true,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'assetClass': assetClass.wireName,
      'currency': currency,
      'units': units,
      'costBasisMinor': costBasisMinor,
      'latestPriceMinor': latestPriceMinor,
      'marketValueMinor': marketValueMinor,
      'notes': notes,
      'updatedAt': updatedAt.toIso8601String(),
      'archived': archived,
    };
  }
}

class InvestmentPortfolioSummary {
  const InvestmentPortfolioSummary({
    required this.totalMarketValueMinor,
    required this.totalProfitLossMinor,
    required this.returnPercent,
    required this.allocationByAssetClass,
  });

  final int totalMarketValueMinor;
  final int totalProfitLossMinor;
  final double returnPercent;
  final Map<InvestmentAssetClass, int> allocationByAssetClass;

  factory InvestmentPortfolioSummary.fromHoldings(List<Investment> holdings) {
    final active = holdings.where((holding) => !holding.archived);
    var totalMarketValueMinor = 0;
    var totalCostBasisMinor = 0;
    final allocation = <InvestmentAssetClass, int>{};

    for (final holding in active) {
      totalMarketValueMinor += holding.marketValueMinor;
      totalCostBasisMinor += holding.costBasisMinor;
      allocation.update(
        holding.assetClass,
        (value) => value + holding.marketValueMinor,
        ifAbsent: () => holding.marketValueMinor,
      );
    }

    final totalProfitLossMinor = totalMarketValueMinor - totalCostBasisMinor;
    return InvestmentPortfolioSummary(
      totalMarketValueMinor: totalMarketValueMinor,
      totalProfitLossMinor: totalProfitLossMinor,
      returnPercent: totalCostBasisMinor == 0
          ? 0
          : totalProfitLossMinor / totalCostBasisMinor * 100,
      allocationByAssetClass: allocation,
    );
  }

  factory InvestmentPortfolioSummary.fromJson(Map<String, Object?> json) {
    final allocationJson =
        (json['allocation_by_asset_class'] ?? json['allocationByAssetClass'])
            as Map<String, Object?>?;
    return InvestmentPortfolioSummary(
      totalMarketValueMinor:
          _intFrom(
            json['total_market_value_minor'] ?? json['totalMarketValueMinor'],
          ) ??
          0,
      totalProfitLossMinor:
          _intFrom(
            json['total_profit_loss_minor'] ?? json['totalProfitLossMinor'],
          ) ??
          0,
      returnPercent: _doubleFrom(
        json['return_percent'] ?? json['returnPercent'],
      ),
      allocationByAssetClass: {
        if (allocationJson != null)
          for (final entry in allocationJson.entries)
            InvestmentAssetClassJson.fromJson(entry.key):
                _intFrom(entry.value) ?? 0,
      },
    );
  }
}

int? _intFrom(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.round();
  }
  return int.tryParse(value?.toString() ?? '');
}

double _doubleFrom(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  return double.tryParse(value?.toString() ?? '') ?? 0;
}
