import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/budgets/domain/budget.dart';

part 'budgets_repository.g.dart';

/// Backend-shape budget contract.
///
/// `ApiBudgetsRepository` talks to NestJS at `/v1/budgets` (Drizzle-backed).
/// `FakeBudgetsRepository` keeps the Phase-1 demo data alive when running
/// `--dart-define=FELO_USE_FAKE_DATA=true` so designers / reviewers can run
/// the app without standing up the backend.
abstract class BudgetsRepository {
  Future<List<Budget>> list();
  Future<Budget> create({
    required String category,
    required String currency,
    required int limitMinor,
    required BudgetPeriod period,
    bool rolloverEnabled = false,
    int alertThresholdPercent = 80,
    DateTime? startsOn,
  });
  Future<Budget> update(
    String id, {
    String? category,
    String? currency,
    int? limitMinor,
    BudgetPeriod? period,
    bool? rolloverEnabled,
    int? alertThresholdPercent,
  });
  Future<void> archive(String id);
}

/// Live implementation backed by the typed Retrofit client.
class ApiBudgetsRepository implements BudgetsRepository {
  ApiBudgetsRepository(this._api);

  final FeloApiClient _api;

  @override
  Future<List<Budget>> list() async {
    final raw = await _api.listBudgets();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_budgetFromApi).toList(growable: false);
  }

  @override
  Future<Budget> create({
    required String category,
    required String currency,
    required int limitMinor,
    required BudgetPeriod period,
    bool rolloverEnabled = false,
    int alertThresholdPercent = 80,
    DateTime? startsOn,
  }) async {
    final raw = await _api.createBudget(<String, dynamic>{
      'category': category,
      'currency': currency,
      'limitMinor': limitMinor,
      'period': period.name,
      'rolloverEnabled': rolloverEnabled,
      'alertThresholdPercent': alertThresholdPercent,
      if (startsOn != null) 'startsOn': startsOn.toIso8601String(),
    });
    return _budgetFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<Budget> update(
    String id, {
    String? category,
    String? currency,
    int? limitMinor,
    BudgetPeriod? period,
    bool? rolloverEnabled,
    int? alertThresholdPercent,
  }) async {
    final body = <String, dynamic>{
      if (category != null) 'category': category,
      if (currency != null) 'currency': currency,
      if (limitMinor != null) 'limitMinor': limitMinor,
      if (period != null) 'period': period.name,
      if (rolloverEnabled != null) 'rolloverEnabled': rolloverEnabled,
      if (alertThresholdPercent != null)
        'alertThresholdPercent': alertThresholdPercent,
    };
    final raw = await _api.updateBudget(id, body);
    return _budgetFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<void> archive(String id) async {
    await _api.archiveBudget(id);
  }
}

/// Phase-1 fake — kept so the app boots without a backend.
class FakeBudgetsRepository implements BudgetsRepository {
  // Mutable so create/update/archive feel real in fake mode.
  final List<Budget> _store = [
    const Budget(
      id: 'budget_groceries',
      category: 'Groceries',
      currency: 'CAD',
      limitMinor: 90000,
      spentMinor: 62400,
      period: BudgetPeriod.monthly,
      rolloverEnabled: true,
      alertThresholdPercent: 80,
    ),
    const Budget(
      id: 'budget_family',
      category: 'Family support',
      currency: 'CAD',
      limitMinor: 120000,
      spentMinor: 83000,
      period: BudgetPeriod.monthly,
      rolloverEnabled: false,
      alertThresholdPercent: 85,
    ),
    const Budget(
      id: 'budget_transport',
      category: 'Transport',
      currency: 'CAD',
      limitMinor: 45000,
      spentMinor: 31800,
      period: BudgetPeriod.monthly,
      rolloverEnabled: true,
      alertThresholdPercent: 75,
    ),
  ];

  @override
  Future<List<Budget>> list() async => List<Budget>.unmodifiable(_store);

  @override
  Future<Budget> create({
    required String category,
    required String currency,
    required int limitMinor,
    required BudgetPeriod period,
    bool rolloverEnabled = false,
    int alertThresholdPercent = 80,
    DateTime? startsOn,
  }) async {
    final budget = Budget(
      id: 'budget_${DateTime.now().millisecondsSinceEpoch}',
      category: category,
      currency: currency,
      limitMinor: limitMinor,
      spentMinor: 0,
      period: period,
      rolloverEnabled: rolloverEnabled,
      alertThresholdPercent: alertThresholdPercent,
    );
    _store.insert(0, budget);
    return budget;
  }

  @override
  Future<Budget> update(
    String id, {
    String? category,
    String? currency,
    int? limitMinor,
    BudgetPeriod? period,
    bool? rolloverEnabled,
    int? alertThresholdPercent,
  }) async {
    final idx = _store.indexWhere((b) => b.id == id);
    if (idx < 0) {
      throw StateError('Fake budget $id not found');
    }
    final updated = _store[idx].copyWith(
      category: category ?? _store[idx].category,
      currency: currency ?? _store[idx].currency,
      limitMinor: limitMinor ?? _store[idx].limitMinor,
      period: period ?? _store[idx].period,
      rolloverEnabled: rolloverEnabled ?? _store[idx].rolloverEnabled,
      alertThresholdPercent:
          alertThresholdPercent ?? _store[idx].alertThresholdPercent,
    );
    _store[idx] = updated;
    return updated;
  }

  @override
  Future<void> archive(String id) async {
    _store.removeWhere((b) => b.id == id);
  }
}

Budget _budgetFromApi(Map<String, dynamic> json) {
  return Budget(
    id: json['id'].toString(),
    category: (json['category'] ?? '').toString(),
    currency: (json['currency'] ?? 'CAD').toString().toUpperCase(),
    limitMinor: _intFrom(json['limitMinor'] ?? json['limit_minor']) ?? 0,
    spentMinor: _intFrom(json['spentMinor'] ?? json['spent_minor']) ?? 0,
    period: _periodFrom(json['period']),
    rolloverEnabled:
        json['rolloverEnabled'] == true || json['rollover_enabled'] == true,
    alertThresholdPercent:
        _intFrom(
          json['alertThresholdPercent'] ?? json['alert_threshold_percent'],
        ) ??
        80,
  );
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}

BudgetPeriod _periodFrom(Object? value) {
  final normalized = value?.toString().toLowerCase() ?? '';
  return switch (normalized) {
    'weekly' => BudgetPeriod.weekly,
    _ => BudgetPeriod.monthly,
  };
}

@riverpod
BudgetsRepository budgetsRepository(BudgetsRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeBudgetsRepository();
  }
  return ApiBudgetsRepository(ref.watch(feloApiClientProvider));
}

/// Async list provider — replaces the old sync `budgetsProvider`.
@riverpod
Future<List<Budget>> budgets(BudgetsRef ref) async {
  return ref.watch(budgetsRepositoryProvider).list();
}
