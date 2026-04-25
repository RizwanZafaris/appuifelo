// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountsRepositoryHash() =>
    r'b663e62dbf04863f9a842834cb94cddc415aa0d5';

/// See also [accountsRepository].
@ProviderFor(accountsRepository)
final accountsRepositoryProvider =
    AutoDisposeProvider<AccountsRepository>.internal(
      accountsRepository,
      name: r'accountsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccountsRepositoryRef = AutoDisposeProviderRef<AccountsRepository>;
String _$accountsHash() => r'f4fbbed615fd7d8f5d10bc41ac3e523d0cd28954';

/// Async accounts notifier.
///
/// Replaces the old sync `Accounts` notifier in fake_repositories.dart.
/// `connect()` and `disconnect()` are now `Future<void>` — callers must
/// await before navigating away.
///
/// Copied from [Accounts].
@ProviderFor(Accounts)
final accountsProvider =
    AutoDisposeAsyncNotifierProvider<Accounts, List<FeloAccount>>.internal(
      Accounts.new,
      name: r'accountsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Accounts = AutoDisposeAsyncNotifier<List<FeloAccount>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
