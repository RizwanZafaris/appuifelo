// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goalsRepositoryHash() => r'ebca9faac4261b5d5f59ad029f7c0095ff9d8c45';

/// See also [goalsRepository].
@ProviderFor(goalsRepository)
final goalsRepositoryProvider = AutoDisposeProvider<GoalsRepository>.internal(
  goalsRepository,
  name: r'goalsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$goalsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoalsRepositoryRef = AutoDisposeProviderRef<GoalsRepository>;
String _$goalsHash() => r'a2e648b17b2948a63f03d420fe12ef77222247ea';

/// Async list provider — replaces the old sync `goalsProvider`.
///
/// Copied from [goals].
@ProviderFor(goals)
final goalsProvider = AutoDisposeFutureProvider<List<Goal>>.internal(
  goals,
  name: r'goalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$goalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoalsRef = AutoDisposeFutureProviderRef<List<Goal>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
