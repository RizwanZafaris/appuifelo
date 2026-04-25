// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_extension_screens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$spendingInsightsHash() => r'69b242b376b12f5a356bd186fbbc19f68b1cefc0';

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

/// See also [spendingInsights].
@ProviderFor(spendingInsights)
const spendingInsightsProvider = SpendingInsightsFamily();

/// See also [spendingInsights].
class SpendingInsightsFamily extends Family<AsyncValue<SpendingInsights>> {
  /// See also [spendingInsights].
  const SpendingInsightsFamily();

  /// See also [spendingInsights].
  SpendingInsightsProvider call(InsightsPeriod period) {
    return SpendingInsightsProvider(period);
  }

  @override
  SpendingInsightsProvider getProviderOverride(
    covariant SpendingInsightsProvider provider,
  ) {
    return call(provider.period);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'spendingInsightsProvider';
}

/// See also [spendingInsights].
class SpendingInsightsProvider
    extends AutoDisposeFutureProvider<SpendingInsights> {
  /// See also [spendingInsights].
  SpendingInsightsProvider(InsightsPeriod period)
    : this._internal(
        (ref) => spendingInsights(ref as SpendingInsightsRef, period),
        from: spendingInsightsProvider,
        name: r'spendingInsightsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$spendingInsightsHash,
        dependencies: SpendingInsightsFamily._dependencies,
        allTransitiveDependencies:
            SpendingInsightsFamily._allTransitiveDependencies,
        period: period,
      );

  SpendingInsightsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
  }) : super.internal();

  final InsightsPeriod period;

  @override
  Override overrideWith(
    FutureOr<SpendingInsights> Function(SpendingInsightsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SpendingInsightsProvider._internal(
        (ref) => create(ref as SpendingInsightsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SpendingInsights> createElement() {
    return _SpendingInsightsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SpendingInsightsProvider && other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SpendingInsightsRef on AutoDisposeFutureProviderRef<SpendingInsights> {
  /// The parameter `period` of this provider.
  InsightsPeriod get period;
}

class _SpendingInsightsProviderElement
    extends AutoDisposeFutureProviderElement<SpendingInsights>
    with SpendingInsightsRef {
  _SpendingInsightsProviderElement(super.provider);

  @override
  InsightsPeriod get period => (origin as SpendingInsightsProvider).period;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
