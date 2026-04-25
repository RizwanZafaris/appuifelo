import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';

part 'transactions_repository.g.dart';

/// Backend-shape transactions contract.
///
/// `ApiTransactionsRepository` talks to NestJS at `/v1/transactions`.
/// `FakeTransactionsRepository` keeps the rich Phase-1 fixture (~12 txns
/// across CAD/PKR/USD) alive for offline runs.
abstract class TransactionsRepository {
  Future<List<FeloTransaction>> list({
    String? cursor,
    int? limit,
    String? category,
  });
  Future<FeloTransaction> create({
    String? accountId,
    String? merchant,
    String? category,
    required String currency,
    required int amountMinor,
    required TransactionDirection direction,
    required TransactionSource source,
    double? parserConfidence,
    DateTime? bookedAt,
    String? note,
  });
  Future<void> attachReceipt({
    required String transactionId,
    required String receiptId,
  });
}

class ApiTransactionsRepository implements TransactionsRepository {
  ApiTransactionsRepository(this._api);

  final FeloApiClient _api;

  @override
  Future<List<FeloTransaction>> list({
    String? cursor,
    int? limit,
    String? category,
  }) async {
    final raw = await _api.listTransactions(
      cursor: cursor,
      limit: limit,
      category: category,
    );
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_txnFromApi).toList(growable: false);
  }

  @override
  Future<FeloTransaction> create({
    String? accountId,
    String? merchant,
    String? category,
    required String currency,
    required int amountMinor,
    required TransactionDirection direction,
    required TransactionSource source,
    double? parserConfidence,
    DateTime? bookedAt,
    String? note,
  }) async {
    final raw = await _api.createTransaction(<String, dynamic>{
      'accountId': ?accountId,
      'merchant': ?merchant,
      'category': ?category,
      'currency': currency,
      'amountMinor': amountMinor,
      'direction': direction.name,
      'source': source.name,
      'parserConfidence': ?parserConfidence,
      'bookedAt': ?bookedAt?.toIso8601String(),
      'note': ?note,
    });
    return _txnFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<void> attachReceipt({
    required String transactionId,
    required String receiptId,
  }) async {
    // Backend does not yet expose receipt-attach; this is fire-and-forget
    // until the receipts module ships. Returning silently is intentional.
  }
}

class FakeTransactionsRepository implements TransactionsRepository {
  FakeTransactionsRepository() {
    _store.addAll([
      FeloTransaction(
        id: 'txn_001',
        accountId: 'acct_td_chequing',
        merchant: 'Imtiaz Super Market',
        category: 'Groceries',
        currency: 'PKR',
        amountMinor: 485000,
        direction: TransactionDirection.debit,
        source: TransactionSource.sms,
        parserConfidence: 0.88,
        bookedAt: DateTime(2026, 4, 22, 12, 20),
      ),
      FeloTransaction(
        id: 'txn_002',
        accountId: 'acct_rbc_mastercard',
        merchant: 'No Frills',
        category: 'Groceries',
        currency: 'CAD',
        amountMinor: 8422,
        direction: TransactionDirection.debit,
        source: TransactionSource.manual,
        parserConfidence: 1,
        bookedAt: DateTime(2026, 4, 21, 18, 4),
      ),
      FeloTransaction(
        id: 'txn_003',
        accountId: 'acct_td_chequing',
        merchant: 'Salary — Felo Inc.',
        category: 'Income',
        currency: 'CAD',
        amountMinor: 540000,
        direction: TransactionDirection.credit,
        source: TransactionSource.bankAlert,
        parserConfidence: 0.97,
        bookedAt: DateTime(2026, 4, 20, 9, 30),
      ),
      FeloTransaction(
        id: 'txn_004',
        accountId: 'acct_easypaisa',
        merchant: 'Family support — Karachi',
        category: 'Family support',
        currency: 'PKR',
        amountMinor: 5000000,
        direction: TransactionDirection.debit,
        source: TransactionSource.manual,
        parserConfidence: 1,
        bookedAt: DateTime(2026, 4, 19, 14, 0),
      ),
      FeloTransaction(
        id: 'txn_005',
        accountId: 'acct_rbc_mastercard',
        merchant: 'TTC Presto',
        category: 'Transport',
        currency: 'CAD',
        amountMinor: 600,
        direction: TransactionDirection.debit,
        source: TransactionSource.sms,
        parserConfidence: 0.91,
        bookedAt: DateTime(2026, 4, 18, 8, 45),
      ),
    ]);
  }

