import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/investments/domain/investment.dart';

part 'investments_repository.g.dart';

/// Investments inbox — reads from `/v1/investments` and exposes
/// CRUD + manual price refresh. Wired to FeloApiClient.
@riverpod
class Investments extends _$Investments {
  @override
  Future<List<Investment>> build() async {
    final api = ref.watch(feloApiClientProvider);
    final raw = await api.listInvestments();
    final list = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return list
        .map((m) => Investment.fromJson(m.cast<String, Object?>()))
        .toList(growable: false);
  }

  Future<Investment> create({
    required String symbol,
    required String name,
    required InvestmentAssetClass assetClass,
    required String currency,
    required double units,
    required int costBasisMinor,
    String? notes,
  }) async {
    final raw = await ref.read(feloApiClientProvider).createInvestment({
      'symbol': symbol,
      'name': name,
      'assetClass': assetClass.wireName,
      'currency': currency,
      'units': units.toString(),
      'costBasisMinor': costBasisMinor,
      if (notes != null && notes.isNotEmpty) 'notes': notes,
    });
    final json = (raw as Map?)?.cast<String, Object?>() ?? const {};
    final created = Investment.fromJson(json);
    ref.invalidateSelf();
    return created;
  }

  Future<void> updatePrice({
    required String investmentId,
    required int priceMinor,
  }) async {
    await ref
        .read(feloApiClientProvider)
        .updateInvestment(investmentId, {'lastPriceMinor': priceMinor});
    ref.invalidateSelf();
  }

  Future<void> archive(String id) async {
    await ref.read(feloApiClientProvider).archiveInvestment(id);
    ref.invalidateSelf();
  }

  Future<void> refresh() async => ref.invalidateSelf();
}

/// Aggregated portfolio summary from `/v1/investments/portfolio`.
@riverpod
Future<InvestmentPortfolioSummary> investmentPortfolio(
  InvestmentPortfolioRef ref,
) async {
  final api = ref.watch(feloApiClientProvider);
  final raw = await api.getInvestmentPortfolio();
  final json = (raw as Map?)?.cast<String, Object?>() ?? const {};
  return InvestmentPortfolioSummary.fromJson(json);
}
