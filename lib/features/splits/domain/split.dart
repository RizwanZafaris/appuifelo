import 'package:freezed_annotation/freezed_annotation.dart';

part 'split.freezed.dart';
part 'split.g.dart';

enum SplitStatus {
  @JsonValue('active')
  active,
  @JsonValue('settled')
  settled,
  @JsonValue('cancelled')
  cancelled,
}

enum SplitParticipantStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('paid')
  paid,
}

@freezed
abstract class SplitParticipant with _$SplitParticipant {
  const factory SplitParticipant({
    required String id,
    required String splitId,
    required String displayName,
    required String contact,
    required int shareMinor,
    required int paidMinor,
    required SplitParticipantStatus status,
  }) = _SplitParticipant;

  factory SplitParticipant.fromJson(Map<String, Object?> json) =>
      _$SplitParticipantFromJson(json);
}

@freezed
abstract class Split with _$Split {
  const factory Split({
    required String id,
    required String name,
    required String currency,
    required int totalMinor,
    required SplitStatus status,
    required DateTime createdAt,
    required List<SplitParticipant> participants,
  }) = _Split;

  factory Split.fromJson(Map<String, Object?> json) => _$SplitFromJson(json);
}

extension SplitProgress on Split {
  int get paidParticipantCount => participants
      .where((participant) => participant.status == SplitParticipantStatus.paid)
      .length;

  int get paidMinor =>
      participants.fold(0, (sum, participant) => sum + participant.paidMinor);

  double get progress {
    if (totalMinor <= 0) {
      return 0;
    }
    return (paidMinor / totalMinor).clamp(0, 1);
  }

  bool get isSettled => status == SplitStatus.settled;
}
