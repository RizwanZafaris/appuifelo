import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/splits/domain/split.dart';

part 'splits_repository.g.dart';

/// Backend-shape splits contract.
///
/// `ApiSplitsRepository` talks to NestJS at `/v1/splits` (Drizzle-backed,
/// tenant-scoped count aggregation in service.list()).
/// `FakeSplitsRepository` keeps the rich Phase-1 demo data alive.
abstract class SplitsRepository {
  /// Legacy sync seed used by `Splits.build()` in fake mode.
  List<Split> seedSplits();

  /// Phase-1 helper: synthesizes a brand-new split for the optimistic
  /// "just created" flow. Live impl returns the inserted row.
  Split createSplitLocal({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  });

  Future<List<Split>> list();

  Future<Split> create({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  });

  Future<void> setParticipantPaid({
    required String splitId,
    required String participantId,
    required bool paid,
    required int shareMinor,
  });

  Future<Split> settle(String splitId);
}

class ApiSplitsRepository implements SplitsRepository {
  ApiSplitsRepository(this._api);

  final FeloApiClient _api;

  @override
  List<Split> seedSplits() => const [];

  @override
  Split createSplitLocal({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  }) {
    // Optimistic placeholder — replaced after backend round-trip.
    final id = 'pending_split_${DateTime.now().microsecondsSinceEpoch}';
    return Split(
      id: id,
      name: name,
      currency: currency,
      totalMinor: totalMinor,
      status: SplitStatus.active,
      createdAt: DateTime.now(),
      participants: [
        for (var i = 0; i < participants.length; i++)
          SplitParticipant(
            id: 'pending_participant_${id}_$i',
            splitId: id,
            displayName: participants[i].displayName,
            contact: participants[i].contact,
            shareMinor: participants[i].shareMinor,
            paidMinor: 0,
            status: SplitParticipantStatus.pending,
          ),
      ],
    );
  }

  @override
  Future<List<Split>> list() async {
    final raw = await _api.listSplits();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    // Backend list response includes splits without their full participant
    // arrays; we need to fetch each detail to populate participants. For
    // now, return splits with empty participants — the detail screen calls
    // `_api.getSplit(id)` separately. Wave 2B-2 follow-up: include
    // participants in list response or batch-fetch.
    return rows.map(_splitFromApi).toList(growable: false);
  }

  @override
  Future<Split> create({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  }) async {
    final raw = await _api.createSplit(<String, dynamic>{
      'name': name,
      'currency': currency,
      'totalMinor': totalMinor,
      'participants': [
        for (final p in participants)
          {
            'displayName': p.displayName,
            'contact': p.contact,
            'shareMinor': p.shareMinor,
          },
      ],
    });
    return _splitFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<void> setParticipantPaid({
    required String splitId,
    required String participantId,
    required bool paid,
    required int shareMinor,
  }) async {
    await _api.updateSplitParticipant(splitId, participantId, <String, dynamic>{
      'paid': paid,
      'paidMinor': paid ? shareMinor : 0,
    });
  }

  @override
  Future<Split> settle(String splitId) async {
    final raw = await _api.settleSplit(splitId);
    return _splitFromApi((raw as Map).cast<String, dynamic>());
  }
}

class FakeSplitsRepository implements SplitsRepository {
  final List<Split> _store = [
    Split(
      id: 'split_rent_may',
      name: 'May rent',
      currency: 'CAD',
      totalMinor: 210000,
      status: SplitStatus.active,
      createdAt: DateTime(2026, 4, 24, 10),
      participants: const [
        SplitParticipant(
          id: 'participant_rizwan',
          splitId: 'split_rent_may',
          displayName: 'Rizwan',
          contact: 'rizwan@example.com',
          shareMinor: 70000,
          paidMinor: 70000,
          status: SplitParticipantStatus.paid,
        ),
        SplitParticipant(
          id: 'participant_saad',
          splitId: 'split_rent_may',
          displayName: 'Saad',
          contact: '+1 647 *** 2211',
          shareMinor: 70000,
          paidMinor: 0,
          status: SplitParticipantStatus.pending,
        ),
        SplitParticipant(
          id: 'participant_amina',
          splitId: 'split_rent_may',
          displayName: 'Amina',
          contact: '+1 416 *** 1189',
          shareMinor: 70000,
          paidMinor: 0,
          status: SplitParticipantStatus.pending,
        ),
      ],
    ),
    Split(
      id: 'split_family_gift',
      name: 'Family gift',
      currency: 'CAD',
      totalMinor: 30000,
      status: SplitStatus.settled,
      createdAt: DateTime(2026, 4, 18, 18),
      participants: const [
        SplitParticipant(
          id: 'participant_fatima',
          splitId: 'split_family_gift',
          displayName: 'Fatima',
          contact: 'fatima@example.com',
          shareMinor: 15000,
          paidMinor: 15000,
          status: SplitParticipantStatus.paid,
        ),
        SplitParticipant(
          id: 'participant_ali',
          splitId: 'split_family_gift',
          displayName: 'Ali',
          contact: '+1 905 *** 7312',
          shareMinor: 15000,
          paidMinor: 15000,
          status: SplitParticipantStatus.paid,
        ),
      ],
    ),
  ];

