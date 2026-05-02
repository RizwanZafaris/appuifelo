import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';

part 'mfa_repository.g.dart';

class MfaStatus {
  const MfaStatus({
    required this.enabled,
    required this.recoveryCodesRemaining,
  });

  factory MfaStatus.fromJson(Map<String, dynamic> json) {
    final recoveryCodes = json['recoveryCodes'];
    return MfaStatus(
      enabled: json['enabled'] as bool? ?? json['verified'] as bool? ?? false,
      recoveryCodesRemaining:
          _intFromJson(
            json['recoveryCodesRemaining'] ??
                json['remainingRecoveryCodes'] ??
                json['recoveryCodesCount'],
          ) ??
          (recoveryCodes is List ? recoveryCodes.length : 0),
    );
  }

  final bool enabled;
  final int recoveryCodesRemaining;
}

class MfaEnrollment {
  const MfaEnrollment({
    required this.secret,
    required this.otpauth,
    required this.qrPngDataUrl,
  });

  factory MfaEnrollment.fromJson(Map<String, dynamic> json) {
    return MfaEnrollment(
      secret: json['secret'] as String? ?? '',
      otpauth: json['otpauth'] as String? ?? '',
      qrPngDataUrl: json['qrPngDataUrl'] as String? ?? '',
    );
  }

  final String secret;
  final String otpauth;
  final String qrPngDataUrl;
}

abstract class MfaRepository {
  Future<MfaStatus> status();
  Future<MfaEnrollment> enroll();
  Future<List<String>> verifyEnrollment(String code);
  Future<void> disable();
}

class ApiMfaRepository implements MfaRepository {
  const ApiMfaRepository(this._api);

  final FeloApiClient _api;

  @override
  Future<MfaStatus> status() async {
    return MfaStatus.fromJson(await _api.mfaStatus());
  }

  @override
  Future<MfaEnrollment> enroll() async {
    return MfaEnrollment.fromJson(await _api.mfaEnroll());
  }

  @override
  Future<List<String>> verifyEnrollment(String code) async {
    final raw = await _api.mfaVerifyEnrollment({'code': code});
    final json = (raw as Map?)?.cast<String, dynamic>() ?? const {};
    final codes = json['recoveryCodes'];
    if (codes is List) {
      return codes.map((code) => code.toString()).toList();
    }
    return const [];
  }

  @override
  Future<void> disable() async {
    await _api.mfaDisable();
  }
}

@riverpod
MfaRepository mfaRepository(MfaRepositoryRef ref) {
  return ApiMfaRepository(ref.watch(feloApiClientProvider));
}

@riverpod
Future<MfaStatus> mfaStatus(MfaStatusRef ref) {
  return ref.watch(mfaRepositoryProvider).status();
}

@riverpod
Future<MfaEnrollment> mfaEnrollment(MfaEnrollmentRef ref) {
  return ref.watch(mfaRepositoryProvider).enroll();
}

int? _intFromJson(Object? value) {
  return switch (value) {
    int() => value,
    num() => value.toInt(),
    String() => int.tryParse(value),
    _ => null,
  };
}
