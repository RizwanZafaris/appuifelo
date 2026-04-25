// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investments_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$investmentPortfolioHash() =>
    r'ed5251b43919ded95200ac997b64e84b6e8fb84d';

/// Aggregated portfolio summary from `/v1/investments/portfolio`.
///
/// Copied from [investmentPortfolio].
@ProviderFor(investmentPortfolio)
final investmentPortfolioProvider =
    AutoDisposeFutureProvider<InvestmentPortfolioSummary>.internal(
      investmentPortfolio,
      name: r'investmentPortfolioProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$investmentPortfolioHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InvestmentPortfolioRef =
    AutoDisposeFutureProviderRef<InvestmentPortfolioSummary>;
String _$investmentsHash() => r'a4e08ffc93a1546e252423bb9b51a802c7891ae9';

/// Investments inbox — reads from `/v1/investments` and exposes
/// CRUD + manual price refresh. Wired to FeloApiClient.
///
/// Copied from [Investments].
@ProviderFor(Investments)
final investmentsProvider =
    AutoDisposeAsyncNotifierProvider<Investments, List<Investment>>.internal(
      Investments.new,
      name: r'investmentsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$investmentsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Investments = AutoDisposeAsyncNotifier<List<Investment>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
