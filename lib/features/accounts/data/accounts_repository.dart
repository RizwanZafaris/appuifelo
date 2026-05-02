import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/accounts/domain/felo_account.dart';

part 'accounts_repository.g.dart';

/// Backend-shape accounts contract.
///
/// `ApiAccountsRepository` talks to NestJS at `/v1/accounts`.
/// `FakeAccountsRepository` keeps Phase-1 demo accounts alive for offline
/// dev runs (TD/RBC/Easypaisa fixture trio).
///
/// Both `seedAccounts()` (sync, legacy) and `list()` (async, live) are
/// supported because the existing `AccountConnectFlow` notifier already
/// reads from the seed-shape repo via `connectedAccountFor()`. Eventually
/// `seedAccounts()` will be retired in favour of pure `list()`.
abstract class AccountsRepository {
  /// Legacy Phase-1 sync seed used by `AccountConnectFlow`. Returns the
  /// canned demo accounts in fake mode; in live mode this is unused (the
  /// async `list()` is the entry point).
  List<FeloAccount> seedAccounts();

  /// Phase-1 helper: synthesizes a "freshly connected" account with a
  /// sequence suffix so the connect-flow demo can keep adding accounts
  /// without needing a backend round-trip. Live impl ignores `sequence`
  /// and POSTs to `/v1/accounts` instead.
  FeloAccount connectedAccountFor({
    required FeloAccountProvider provider,
    required int sequence,
  });

  /// Async list — used by screens that render the accounts list.
  Future<List<FeloAccount>> list();

  /// Connect via API: POST /v1/accounts. The Phase-1 fake produces a
  /// synthesized account; the live impl returns the inserted row.
  Future<FeloAccount> connect({
    required FeloAccountProvider provider,
    required FeloAccountType type,
    required String displayName,
    required String currency,
    int balanceMinor = 0,
  });

  Future<void> disconnect(String accountId);
}

class ApiAccountsRepository implements AccountsRepository {
  ApiAccountsRepository(this._api);

  final FeloApiClient _api;

  @override
  List<FeloAccount> seedAccounts() => const [];

  @override
  FeloAccount connectedAccountFor({
    required FeloAccountProvider provider,
    required int sequence,
  }) {
    // Used by AccountConnectFlow's optimistic local state. We can't return
    // a real backend row synchronously, so synthesize a transient placeholder
    // — the real one will appear after `accountsListProvider` refreshes.
    return FeloAccount(
      id: 'pending_${provider.name}_$sequence',
      provider: provider,
      type: FeloAccountType.bank,
      displayName: _humanProviderName(provider),
      currency: provider == FeloAccountProvider.easypaisa ||
              provider == FeloAccountProvider.jazzcash
          ? 'PKR'
          : 'CAD',
      balanceMinor: 0,
      lastSyncedAt: DateTime.now(),
      syncStatus: FeloAccountSyncStatus.syncing,
    );
  }

  @override
  Future<List<FeloAccount>> list() async {
    final raw = await _api.listAccounts();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_accountFromApi).toList(growable: false);
  }

  @override
  Future<FeloAccount> connect({
    required FeloAccountProvider provider,
    required FeloAccountType type,
    required String displayName,
    required String currency,
    int balanceMinor = 0,
  }) async {
    final raw = await _api.createAccount(<String, dynamic>{
      'provider': provider.name,
      'type': type.name,
      'displayName': displayName,
      'currency': currency,
      'balanceMinor': balanceMinor,
    });
    return _accountFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<void> disconnect(String accountId) async {
    await _api.archiveAccount(accountId);
  }
}

class FakeAccountsRepository implements AccountsRepository {
  final List<FeloAccount> _store = [
    FeloAccount(
      id: 'acct_td_chequing',
      provider: FeloAccountProvider.td,
      type: FeloAccountType.bank,
      displayName: 'TD Chequing',
      currency: 'CAD',
      balanceMinor: 428000,
      lastSyncedAt: DateTime(2026, 4, 25, 8, 45),
      syncStatus: FeloAccountSyncStatus.synced,
    ),
    FeloAccount(
      id: 'acct_rbc_mastercard',
      provider: FeloAccountProvider.rbc,
      type: FeloAccountType.card,
      displayName: 'RBC Mastercard',
      currency: 'CAD',
      balanceMinor: -8422,
      lastSyncedAt: DateTime(2026, 4, 24, 21, 10),
      syncStatus: FeloAccountSyncStatus.needsReview,
    ),
    FeloAccount(
      id: 'acct_easypaisa',
      provider: FeloAccountProvider.easypaisa,
      type: FeloAccountType.wallet,
      displayName: 'Easypaisa wallet',
      currency: 'PKR',
      balanceMinor: 1865000,
      lastSyncedAt: DateTime(2026, 4, 24, 15, 45),
      syncStatus: FeloAccountSyncStatus.syncing,
    ),
  ];

  @override
  List<FeloAccount> seedAccounts() => List<FeloAccount>.unmodifiable(_store);

