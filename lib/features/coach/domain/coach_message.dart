import 'package:freezed_annotation/freezed_annotation.dart';

part 'coach_message.freezed.dart';
part 'coach_message.g.dart';

enum CoachMessageAuthor { user, coach, system }

@freezed
abstract class CoachMessage with _$CoachMessage {
  const factory CoachMessage({
    required String id,
    required CoachMessageAuthor author,
    required String text,
    required DateTime createdAt,
    required bool adviceBoundaryVisible,
  }) = _CoachMessage;

  factory CoachMessage.fromJson(Map<String, Object?> json) =>
      _$CoachMessageFromJson(json);
}
