import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_status.freezed.dart';
part 'kyc_status.g.dart';

enum KycState {
  notStarted,
  inProgress,
  pendingReview,
  verified,
  rejected,
}

@freezed
abstract class KycStatus with _$KycStatus {
  const factory KycStatus({
    required String id,
    required KycState state,
    String? idType,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    String? rejectionReason,
    @Default(false) bool documentsUploaded,
    @Default(false) bool selfieUploaded,
  }) = _KycStatus;

  factory KycStatus.fromJson(Map<String, Object?> json) =>
      _$KycStatusFromJson(json);
}
