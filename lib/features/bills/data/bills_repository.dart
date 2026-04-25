import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/bills/domain/bill.dart';

part 'bills_repository.g.dart';

/// Backend-shape bills contract.
///
/// `ApiBillsRepository` talks to NestJS at `/v1/recurring-bills`.
/// `FakeBillsRepository` keeps Phase-1 demo bills for offline runs.
abstract class BillsRepository {
  /// Legacy sync seed used by Phase-1 components. Returns demo bills
  /// in fake mode; empty in live mode (use `list()` instead).
  List<Bill> seedBills();

  Bill createManualBill({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
  });

  Future<List<Bill>> list();
  Future<Bill> create({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
    BillCategory category = BillCategory.utility,
    String currency = 'CAD',
    bool autoPayEnabled = false,
  });
}

class ApiBillsRepository implements BillsRepository {
  ApiBillsRepository(this._api);

  final FeloApiClient _api;

  @override
  List<Bill> seedBills() => const [];

  @override
  Bill createManualBill({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
  }) {
    return Bill(
      id: 'bill_pending_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      category: BillCategory.utility,
      dueDate: dueDate,
      currency: 'CAD',
      amountMinor: amountMinor,
      autoPayEnabled: false,
      source: BillSource.manual,
      status: BillStatus.upcoming,
    );
  }

  @override
  Future<List<Bill>> list() async {
    final raw = await _api.listRecurringBills();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_billFromApi).toList(growable: false);
  }

  @override
  Future<Bill> create({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
    BillCategory category = BillCategory.utility,
    String currency = 'CAD',
    bool autoPayEnabled = false,
  }) async {
    final raw = await _api.createRecurringBill(<String, dynamic>{
      'name': name,
      'amountMinor': amountMinor,
      'dueDate': dueDate.toIso8601String(),
      'category': category.name,
      'currency': currency,
      'autoPayEnabled': autoPayEnabled,
    });
    return _billFromApi((raw as Map).cast<String, dynamic>());
  }
}

class FakeBillsRepository implements BillsRepository {
  final List<Bill> _store = [
    Bill(
      id: 'bill_k_electric',
      name: 'K-Electric',
      category: BillCategory.utility,
      dueDate: DateTime(2026, 4, 28),
      currency: 'PKR',
      amountMinor: 124000,
      autoPayEnabled: false,
      source: BillSource.sms,
      status: BillStatus.upcoming,
    ),
    Bill(
      id: 'bill_mobile',
      name: 'Mobile plan',
      category: BillCategory.telecom,
      dueDate: DateTime(2026, 5, 2),
      currency: 'CAD',
      amountMinor: 5800,
      autoPayEnabled: true,
      source: BillSource.manual,
      status: BillStatus.upcoming,
    ),
    Bill(
      id: 'bill_rent',
      name: 'Rent',
      category: BillCategory.rent,
      dueDate: DateTime(2026, 5, 1),
      currency: 'CAD',
      amountMinor: 180000,
      autoPayEnabled: false,
      source: BillSource.manual,
      status: BillStatus.upcoming,
    ),
  ];

  @override
  List<Bill> seedBills() => List<Bill>.unmodifiable(_store);

  @override
  Bill createManualBill({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
  }) {
    final bill = Bill(
      id: 'bill_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      category: BillCategory.utility,
      dueDate: dueDate,
      currency: 'CAD',
      amountMinor: amountMinor,
      autoPayEnabled: false,
      source: BillSource.manual,
      status: BillStatus.upcoming,
    );
    _store.insert(0, bill);
    return bill;
  }

  @override
  Future<List<Bill>> list() async => List<Bill>.unmodifiable(_store);

  @override
  Future<Bill> create({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
    BillCategory category = BillCategory.utility,
    String currency = 'CAD',
    bool autoPayEnabled = false,
  }) async {
    final bill = Bill(
      id: 'bill_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      category: category,
      dueDate: dueDate,
      currency: currency,
      amountMinor: amountMinor,
      autoPayEnabled: autoPayEnabled,
      source: BillSource.manual,
      status: BillStatus.upcoming,
    );
    _store.insert(0, bill);
    return bill;
  }
}

Bill _billFromApi(Map<String, dynamic> json) {
  return Bill(
    id: json['id'].toString(),
    name: (json['name'] ?? '').toString(),
    category: _categoryFrom(json['category']),
    dueDate: DateTime.tryParse(
          (json['dueDate'] ?? json['due_date'] ?? '').toString(),
        ) ??
        DateTime.now(),
    currency: (json['currency'] ?? 'CAD').toString().toUpperCase(),
    amountMinor: _intFrom(json['amountMinor'] ?? json['amount_minor']) ?? 0,
    autoPayEnabled:
        json['autoPayEnabled'] == true || json['auto_pay_enabled'] == true,
    source: _sourceFrom(json['source']),
    status: _statusFrom(json['status']),
  );
}

BillCategory _categoryFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'telecom' => BillCategory.telecom,
    'rent' => BillCategory.rent,
    'subscription' => BillCategory.subscription,
    _ => BillCategory.utility,
  };
}

BillSource _sourceFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return n == 'sms' ? BillSource.sms : BillSource.manual;
}

BillStatus _statusFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return n == 'paid' ? BillStatus.paid : BillStatus.upcoming;
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}

@riverpod
BillsRepository billsRepository(BillsRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeBillsRepository();
  }
  return ApiBillsRepository(ref.watch(feloApiClientProvider));
}

/// Async bills notifier — replaces sync `Bills` notifier in fake_repositories.
@riverpod
class Bills extends _$Bills {
  @override
  Future<List<Bill>> build() async {
    return ref.watch(billsRepositoryProvider).list();
  }

  Future<void> addManualBill({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
  }) async {
    final bill = await ref.read(billsRepositoryProvider).create(
          name: name,
          amountMinor: amountMinor,
          dueDate: dueDate,
        );
    final current = state.valueOrNull ?? const <Bill>[];
    state = AsyncValue.data([bill, ...current]);
  }

  void markPaid(String billId) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([
      for (final bill in current)
        if (bill.id == billId) bill.copyWith(status: BillStatus.paid) else bill,
    ]);
    // TODO(felo): wire backend mark-paid when /v1/recurring-bills/:id/paid
    // ships. For now this is local-only.
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(billsRepositoryProvider).list(),
    );
  }
}
