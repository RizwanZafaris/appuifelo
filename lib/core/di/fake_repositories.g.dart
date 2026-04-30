// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_repositories.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'827d48289fca9ff7300a551270d89129c3b7693f';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$currentUserHash() => r'22223838f939ef05730710e8cb1579ea59b8280e';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<AppUser?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeProviderRef<AppUser?>;
String _$familyRepositoryHash() => r'3a9125ee81bcf304d6a043b91b7e1e2de3f245a3';

/// See also [familyRepository].
@ProviderFor(familyRepository)
final familyRepositoryProvider = AutoDisposeProvider<FamilyRepository>.internal(
  familyRepository,
  name: r'familyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$familyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FamilyRepositoryRef = AutoDisposeProviderRef<FamilyRepository>;
String _$familyGroupsHash() => r'538c0588baf6d52920e0ac5d7a82c571b18057a0';

/// See also [familyGroups].
@ProviderFor(familyGroups)
final familyGroupsProvider =
    AutoDisposeFutureProvider<List<FamilyGroup>>.internal(
      familyGroups,
      name: r'familyGroupsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$familyGroupsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FamilyGroupsRef = AutoDisposeFutureProviderRef<List<FamilyGroup>>;
String _$familyGroupHash() => r'1a6c03e64a238fe170e9777576062418852b23e4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [familyGroup].
@ProviderFor(familyGroup)
const familyGroupProvider = FamilyGroupFamily();

/// See also [familyGroup].
class FamilyGroupFamily extends Family<AsyncValue<FamilyGroup>> {
  /// See also [familyGroup].
  const FamilyGroupFamily();

  /// See also [familyGroup].
  FamilyGroupProvider call(String groupId) {
    return FamilyGroupProvider(groupId);
  }

  @override
  FamilyGroupProvider getProviderOverride(
    covariant FamilyGroupProvider provider,
  ) {
    return call(provider.groupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'familyGroupProvider';
}

/// See also [familyGroup].
class FamilyGroupProvider extends AutoDisposeFutureProvider<FamilyGroup> {
  /// See also [familyGroup].
  FamilyGroupProvider(String groupId)
    : this._internal(
        (ref) => familyGroup(ref as FamilyGroupRef, groupId),
        from: familyGroupProvider,
        name: r'familyGroupProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$familyGroupHash,
        dependencies: FamilyGroupFamily._dependencies,
        allTransitiveDependencies: FamilyGroupFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  FamilyGroupProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<FamilyGroup> Function(FamilyGroupRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FamilyGroupProvider._internal(
        (ref) => create(ref as FamilyGroupRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FamilyGroup> createElement() {
    return _FamilyGroupProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyGroupProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FamilyGroupRef on AutoDisposeFutureProviderRef<FamilyGroup> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _FamilyGroupProviderElement
    extends AutoDisposeFutureProviderElement<FamilyGroup>
    with FamilyGroupRef {
  _FamilyGroupProviderElement(super.provider);

  @override
  String get groupId => (origin as FamilyGroupProvider).groupId;
}

String _$familyMembersHash() => r'e88d2f4e51d3b7de0c16be75a565a1825d156720';

/// See also [familyMembers].
@ProviderFor(familyMembers)
const familyMembersProvider = FamilyMembersFamily();

/// See also [familyMembers].
class FamilyMembersFamily extends Family<AsyncValue<List<FamilyMember>>> {
  /// See also [familyMembers].
  const FamilyMembersFamily();

  /// See also [familyMembers].
  FamilyMembersProvider call(String groupId) {
    return FamilyMembersProvider(groupId);
  }

  @override
  FamilyMembersProvider getProviderOverride(
    covariant FamilyMembersProvider provider,
  ) {
    return call(provider.groupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'familyMembersProvider';
}

/// See also [familyMembers].
class FamilyMembersProvider
    extends AutoDisposeFutureProvider<List<FamilyMember>> {
  /// See also [familyMembers].
  FamilyMembersProvider(String groupId)
    : this._internal(
        (ref) => familyMembers(ref as FamilyMembersRef, groupId),
        from: familyMembersProvider,
        name: r'familyMembersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$familyMembersHash,
        dependencies: FamilyMembersFamily._dependencies,
        allTransitiveDependencies:
            FamilyMembersFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  FamilyMembersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<List<FamilyMember>> Function(FamilyMembersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FamilyMembersProvider._internal(
        (ref) => create(ref as FamilyMembersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FamilyMember>> createElement() {
    return _FamilyMembersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyMembersProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FamilyMembersRef on AutoDisposeFutureProviderRef<List<FamilyMember>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _FamilyMembersProviderElement
    extends AutoDisposeFutureProviderElement<List<FamilyMember>>
    with FamilyMembersRef {
  _FamilyMembersProviderElement(super.provider);

  @override
  String get groupId => (origin as FamilyMembersProvider).groupId;
}

String _$kycRepositoryHash() => r'1eced204d1c38ef8a536db02f7d38fc9b600518a';

/// See also [kycRepository].
@ProviderFor(kycRepository)
final kycRepositoryProvider = AutoDisposeProvider<KycRepository>.internal(
  kycRepository,
  name: r'kycRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$kycRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KycRepositoryRef = AutoDisposeProviderRef<KycRepository>;
String _$kycStatusHash() => r'a505f8a53199004906ad2eec2ae23cb6a66e3ff1';

/// See also [kycStatus].
@ProviderFor(kycStatus)
final kycStatusProvider = AutoDisposeFutureProvider<KycStatus>.internal(
  kycStatus,
  name: r'kycStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$kycStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KycStatusRef = AutoDisposeFutureProviderRef<KycStatus>;
String _$receiptCaptureRepositoryHash() =>
    r'bdf5616339f8063a484e84095e4a55c1fae05685';

/// See also [receiptCaptureRepository].
@ProviderFor(receiptCaptureRepository)
final receiptCaptureRepositoryProvider =
    AutoDisposeProvider<ReceiptCaptureRepository>.internal(
      receiptCaptureRepository,
      name: r'receiptCaptureRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$receiptCaptureRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReceiptCaptureRepositoryRef =
    AutoDisposeProviderRef<ReceiptCaptureRepository>;
String _$smsParserRepositoryHash() =>
    r'337681db2dfafeda3b4e5f902c56b18fa2fd2797';

/// See also [smsParserRepository].
@ProviderFor(smsParserRepository)
final smsParserRepositoryProvider =
    AutoDisposeProvider<SmsParserRepository>.internal(
      smsParserRepository,
      name: r'smsParserRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$smsParserRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SmsParserRepositoryRef = AutoDisposeProviderRef<SmsParserRepository>;
String _$parsedSmsMessagesHash() => r'19717264396933fcb79d0d840afb228d70d448de';

/// See also [parsedSmsMessages].
@ProviderFor(parsedSmsMessages)
final parsedSmsMessagesProvider =
    AutoDisposeFutureProvider<List<ParsedSms>>.internal(
      parsedSmsMessages,
      name: r'parsedSmsMessagesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$parsedSmsMessagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ParsedSmsMessagesRef = AutoDisposeFutureProviderRef<List<ParsedSms>>;
String _$notificationsRepositoryHash() =>
    r'e765e52cf99b4d9f1256914585c0b845107536ca';

/// See also [notificationsRepository].
@ProviderFor(notificationsRepository)
final notificationsRepositoryProvider =
    AutoDisposeProvider<NotificationsRepository>.internal(
      notificationsRepository,
      name: r'notificationsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationsRepositoryRef =
    AutoDisposeProviderRef<NotificationsRepository>;
String _$liveNotificationsHash() => r'670d23d749adc8b626377e976c446fd7e26fd326';

/// Live notifications fetcher — only used in non-fake mode.
///
/// Copied from [liveNotifications].
@ProviderFor(liveNotifications)
final liveNotificationsProvider =
    AutoDisposeFutureProvider<List<FeloNotification>>.internal(
      liveNotifications,
      name: r'liveNotificationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$liveNotificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LiveNotificationsRef =
    AutoDisposeFutureProviderRef<List<FeloNotification>>;
String _$useFakeNotificationsSourceHash() =>
    r'568ec408e00ba5434eb82a56a75de7c3700a24f4';

/// Source-of-truth selector for the notifications inbox.
///
/// Copied from [useFakeNotificationsSource].
@ProviderFor(useFakeNotificationsSource)
final useFakeNotificationsSourceProvider = AutoDisposeProvider<bool>.internal(
  useFakeNotificationsSource,
  name: r'useFakeNotificationsSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$useFakeNotificationsSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UseFakeNotificationsSourceRef = AutoDisposeProviderRef<bool>;
String _$filteredNotificationsHash() =>
    r'2de35a33424a34f08ca8ae69b210c352e7da602c';

/// See also [filteredNotifications].
@ProviderFor(filteredNotifications)
final filteredNotificationsProvider =
    AutoDisposeProvider<List<FeloNotification>>.internal(
      filteredNotifications,
      name: r'filteredNotificationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredNotificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredNotificationsRef =
    AutoDisposeProviderRef<List<FeloNotification>>;
String _$unreadNotificationCountHash() =>
    r'7076ffc9783ce65f987d9d6fc3d574318591ea9f';

/// See also [unreadNotificationCount].
@ProviderFor(unreadNotificationCount)
final unreadNotificationCountProvider = AutoDisposeProvider<int>.internal(
  unreadNotificationCount,
  name: r'unreadNotificationCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadNotificationCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadNotificationCountRef = AutoDisposeProviderRef<int>;
String _$imagePickerHash() => r'320373cd7a3964d1cabeb291795bcfcd6e7d4267';

/// See also [imagePicker].
@ProviderFor(imagePicker)
final imagePickerProvider = AutoDisposeProvider<ImagePicker>.internal(
  imagePicker,
  name: r'imagePickerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imagePickerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ImagePickerRef = AutoDisposeProviderRef<ImagePicker>;
String _$receiptCaptureSessionHash() =>
    r'ebbf1c4671d2523f3a8fdf3572950185dbe27927';

abstract class _$ReceiptCaptureSession
    extends BuildlessAutoDisposeNotifier<ReceiptCaptureState> {
  late final String transactionId;

  ReceiptCaptureState build(String transactionId);
}

/// See also [ReceiptCaptureSession].
@ProviderFor(ReceiptCaptureSession)
const receiptCaptureSessionProvider = ReceiptCaptureSessionFamily();

/// See also [ReceiptCaptureSession].
class ReceiptCaptureSessionFamily extends Family<ReceiptCaptureState> {
  /// See also [ReceiptCaptureSession].
  const ReceiptCaptureSessionFamily();

  /// See also [ReceiptCaptureSession].
  ReceiptCaptureSessionProvider call(String transactionId) {
    return ReceiptCaptureSessionProvider(transactionId);
  }

  @override
  ReceiptCaptureSessionProvider getProviderOverride(
    covariant ReceiptCaptureSessionProvider provider,
  ) {
    return call(provider.transactionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'receiptCaptureSessionProvider';
}

/// See also [ReceiptCaptureSession].
class ReceiptCaptureSessionProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ReceiptCaptureSession,
          ReceiptCaptureState
        > {
  /// See also [ReceiptCaptureSession].
  ReceiptCaptureSessionProvider(String transactionId)
    : this._internal(
        () => ReceiptCaptureSession()..transactionId = transactionId,
        from: receiptCaptureSessionProvider,
        name: r'receiptCaptureSessionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$receiptCaptureSessionHash,
        dependencies: ReceiptCaptureSessionFamily._dependencies,
        allTransitiveDependencies:
            ReceiptCaptureSessionFamily._allTransitiveDependencies,
        transactionId: transactionId,
      );

  ReceiptCaptureSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.transactionId,
  }) : super.internal();

  final String transactionId;

  @override
  ReceiptCaptureState runNotifierBuild(
    covariant ReceiptCaptureSession notifier,
  ) {
    return notifier.build(transactionId);
  }

  @override
  Override overrideWith(ReceiptCaptureSession Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReceiptCaptureSessionProvider._internal(
        () => create()..transactionId = transactionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        transactionId: transactionId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ReceiptCaptureSession, ReceiptCaptureState>
  createElement() {
    return _ReceiptCaptureSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReceiptCaptureSessionProvider &&
        other.transactionId == transactionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, transactionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReceiptCaptureSessionRef
    on AutoDisposeNotifierProviderRef<ReceiptCaptureState> {
  /// The parameter `transactionId` of this provider.
  String get transactionId;
}

class _ReceiptCaptureSessionProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ReceiptCaptureSession,
          ReceiptCaptureState
        >
    with ReceiptCaptureSessionRef {
  _ReceiptCaptureSessionProviderElement(super.provider);

  @override
  String get transactionId =>
      (origin as ReceiptCaptureSessionProvider).transactionId;
}

String _$notificationInboxHash() => r'aa7f7f6c4586a1d0fbf38fc3f08a2d1a93bae48d';

/// See also [NotificationInbox].
@ProviderFor(NotificationInbox)
final notificationInboxProvider =
    AutoDisposeNotifierProvider<
      NotificationInbox,
      List<FeloNotification>
    >.internal(
      NotificationInbox.new,
      name: r'notificationInboxProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationInboxHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationInbox = AutoDisposeNotifier<List<FeloNotification>>;
String _$notificationFilterHash() =>
    r'183f1a544333ef05f9b07dd0fafbaa9da31ed393';

/// See also [NotificationFilter].
@ProviderFor(NotificationFilter)
final notificationFilterProvider =
    AutoDisposeNotifierProvider<
      NotificationFilter,
      FeloNotificationFilter
    >.internal(
      NotificationFilter.new,
      name: r'notificationFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationFilter = AutoDisposeNotifier<FeloNotificationFilter>;
String _$accountConnectFlowHash() =>
    r'4040dcf4cba3241fc3721eeecccb3d909ba9d063';

/// See also [AccountConnectFlow].
@ProviderFor(AccountConnectFlow)
final accountConnectFlowProvider =
    AutoDisposeNotifierProvider<
      AccountConnectFlow,
      AccountConnectState
    >.internal(
      AccountConnectFlow.new,
      name: r'accountConnectFlowProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountConnectFlowHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AccountConnectFlow = AutoDisposeNotifier<AccountConnectState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
