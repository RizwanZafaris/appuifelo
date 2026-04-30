// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_close_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthlyCloseHash() => r'3336626f65eff336f148c19a042ac798db943145';

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

/// See also [monthlyClose].
@ProviderFor(monthlyClose)
const monthlyCloseProvider = MonthlyCloseFamily();

/// See also [monthlyClose].
class MonthlyCloseFamily extends Family<AsyncValue<dynamic>> {
  /// See also [monthlyClose].
  const MonthlyCloseFamily();

  /// See also [monthlyClose].
  MonthlyCloseProvider call(int year, int month) {
    return MonthlyCloseProvider(year, month);
  }

  @override
  MonthlyCloseProvider getProviderOverride(
    covariant MonthlyCloseProvider provider,
  ) {
    return call(provider.year, provider.month);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthlyCloseProvider';
}

/// See also [monthlyClose].
class MonthlyCloseProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [monthlyClose].
  MonthlyCloseProvider(int year, int month)
    : this._internal(
        (ref) => monthlyClose(ref as MonthlyCloseRef, year, month),
        from: monthlyCloseProvider,
        name: r'monthlyCloseProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$monthlyCloseHash,
        dependencies: MonthlyCloseFamily._dependencies,
        allTransitiveDependencies:
            MonthlyCloseFamily._allTransitiveDependencies,
        year: year,
        month: month,
      );

  MonthlyCloseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(MonthlyCloseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyCloseProvider._internal(
        (ref) => create(ref as MonthlyCloseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _MonthlyCloseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyCloseProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthlyCloseRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _MonthlyCloseProviderElement
    extends AutoDisposeFutureProviderElement<dynamic>
    with MonthlyCloseRef {
  _MonthlyCloseProviderElement(super.provider);

  @override
  int get year => (origin as MonthlyCloseProvider).year;
  @override
  int get month => (origin as MonthlyCloseProvider).month;
}

String _$monthlyChecklistHash() => r'3a46837a61b3216ce6c03a7c7510effff5da048a';

/// See also [monthlyChecklist].
@ProviderFor(monthlyChecklist)
const monthlyChecklistProvider = MonthlyChecklistFamily();

/// See also [monthlyChecklist].
class MonthlyChecklistFamily extends Family<AsyncValue<List<dynamic>>> {
  /// See also [monthlyChecklist].
  const MonthlyChecklistFamily();

  /// See also [monthlyChecklist].
  MonthlyChecklistProvider call(int year, int month) {
    return MonthlyChecklistProvider(year, month);
  }

  @override
  MonthlyChecklistProvider getProviderOverride(
    covariant MonthlyChecklistProvider provider,
  ) {
    return call(provider.year, provider.month);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthlyChecklistProvider';
}

/// See also [monthlyChecklist].
class MonthlyChecklistProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
  /// See also [monthlyChecklist].
  MonthlyChecklistProvider(int year, int month)
    : this._internal(
        (ref) => monthlyChecklist(ref as MonthlyChecklistRef, year, month),
        from: monthlyChecklistProvider,
        name: r'monthlyChecklistProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$monthlyChecklistHash,
        dependencies: MonthlyChecklistFamily._dependencies,
        allTransitiveDependencies:
            MonthlyChecklistFamily._allTransitiveDependencies,
        year: year,
        month: month,
      );

  MonthlyChecklistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<dynamic>> Function(MonthlyChecklistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyChecklistProvider._internal(
        (ref) => create(ref as MonthlyChecklistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<dynamic>> createElement() {
    return _MonthlyChecklistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyChecklistProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthlyChecklistRef on AutoDisposeFutureProviderRef<List<dynamic>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _MonthlyChecklistProviderElement
    extends AutoDisposeFutureProviderElement<List<dynamic>>
    with MonthlyChecklistRef {
  _MonthlyChecklistProviderElement(super.provider);

  @override
  int get year => (origin as MonthlyChecklistProvider).year;
  @override
  int get month => (origin as MonthlyChecklistProvider).month;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
