// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budgets_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$budgetsRepositoryHash() => r'bd3d2af654b3045fab9a2a64b1a6052143858c94';

/// See also [budgetsRepository].
@ProviderFor(budgetsRepository)
final budgetsRepositoryProvider =
    AutoDisposeProvider<BudgetsRepository>.internal(
      budgetsRepository,
      name: r'budgetsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$budgetsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BudgetsRepositoryRef = AutoDisposeProviderRef<BudgetsRepository>;
String _$budgetsHash() => r'4a7bd83dc340d0f3f309ace39ee87b69f5f19f0e';

/// Async list provider — replaces the old sync `budgetsProvider`.
///
/// Copied from [budgets].
@ProviderFor(budgets)
final budgetsProvider = AutoDisposeFutureProvider<List<Budget>>.internal(
  budgets,
  name: r'budgetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$budgetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BudgetsRef = AutoDisposeFutureProviderRef<List<Budget>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
