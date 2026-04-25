// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$billsRepositoryHash() => r'9b66d8aa662230ff16561619818226bc34cf68b2';

/// See also [billsRepository].
@ProviderFor(billsRepository)
final billsRepositoryProvider = AutoDisposeProvider<BillsRepository>.internal(
  billsRepository,
  name: r'billsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$billsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BillsRepositoryRef = AutoDisposeProviderRef<BillsRepository>;
String _$billsHash() => r'92851339d2e1706228be6239476ccb07480af8c8';

/// Async bills notifier — replaces sync `Bills` notifier in fake_repositories.
///
/// Copied from [Bills].
@ProviderFor(Bills)
final billsProvider =
    AutoDisposeAsyncNotifierProvider<Bills, List<Bill>>.internal(
      Bills.new,
      name: r'billsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$billsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Bills = AutoDisposeAsyncNotifier<List<Bill>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