  @override
  List<Split> seedSplits() => List<Split>.unmodifiable(_store);

  @override
  Split createSplitLocal({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  }) {
    final id = 'split_${DateTime.now().microsecondsSinceEpoch}';
    return Split(
      id: id,
      name: name,
      currency: currency,
      totalMinor: totalMinor,
      status: SplitStatus.active,
      createdAt: DateTime.now(),
      participants: [
        for (var i = 0; i < participants.length; i++)
          SplitParticipant(
            id: 'participant_${id}_$i',
            splitId: id,
            displayName: participants[i].displayName,
            contact: participants[i].contact,
            shareMinor: participants[i].shareMinor,
            paidMinor: 0,
            status: SplitParticipantStatus.pending,
          ),
      ],
    );
  }

  @override
  Future<List<Split>> list() async => List<Split>.unmodifiable(_store);

  @override
  Future<Split> create({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  }) async {
    final split = createSplitLocal(
      name: name,
      currency: currency,
      totalMinor: totalMinor,
      participants: participants,
    );
    _store.insert(0, split);
    return split;
  }

  @override
  Future<void> setParticipantPaid({
    required String splitId,
    required String participantId,
    required bool paid,
    required int shareMinor,
  }) async {
    final idx = _store.indexWhere((s) => s.id == splitId);
    if (idx < 0) return;
    final split = _store[idx];
    _store[idx] = split.copyWith(
      participants: [
        for (final p in split.participants)
          if (p.id == participantId)
            p.copyWith(
              paidMinor: paid ? p.shareMinor : 0,
              status: paid
                  ? SplitParticipantStatus.paid
                  : SplitParticipantStatus.pending,
            )
          else
            p,
      ],
    );
  }

