// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionsRepositoryHash() =>
    r'34ac19e1242760b90badc464dccab92810100558';

/// See also [transactionsRepository].
@ProviderFor(transactionsRepository)
final transactionsRepositoryProvider =
    AutoDisposeProvider<TransactionsRepository>.internal(
      transactionsRepository,
      name: r'transactionsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionsRepositoryRef =
    AutoDisposeProviderRef<TransactionsRepository>;
String _$transactionsListHash() => r'7e6278cfe2c9bdf3c596d7bf309c0bc33f1712e1';

/// Convenience read-only async provider that mirrors `Transactions.build`.
/// Many screens just want the list and shouldn't depend on the notifier
/// surface.
///
/// Copied from [transactionsList].
@ProviderFor(transactionsList)
final transactionsListProvider =
    AutoDisposeFutureProvider<List<FeloTransaction>>.internal(
      transactionsList,
      name: r'transactionsListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionsListRef =
    AutoDisposeFutureProviderRef<List<FeloTransaction>>;
String _$transactionsHash() => r'182ae5e5ab2481fb64d44a35eddc12e89344754c';

/// Async transactions notifier. Exposes `attachReceipt()` for the receipt
/// capture flow that previously mutated state directly.
///
/// Copied from [Transactions].
@ProviderFor(Transactions)
final transactionsProvider =
    AutoDisposeAsyncNotifierProvider<
      Transactions,
      List<FeloTransaction>
    >.internal(
      Transactions.new,
      name: r'transactionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Transactions = AutoDisposeAsyncNotifier<List<FeloTransaction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
