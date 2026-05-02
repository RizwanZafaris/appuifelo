// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_notifications_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$liveNotificationsServiceHash() =>
    r'0cc06ad702d6c6ea914aba5dd487dc51c14b5702';

/// Thin facade over backend `/v1/notifications` and `/v1/devices` routes.
///
/// The existing `notificationInboxProvider` continues to model the
/// rich `FeloNotification` union types for the UI. This service is what
/// the inbox calls when the user marks something read or archives it,
/// so the backend stays in sync with the optimistic local state.
///
/// Copied from [LiveNotificationsService].
@ProviderFor(LiveNotificationsService)
final liveNotificationsServiceProvider =
    AutoDisposeAsyncNotifierProvider<LiveNotificationsService, void>.internal(
      LiveNotificationsService.new,
      name: r'liveNotificationsServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$liveNotificationsServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LiveNotificationsService = AutoDisposeAsyncNotifier<void>;
String _$deviceRegistrationHash() =>
    r'd868c0361d9e7bc5c5698b26fc7361a4dc640be2';

/// Registers the current device so the backend can target push later.
/// Idempotent — safe to call on every app launch.
///
/// Copied from [DeviceRegistration].
@ProviderFor(DeviceRegistration)
final deviceRegistrationProvider =
    AutoDisposeAsyncNotifierProvider<DeviceRegistration, void>.internal(
      DeviceRegistration.new,
      name: r'deviceRegistrationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deviceRegistrationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DeviceRegistration = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
