import 'package:freezed_annotation/freezed_annotation.dart';

part 'remittance_waitlist.freezed.dart';
part 'remittance_waitlist.g.dart';

@freezed
abstract class RemittanceWaitlist with _$RemittanceWaitlist {
  const factory RemittanceWaitlist({
    required String id,
    required String corridor,
    required bool joined,
    required DateTime updatedAt,
  }) = _RemittanceWaitlist;

  factory RemittanceWaitlist.fromJson(Map<String, Object?> json) =>
      _$RemittanceWaitlistFromJson(json);
}
