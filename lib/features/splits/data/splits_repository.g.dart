// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splits_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$splitsRepositoryHash() => r'f874f24cf70ef4e2609dbb16b95480b162eddc4c';

/// See also [splitsRepository].
@ProviderFor(splitsRepository)
final splitsRepositoryProvider = AutoDisposeProvider<SplitsRepository>.internal(
  splitsRepository,
  name: r'splitsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$splitsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SplitsRepositoryRef = AutoDisposeProviderRef<SplitsRepository>;
String _$splitsHash() => r'58bb03699ca9d50010c536a9d2d8ed09d08a29ff';

/// Async splits notifier — replaces sync `Splits` notifier.
///
/// Copied from [Splits].
@ProviderFor(Splits)
final splitsProvider =
    AutoDisposeAsyncNotifierProvider<Splits, List<Split>>.internal(
      Splits.new,
      name: r'splitsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$splitsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Splits = AutoDisposeAsyncNotifier<List<Split>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