  @override
  Future<Split> settle(String splitId) async {
    final idx = _store.indexWhere((s) => s.id == splitId);
    if (idx < 0) throw StateError('Fake split $splitId not found');
    final split = _store[idx];
    final settled = split.copyWith(
      status: SplitStatus.settled,
      participants: [
        for (final p in split.participants)
          p.copyWith(
            paidMinor: p.shareMinor,
            status: SplitParticipantStatus.paid,
          ),
      ],
    );
    _store[idx] = settled;
    return settled;
  }
}

Split _splitFromApi(Map<String, dynamic> json) {
  final participantsJson =
      (json['participants'] as List?)?.cast<Map<String, dynamic>>() ??
          const <Map<String, dynamic>>[];
  final id = json['id'].toString();
  return Split(
    id: id,
    name: (json['name'] ?? '').toString(),
    currency: (json['currency'] ?? 'CAD').toString().toUpperCase(),
    totalMinor: _intFrom(json['totalMinor'] ?? json['total_minor']) ?? 0,
    status: _statusFrom(json['status']),
    createdAt: DateTime.tryParse(
          (json['createdAt'] ?? json['created_at'] ?? '').toString(),
        ) ??
        DateTime.now(),
    participants: participantsJson
        .map((p) => _participantFromApi(p, splitId: id))
        .toList(growable: false),
  );
}

SplitParticipant _participantFromApi(
  Map<String, dynamic> json, {
  required String splitId,
}) {
  final paid =
      json['paid'] == true ||
      (json['status']?.toString().toLowerCase() == 'paid');
  return SplitParticipant(
    id: json['id'].toString(),
    splitId: (json['splitId'] ?? json['split_id'] ?? splitId).toString(),
    displayName: (json['displayName'] ?? json['display_name'] ?? '').toString(),
    contact: (json['contact'] ?? '').toString(),
    shareMinor: _intFrom(json['shareMinor'] ?? json['share_minor']) ?? 0,
    paidMinor: _intFrom(json['paidMinor'] ?? json['paid_minor']) ?? 0,
    status: paid ? SplitParticipantStatus.paid : SplitParticipantStatus.pending,
  );
}

SplitStatus _statusFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'settled' => SplitStatus.settled,
    'cancelled' || 'canceled' => SplitStatus.cancelled,
    _ => SplitStatus.active,
  };
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}

class SplitParticipantDraft {
  const SplitParticipantDraft({
    required this.displayName,
    required this.contact,
    required this.shareMinor,
  });

  final String displayName;
  final String contact;
  final int shareMinor;
}

@riverpod
SplitsRepository splitsRepository(SplitsRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeSplitsRepository();
  }
  return ApiSplitsRepository(ref.watch(feloApiClientProvider));
}

/// Async splits notifier — replaces sync `Splits` notifier.
@riverpod
class Splits extends _$Splits {
  @override
  Future<List<Split>> build() async {
    return ref.watch(splitsRepositoryProvider).list();
  }

  Future<Split> createSplit({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  }) async {
    final split = await ref.read(splitsRepositoryProvider).create(
          name: name,
          currency: currency,
          totalMinor: totalMinor,
          participants: participants,
        );
    final current = state.valueOrNull ?? const <Split>[];
    state = AsyncValue.data([split, ...current]);
    return split;
  }

  Future<void> setParticipantPaid({
    required String splitId,
    required String participantId,
    required bool paid,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return;
    final split = current.firstWhere((s) => s.id == splitId);
    final participant = split.participants.firstWhere(
      (p) => p.id == participantId,
    );
    await ref.read(splitsRepositoryProvider).setParticipantPaid(
          splitId: splitId,
          participantId: participantId,
          paid: paid,
          shareMinor: participant.shareMinor,
        );
    // Optimistic local update.
    state = AsyncValue.data([
      for (final s in current)
        if (s.id == splitId)
          _syncStatus(
            s.copyWith(
              participants: [
                for (final p in s.participants)
                  if (p.id == participantId)
                    p.copyWith(
                      paidMinor: paid ? p.shareMinor : 0,
                      status: paid
                          ? SplitParticipantStatus.paid
                          : SplitParticipantStatus.pending,
                    )
                  else
                    p,
              ],
            ),
          )
        else
          s,
    ]);
  }

  Future<void> settleSplit(String splitId) async {
    final settled = await ref.read(splitsRepositoryProvider).settle(splitId);
    final current = state.valueOrNull ?? const <Split>[];
    state = AsyncValue.data([
      for (final s in current)
        if (s.id == splitId) settled else s,
    ]);
  }

  Split? byId(String splitId) {
    final current = state.valueOrNull;
    if (current == null) return null;
    for (final split in current) {
      if (split.id == splitId) return split;
    }
    return null;
  }

  Split _syncStatus(Split split) {
    if (split.participants.isNotEmpty &&
        split.participants.every(
          (p) => p.status == SplitParticipantStatus.paid,
        )) {
      return split.copyWith(status: SplitStatus.settled);
    }
    return split.copyWith(status: SplitStatus.active);
  }
}
