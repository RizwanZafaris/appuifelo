// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'e81690433d3e46a5ffb9bde4775f0fb2f92dc199';

/// See also [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider =
    AutoDisposeProvider<ProfileRepository>.internal(
      profileRepository,
      name: r'profileRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepositoryRef = AutoDisposeProviderRef<ProfileRepository>;
String _$profileSettingsNotifierHash() =>
    r'c1ecabb28691895e9c4859ad51fd80c8fc44ced5';

/// Async profile settings notifier.
///
/// Replaces the old sync `profileSettings` provider in `fake_repositories`.
/// `update*()` methods are `Future<void>` — callers should await before
/// navigating away.
///
/// Copied from [ProfileSettingsNotifier].
@ProviderFor(ProfileSettingsNotifier)
final profileSettingsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      ProfileSettingsNotifier,
      ProfileSettings
    >.internal(
      ProfileSettingsNotifier.new,
      name: r'profileSettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileSettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileSettingsNotifier = AutoDisposeAsyncNotifier<ProfileSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
