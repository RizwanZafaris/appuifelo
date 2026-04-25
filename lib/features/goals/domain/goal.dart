import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

enum GoalCadence { manual, weekly, biweekly, monthly }

@freezed
abstract class Goal with _$Goal {
  const factory Goal({
    required String id,
    required String name,
    required String currency,
    required int targetMinor,
    required int savedMinor,
    required DateTime targetDate,
    required bool shared,
    required GoalCadence cadence,
    required List<String> contributorNames,
    @Default(0) int contributionStreakWeeks,
  }) = _Goal;

  factory Goal.fromJson(Map<String, Object?> json) => _$GoalFromJson(json);
}
