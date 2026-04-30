// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remittance_notebook_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remittanceNotebookRepositoryHash() =>
    r'1b519b91e7357acc0ac992e068c827f48f7feee2';

/// See also [remittanceNotebookRepository].
@ProviderFor(remittanceNotebookRepository)
final remittanceNotebookRepositoryProvider =
    AutoDisposeProvider<RemittanceNotebookRepository>.internal(
      remittanceNotebookRepository,
      name: r'remittanceNotebookRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remittanceNotebookRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemittanceNotebookRepositoryRef =
    AutoDisposeProviderRef<RemittanceNotebookRepository>;
String _$remittanceEntriesHash() => r'fd9be77a8295bb47c41a1c837d6bd794c5e2dc43';

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

/// See also [remittanceEntries].
@ProviderFor(remittanceEntries)
const remittanceEntriesProvider = RemittanceEntriesFamily();

/// See also [remittanceEntries].
class RemittanceEntriesFamily
    extends Family<AsyncValue<List<RemittanceEntry>>> {
  /// See also [remittanceEntries].
  const RemittanceEntriesFamily();

  /// See also [remittanceEntries].
  RemittanceEntriesProvider call({String? status}) {
    return RemittanceEntriesProvider(status: status);
  }

  @override
  RemittanceEntriesProvider getProviderOverride(
    covariant RemittanceEntriesProvider provider,
  ) {
    return call(status: provider.status);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'remittanceEntriesProvider';
}

/// See also [remittanceEntries].
class RemittanceEntriesProvider
    extends AutoDisposeFutureProvider<List<RemittanceEntry>> {
  /// See also [remittanceEntries].
  RemittanceEntriesProvider({String? status})
    : this._internal(
        (ref) => remittanceEntries(ref as RemittanceEntriesRef, status: status),
        from: remittanceEntriesProvider,
        name: r'remittanceEntriesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$remittanceEntriesHash,
        dependencies: RemittanceEntriesFamily._dependencies,
        allTransitiveDependencies:
            RemittanceEntriesFamily._allTransitiveDependencies,
        status: status,
      );

  RemittanceEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String? status;

  @override
  Override overrideWith(
    FutureOr<List<RemittanceEntry>> Function(RemittanceEntriesRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemittanceEntriesProvider._internal(
        (ref) => create(ref as RemittanceEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RemittanceEntry>> createElement() {
    return _RemittanceEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemittanceEntriesProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemittanceEntriesRef
    on AutoDisposeFutureProviderRef<List<RemittanceEntry>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _RemittanceEntriesProviderElement
    extends AutoDisposeFutureProviderElement<List<RemittanceEntry>>
    with RemittanceEntriesRef {
  _RemittanceEntriesProviderElement(super.provider);

  @override
  String? get status => (origin as RemittanceEntriesProvider).status;
}

String _$remittanceSummaryHash() => r'915166e75471f6d793994992ce760d7f44493347';

/// See also [remittanceSummary].
@ProviderFor(remittanceSummary)
final remittanceSummaryProvider =
    AutoDisposeFutureProvider<RemittanceSummary>.internal(
      remittanceSummary,
      name: r'remittanceSummaryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remittanceSummaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemittanceSummaryRef = AutoDisposeFutureProviderRef<RemittanceSummary>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