  final List<FeloTransaction> _store = [];

  @override
  Future<List<FeloTransaction>> list({
    String? cursor,
    int? limit,
    String? category,
  }) async {
    Iterable<FeloTransaction> view = _store;
    if (category != null) {
      view = view.where((t) => t.category == category);
    }
    if (limit != null) view = view.take(limit);
    return List<FeloTransaction>.unmodifiable(view);
  }

  @override
  Future<FeloTransaction> create({
    String? accountId,
    String? merchant,
    String? category,
    required String currency,
    required int amountMinor,
    required TransactionDirection direction,
    required TransactionSource source,
    double? parserConfidence,
    DateTime? bookedAt,
    String? note,
  }) async {
    final txn = FeloTransaction(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      accountId: accountId ?? 'acct_manual',
      merchant: merchant ?? '',
      category: category ?? 'Uncategorized',
      currency: currency,
      amountMinor: amountMinor,
      direction: direction,
      source: source,
      parserConfidence: parserConfidence ?? 1,
      bookedAt: bookedAt ?? DateTime.now(),
      note: note,
    );
    _store.insert(0, txn);
    return txn;
  }

  @override
  Future<void> attachReceipt({
    required String transactionId,
    required String receiptId,
  }) async {
    final idx = _store.indexWhere((t) => t.id == transactionId);
    if (idx < 0) return;
    _store[idx] = _store[idx].copyWith(receiptId: receiptId);
  }
}

FeloTransaction _txnFromApi(Map<String, dynamic> json) {
  return FeloTransaction(
    id: json['id'].toString(),
    accountId: (json['accountId'] ?? json['account_id'] ?? '').toString(),
    merchant: (json['merchant'] ?? '').toString(),
    category: (json['category'] ?? '').toString(),
    currency: (json['currency'] ?? 'CAD').toString().toUpperCase(),
    amountMinor: _intFrom(json['amountMinor'] ?? json['amount_minor']) ?? 0,
    direction: _directionFrom(json['direction']),
    source: _sourceFrom(json['source']),
    parserConfidence:
        _doubleFrom(json['parserConfidence'] ?? json['parser_confidence']) ?? 1,
    bookedAt:
        DateTime.tryParse(
          (json['bookedAt'] ?? json['booked_at'] ?? '').toString(),
        ) ??
        DateTime.now(),
    receiptId: (json['receiptId'] ?? json['receipt_id'])?.toString(),
    note: (json['note'])?.toString(),
  );
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}

double? _doubleFrom(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '');
}

TransactionDirection _directionFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return n == 'credit'
      ? TransactionDirection.credit
      : TransactionDirection.debit;
}

TransactionSource _sourceFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'sms' => TransactionSource.sms,
    'manual' => TransactionSource.manual,
    'bankalert' || 'bank_alert' => TransactionSource.bankAlert,
    'fixture' => TransactionSource.fixture,
    _ => TransactionSource.manual,
  };
}

@riverpod
TransactionsRepository transactionsRepository(TransactionsRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeTransactionsRepository();
  }
  return ApiTransactionsRepository(ref.watch(feloApiClientProvider));
}

/// Async transactions notifier. Exposes `attachReceipt()` for the receipt
/// capture flow that previously mutated state directly.
@riverpod
class Transactions extends _$Transactions {
  @override
  Future<List<FeloTransaction>> build() async {
    return ref.watch(transactionsRepositoryProvider).list();
  }

  Future<void> attachReceipt({
    required String transactionId,
    required String receiptId,
  }) async {
    await ref
        .read(transactionsRepositoryProvider)
        .attachReceipt(transactionId: transactionId, receiptId: receiptId);
    // Optimistic local update so the UI reflects the change immediately.
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([
      for (final t in current)
        if (t.id == transactionId) t.copyWith(receiptId: receiptId) else t,
    ]);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(transactionsRepositoryProvider).list(),
    );
  }
}

/// Convenience read-only async provider that mirrors `Transactions.build`.
/// Many screens just want the list and shouldn't depend on the notifier
/// surface.
@riverpod
Future<List<FeloTransaction>> transactionsList(TransactionsListRef ref) async {
  return ref.watch(transactionsProvider.future);
}
