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
String _$smsParserRepositoryHash() =>
    r'c5d588692689e4f23aa30b8dbd484d2c204accb4';

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
String _$parsedSmsMessagesHash() => r'b4932b1c0d349b7058ee8ac3ed4e8752ee0454ed';

/// See also [parsedSmsMessages].
@ProviderFor(parsedSmsMessages)
final parsedSmsMessagesProvider = AutoDisposeProvider<List<ParsedSms>>.internal(
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
typedef ParsedSmsMessagesRef = AutoDisposeProviderRef<List<ParsedSms>>;
String _$familyRepositoryHash() => r'18a6e6435d1540e026211bc025ea542654c9a6af';

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
String _$familyMembersHash() => r'3b44542ed724a54d65e5015e6c58ee8592862a4b';

/// See also [familyMembers].
@ProviderFor(familyMembers)
final familyMembersProvider = AutoDisposeProvider<List<FamilyMember>>.internal(
  familyMembers,
  name: r'familyMembersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$familyMembersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FamilyMembersRef = AutoDisposeProviderRef<List<FamilyMember>>;
String _$remittanceRepositoryHash() =>
    r'12dcfe0cc5f7d29ff7b32f84b6085f68c7cc80a0';

/// See also [remittanceRepository].
@ProviderFor(remittanceRepository)
final remittanceRepositoryProvider =
    AutoDisposeProvider<RemittanceRepository>.internal(
      remittanceRepository,
      name: r'remittanceRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remittanceRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemittanceRepositoryRef = AutoDisposeProviderRef<RemittanceRepository>;
String _$remittanceWaitlistHash() =>
    r'fe3db7977253e34c6db88230742bab3c038ea0b6';

/// See also [remittanceWaitlist].
@ProviderFor(remittanceWaitlist)
final remittanceWaitlistProvider =
    AutoDisposeProvider<RemittanceWaitlist>.internal(
      remittanceWaitlist,
      name: r'remittanceWaitlistProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remittanceWaitlistHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemittanceWaitlistRef = AutoDisposeProviderRef<RemittanceWaitlist>;
String _$notificationsRepositoryHash() =>
    r'ae79289c6b69edcfa3f56270f8cce0423a5ff4a1';

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
/// Defaults to [FeloEnv.useFakeData], but tests override this directly so
/// they can exercise the synthesis path without flipping a compile-time
/// constant.
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
String _$receiptCaptureRepositoryHash() =>
    r'86c404c99c4863ad7ed71a19fd816df5f6624265';

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
String _$sendMoneyRepositoryHash() =>
    r'4c04eacb0cc38c24c8d5a434d45787a2d1ca4517';

/// See also [sendMoneyRepository].
@ProviderFor(sendMoneyRepository)
final sendMoneyRepositoryProvider =
    AutoDisposeProvider<SendMoneyRepository>.internal(
      sendMoneyRepository,
      name: r'sendMoneyRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sendMoneyRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendMoneyRepositoryRef = AutoDisposeProviderRef<SendMoneyRepository>;
String _$sendRecipientsHash() => r'aed55196ae9b9c9a16a64c9ae23c77e2cdb57a48';

/// See also [sendRecipients].
@ProviderFor(sendRecipients)
final sendRecipientsProvider =
    AutoDisposeProvider<List<SendRecipient>>.internal(
      sendRecipients,
      name: r'sendRecipientsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sendRecipientsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendRecipientsRef = AutoDisposeProviderRef<List<SendRecipient>>;
String _$notificationInboxHash() => r'c1b4ea31f952378618b2f61a3606acabb707b235';

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
String _$receiptCaptureSessionHash() =>
    r'b75edf77e926dad31fcb3117e29f2d3825893879';

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
String _$sendMoneyFlowHash() => r'6eebc931e69d563833b2e2dfebdc27861838da5c';

/// See also [SendMoneyFlow].
@ProviderFor(SendMoneyFlow)
final sendMoneyFlowProvider =
    AutoDisposeNotifierProvider<SendMoneyFlow, SendMoneyDraft>.internal(
      SendMoneyFlow.new,
      name: r'sendMoneyFlowProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sendMoneyFlowHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SendMoneyFlow = AutoDisposeNotifier<SendMoneyDraft>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