  @override
  FeloAccount connectedAccountFor({
    required FeloAccountProvider provider,
    required int sequence,
  }) {
    final now = DateTime(2026, 4, 25, 10, 30);
    return switch (provider) {
      FeloAccountProvider.td => FeloAccount(
          id: 'acct_td_connected_$sequence',
          provider: provider,
          type: FeloAccountType.bank,
          displayName: 'TD Canada Trust',
          currency: 'CAD',
          balanceMinor: 215000,
          lastSyncedAt: now,
          syncStatus: FeloAccountSyncStatus.synced,
        ),
      FeloAccountProvider.rbc => FeloAccount(
          id: 'acct_rbc_connected_$sequence',
          provider: provider,
          type: FeloAccountType.card,
          displayName: 'RBC card',
          currency: 'CAD',
          balanceMinor: -32450,
          lastSyncedAt: now,
          syncStatus: FeloAccountSyncStatus.synced,
        ),
      FeloAccountProvider.easypaisa => FeloAccount(
          id: 'acct_easypaisa_connected_$sequence',
          provider: provider,
          type: FeloAccountType.wallet,
          displayName: 'Easypaisa wallet',
          currency: 'PKR',
          balanceMinor: 920000,
          lastSyncedAt: now,
          syncStatus: FeloAccountSyncStatus.synced,
        ),
      FeloAccountProvider.jazzcash => FeloAccount(
          id: 'acct_jazzcash_connected_$sequence',
          provider: provider,
          type: FeloAccountType.wallet,
          displayName: 'JazzCash wallet',
          currency: 'PKR',
          balanceMinor: 610000,
          lastSyncedAt: now,
          syncStatus: FeloAccountSyncStatus.synced,
        ),
      FeloAccountProvider.manual => FeloAccount(
          id: 'acct_manual_connected_$sequence',
          provider: provider,
          type: FeloAccountType.bank,
          displayName: 'Manual account',
          currency: 'CAD',
          balanceMinor: 0,
          lastSyncedAt: now,
          syncStatus: FeloAccountSyncStatus.synced,
        ),
    };
  }

  @override
  Future<List<FeloAccount>> list() async =>
      List<FeloAccount>.unmodifiable(_store);

  @override
  Future<FeloAccount> connect({
    required FeloAccountProvider provider,
    required FeloAccountType type,
    required String displayName,
    required String currency,
    int balanceMinor = 0,
  }) async {
    final account = connectedAccountFor(
      provider: provider,
      sequence: _store.length + 1,
    );
    _store.insert(0, account);
    return account;
  }

  @override
  Future<void> disconnect(String accountId) async {
    _store.removeWhere((a) => a.id == accountId);
  }
}

FeloAccount _accountFromApi(Map<String, dynamic> json) {
  return FeloAccount(
    id: json['id'].toString(),
    provider: _providerFrom(json['provider']),
    type: _typeFrom(json['type']),
    displayName: (json['displayName'] ?? json['display_name'] ?? '').toString(),
    currency: (json['currency'] ?? 'CAD').toString().toUpperCase(),
    balanceMinor: _intFrom(json['balanceMinor'] ?? json['balance_minor']) ?? 0,
    lastSyncedAt: DateTime.tryParse(
          (json['lastSyncedAt'] ?? json['last_synced_at'] ?? '').toString(),
        ) ??
        DateTime.now(),
    syncStatus: _statusFrom(json['syncStatus'] ?? json['sync_status']),
  );
}

FeloAccountProvider _providerFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'td' => FeloAccountProvider.td,
    'rbc' => FeloAccountProvider.rbc,
    'easypaisa' => FeloAccountProvider.easypaisa,
    'jazzcash' => FeloAccountProvider.jazzcash,
    _ => FeloAccountProvider.manual,
  };
}

FeloAccountType _typeFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'card' => FeloAccountType.card,
    'wallet' => FeloAccountType.wallet,
    _ => FeloAccountType.bank,
  };
}

FeloAccountSyncStatus _statusFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'syncing' => FeloAccountSyncStatus.syncing,
    'needsreview' || 'needs_review' => FeloAccountSyncStatus.needsReview,
    _ => FeloAccountSyncStatus.synced,
  };
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}

String _humanProviderName(FeloAccountProvider p) => switch (p) {
      FeloAccountProvider.td => 'TD Canada Trust',
      FeloAccountProvider.rbc => 'RBC',
      FeloAccountProvider.easypaisa => 'Easypaisa',
      FeloAccountProvider.jazzcash => 'JazzCash',
      FeloAccountProvider.manual => 'Manual account',
    };

@riverpod
AccountsRepository accountsRepository(AccountsRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeAccountsRepository();
  }
  return ApiAccountsRepository(ref.watch(feloApiClientProvider));
}

/// Async accounts notifier.
///
/// Replaces the old sync `Accounts` notifier in fake_repositories.dart.
/// `connect()` and `disconnect()` are now `Future<void>` — callers must
/// await before navigating away.
@riverpod
class Accounts extends _$Accounts {
  @override
  Future<List<FeloAccount>> build() async {
    return ref.watch(accountsRepositoryProvider).list();
  }

  Future<FeloAccount> connect(FeloAccountProvider provider) async {
    final repo = ref.read(accountsRepositoryProvider);
    final account = await repo.connect(
      provider: provider,
      type: provider == FeloAccountProvider.easypaisa ||
              provider == FeloAccountProvider.jazzcash
          ? FeloAccountType.wallet
          : provider == FeloAccountProvider.rbc
              ? FeloAccountType.card
              : FeloAccountType.bank,
      displayName: _humanProviderName(provider),
      currency: provider == FeloAccountProvider.easypaisa ||
              provider == FeloAccountProvider.jazzcash
          ? 'PKR'
          : 'CAD',
    );
    final current = state.valueOrNull ?? const <FeloAccount>[];
    state = AsyncValue.data([account, ...current]);
    return account;
  }

  Future<void> disconnect(String accountId) async {
    await ref.read(accountsRepositoryProvider).disconnect(accountId);
    final current = state.valueOrNull ?? const <FeloAccount>[];
    state = AsyncValue.data([
      for (final a in current)
        if (a.id != accountId) a,
    ]);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(accountsRepositoryProvider).list(),
    );
  }
}
