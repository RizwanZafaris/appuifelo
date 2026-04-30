// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KycStatus _$KycStatusFromJson(Map<String, dynamic> json) => _KycStatus(
  id: json['id'] as String,
  state: $enumDecode(_$KycStateEnumMap, json['state']),
  idType: json['idType'] as String?,
  submittedAt: json['submittedAt'] == null
      ? null
      : DateTime.parse(json['submittedAt'] as String),
  reviewedAt: json['reviewedAt'] == null
      ? null
      : DateTime.parse(json['reviewedAt'] as String),
  rejectionReason: json['rejectionReason'] as String?,
  documentsUploaded: json['documentsUploaded'] as bool? ?? false,
  selfieUploaded: json['selfieUploaded'] as bool? ?? false,
);

Map<String, dynamic> _$KycStatusToJson(_KycStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': _$KycStateEnumMap[instance.state]!,
      'idType': instance.idType,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'documentsUploaded': instance.documentsUploaded,
      'selfieUploaded': instance.selfieUploaded,
    };

const _$KycStateEnumMap = {
  KycState.notStarted: 'notStarted',
  KycState.inProgress: 'inProgress',
  KycState.pendingReview: 'pendingReview',
  KycState.verified: 'verified',
  KycState.rejected: 'rejected',
};
