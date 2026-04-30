import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/kyc/domain/kyc_status.dart';

part 'kyc_repository.g.dart';

// ============================================================================
// Abstract Interface
// ============================================================================

abstract class KycRepository {
  Future<KycStatus> getStatus();
  Future<KycStatus> initiate({required String idType});
}

// ============================================================================
// API Implementation
// ============================================================================

class ApiKycRepository implements KycRepository {
  ApiKycRepository(this._api);

  final FeloApiClient _api;

  @override
  Future<KycStatus> getStatus() async {
    final raw = await _api.getKycStatus();
    return _kycStatusFromApi((raw as Map).cast<String, dynamic>());
  }

  @override
  Future<KycStatus> initiate({required String idType}) async {
    final raw = await _api.initiateKyc({'idType': idType});
    return _kycStatusFromApi((raw as Map).cast<String, dynamic>());
  }
}

// ============================================================================
// Fake Implementation (demo/offline mode)
// ============================================================================

class FakeKycRepository implements KycRepository {
  KycStatus _status = const KycStatus(
    id: 'kyc_default',
    state: KycState.notStarted,
  );

  @override
  Future<KycStatus> getStatus() async => _status;

  @override
  Future<KycStatus> initiate({required String idType}) async {
    _status = KycStatus(
      id: 'kyc_default',
      state: KycState.inProgress,
      idType: idType,
      documentsUploaded: true,
      selfieUploaded: true,
      submittedAt: DateTime.now(),
    );
    return _status;
  }
}

// ============================================================================
// JSON Helper
// ============================================================================

KycStatus _kycStatusFromApi(Map<String, dynamic> json) {
  final stateStr = (json['state'] ?? json['status'] ?? 'not_started')
      .toString()
      .toLowerCase();
  return KycStatus(
    id: json['id'].toString(),
    state: KycState.values.firstWhere(
      (s) => s.name.toLowerCase() == stateStr,
      orElse: () => KycState.notStarted,
    ),
    idType: json['idType']?.toString() ?? json['id_type']?.toString(),
    submittedAt: DateTime.tryParse(
      (json['submittedAt'] ?? json['submitted_at'] ?? '').toString(),
    ),
    reviewedAt: DateTime.tryParse(
      (json['reviewedAt'] ?? json['reviewed_at'] ?? '').toString(),
    ),
    rejectionReason:
        json['rejectionReason']?.toString() ??
        json['rejection_reason']?.toString(),
    documentsUploaded:
        json['documentsUploaded'] == true ||
        json['documents_uploaded'] == true,
    selfieUploaded:
        json['selfieUploaded'] == true || json['selfie_uploaded'] == true,
  );
}
