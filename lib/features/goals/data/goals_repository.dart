import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/goals/domain/goal.dart';

part 'goals_repository.g.dart';

/// Backend-shape goals contract.
///
/// `ApiGoalsRepository` talks to NestJS at `/v1/goals` (Drizzle-backed).
/// `FakeGoalsRepository` keeps Phase-1 demo state alive when the app is
/// launched with `--dart-define=FELO_USE_FAKE_DATA=true`.
abstract class GoalsRepository {
  Future<List<Goal>> list();
  Future<Goal> create({
    required String name,
    required String currency,
    required int targetMinor,
    int savedMinor = 0,
    DateTime? targetDate,
    GoalCadence cadence = GoalCadence.manual,
    bool shared = false,
  });
  Future<Goal> update(
    String id, {
    String? name,
    String? currency,
    int? targetMinor,
    int? savedMinor,
    DateTime? targetDate,
    GoalCadence? cadence,
    bool? shared,
  });
  Future<Goal> contribute(String id, {required int amountMinor});
}

class ApiGoalsRepository implements GoalsRepository {
  ApiGoalsRepository(this._api);

  final FeloApiClient _api;

  @override
  Future<List<Goal>> list() async {
    final raw = await _api.listGoals();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_goalFromApi).toList(growable: false);
  }

  @override
  Future<Goal> create({
    required String name,
    required String currency,
    required int targetMinor,
    int savedMinor = 0,
    DateTime? targetDate,
    GoalCadence cadence = GoalCadence.manual,
    bool shared = false,
  }) async {
    final raw = await _api.createGoal(<String, dynamic>{
      'name': name,
      'currency': currency,
      'targetMinor': targetMinor,
      'savedMinor': savedMinor,
      if (targetDate != null) 'targetDate': targetDate.toIso8601String(),
      'cadence': cadence.name,
      'shared': shared,
    });
    return _goalFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<Goal> update(
    String id, {
    String? name,
    String? currency,
    int? targetMinor,
    int? savedMinor,
    DateTime? targetDate,
    GoalCadence? cadence,
    bool? shared,
  }) async {
    final body = <String, dynamic>{
      if (name != null) 'name': name,
      if (currency != null) 'currency': currency,
      if (targetMinor != null) 'targetMinor': targetMinor,
      if (savedMinor != null) 'savedMinor': savedMinor,
      if (targetDate != null) 'targetDate': targetDate.toIso8601String(),
      if (cadence != null) 'cadence': cadence.name,
      if (shared != null) 'shared': shared,
    };
    final raw = await _api.updateGoal(id, body);
    return _goalFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<Goal> contribute(String id, {required int amountMinor}) async {
    final raw = await _api.contributeToGoal(id, <String, dynamic>{
      'amountMinor': amountMinor,
    });
    final map = (raw as Map).cast<String, dynamic>();
    // Backend returns { goal, milestonesCrossed[] }; we only need the goal.
    final goalMap = (map['goal'] is Map)
        ? (map['goal'] as Map).cast<String, dynamic>()
        : map;
    return _goalFromApi(goalMap);
  }
}

class FakeGoalsRepository implements GoalsRepository {
  final List<Goal> _store = [
    Goal(
      id: 'goal_trip',
      name: 'Trip to Pakistan',
      currency: 'CAD',
      targetMinor: 520000,
      savedMinor: 318000,
      targetDate: DateTime(2026, 12, 15),
      shared: true,
      cadence: GoalCadence.weekly,
      contributorNames: const ['Rizwan', 'Amina'],
      contributionStreakWeeks: 4,
    ),
    Goal(
      id: 'goal_emergency',
      name: 'Emergency buffer',
      currency: 'CAD',
      targetMinor: 300000,
      savedMinor: 122000,
      targetDate: DateTime(2026, 9, 30),
      shared: false,
      cadence: GoalCadence.manual,
      contributorNames: const ['Rizwan'],
    ),
  ];

  @override
  Future<List<Goal>> list() async => List<Goal>.unmodifiable(_store);

  @override
  Future<Goal> create({
    required String name,
    required String currency,
    required int targetMinor,
    int savedMinor = 0,
    DateTime? targetDate,
    GoalCadence cadence = GoalCadence.manual,
    bool shared = false,
  }) async {
    final goal = Goal(
      id: 'goal_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      currency: currency,
      targetMinor: targetMinor,
      savedMinor: savedMinor,
      targetDate: targetDate ?? DateTime.now().add(const Duration(days: 180)),
      shared: shared,
      cadence: cadence,
      contributorNames: const ['Rizwan'],
    );
    _store.insert(0, goal);
    return goal;
  }

  @override
  Future<Goal> update(
    String id, {
    String? name,
    String? currency,
    int? targetMinor,
    int? savedMinor,
    DateTime? targetDate,
    GoalCadence? cadence,
    bool? shared,
  }) async {
    final idx = _store.indexWhere((g) => g.id == id);
    if (idx < 0) throw StateError('Fake goal $id not found');
    final updated = _store[idx].copyWith(
      name: name ?? _store[idx].name,
      currency: currency ?? _store[idx].currency,
      targetMinor: targetMinor ?? _store[idx].targetMinor,
      savedMinor: savedMinor ?? _store[idx].savedMinor,
      targetDate: targetDate ?? _store[idx].targetDate,
      cadence: cadence ?? _store[idx].cadence,
      shared: shared ?? _store[idx].shared,
    );
    _store[idx] = updated;
    return updated;
  }

  @override
  Future<Goal> contribute(String id, {required int amountMinor}) async {
    final idx = _store.indexWhere((g) => g.id == id);
    if (idx < 0) throw StateError('Fake goal $id not found');
    final updated = _store[idx].copyWith(
      savedMinor: _store[idx].savedMinor + amountMinor,
    );
    _store[idx] = updated;
    return updated;
  }
}

Goal _goalFromApi(Map<String, dynamic> json) {
  return Goal(
    id: json['id'].toString(),
    name: (json['name'] ?? '').toString(),
    currency: (json['currency'] ?? 'CAD').toString().toUpperCase(),
    targetMinor: _intFrom(json['targetMinor'] ?? json['target_minor']) ?? 0,
    savedMinor: _intFrom(json['savedMinor'] ?? json['saved_minor']) ?? 0,
    targetDate:
        DateTime.tryParse(
          (json['targetDate'] ?? json['target_date'] ?? '').toString(),
        ) ??
        DateTime.now().add(const Duration(days: 180)),
    shared: json['shared'] == true,
    cadence: _cadenceFrom(json['cadence']),
    // Backend doesn't return contributor names yet; default to current user.
    contributorNames: const <String>['You'],
    contributionStreakWeeks:
        _intFrom(
          json['contributionStreakWeeks'] ?? json['contribution_streak_weeks'],
        ) ??
        0,
  );
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}

GoalCadence _cadenceFrom(Object? value) {
  final n = value?.toString().toLowerCase() ?? '';
  return switch (n) {
    'weekly' => GoalCadence.weekly,
    'biweekly' => GoalCadence.biweekly,
    'monthly' => GoalCadence.monthly,
    _ => GoalCadence.manual,
  };
}

@riverpod
GoalsRepository goalsRepository(GoalsRepositoryRef ref) {
  if (FeloEnv.useFakeData) {
    return FakeGoalsRepository();
  }
  return ApiGoalsRepository(ref.watch(feloApiClientProvider));
}

/// Async list provider — replaces the old sync `goalsProvider`.
@riverpod
Future<List<Goal>> goals(GoalsRef ref) async {
  return ref.watch(goalsRepositoryProvider).list();
}
