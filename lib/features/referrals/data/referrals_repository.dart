import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/features/referrals/domain/referral_models.dart';

final feloApiClientProvider = Provider<FeloApiClient>((ref) {
  return FeloApiClient(ref.watch(dioProvider));
});

final referralsRepositoryProvider = Provider<ReferralsRepository>((ref) {
  return ReferralsRepository(ref.watch(feloApiClientProvider));
});

final referralsSnapshotProvider = FutureProvider.autoDispose<ReferralsSnapshot>(
  (ref) {
    return ref.watch(referralsRepositoryProvider).snapshot();
  },
);

final feloPlusProfileProvider = FutureProvider.autoDispose<FeloPlusProfile>((
  ref,
) {
  return ref.watch(referralsRepositoryProvider).plusProfile();
});

class ReferralsRepository {
  const ReferralsRepository(this._api);

  final FeloApiClient _api;

  Future<ReferralsSnapshot> snapshot() async {
    final results = await Future.wait<dynamic>([
      _api.getMyReferralCode(),
      _api.getReferralStats(),
      _api.listMyReferrals(),
    ]);
    return ReferralsSnapshot(
      code: ReferralCode.fromJson(_asMap(results[0])),
      stats: ReferralStats.fromJson(_asMap(results[1])),
      invites: [
        for (final item in _asList(results[2])) ReferralInvite.fromJson(item),
      ],
    );
  }

  Future<void> redeem(String code) async {
    try {
      await _api.redeemReferral({'code': code.trim()});
    } on DioException catch (error) {
      throw ReferralRedeemException.fromStatus(error.response?.statusCode);
    }
  }

  Future<FeloPlusProfile> plusProfile() async {
    return FeloPlusProfile.fromJson(_asMap(await _api.getMyProfile()));
  }
}

Map<String, dynamic> _asMap(Object? value) {
  return Map<String, dynamic>.from(value as Map);
}

List<Map<String, dynamic>> _asList(Object? value) {
  return [
    for (final item in value as List) Map<String, dynamic>.from(item as Map),
  ];
}

enum ReferralRedeemError { notFound, alreadyRedeemed, unknown }

class ReferralRedeemException implements Exception {
  const ReferralRedeemException(this.error);

  factory ReferralRedeemException.fromStatus(int? statusCode) {
    return ReferralRedeemException(switch (statusCode) {
      404 => ReferralRedeemError.notFound,
      409 => ReferralRedeemError.alreadyRedeemed,
      _ => ReferralRedeemError.unknown,
    });
  }

  final ReferralRedeemError error;
}
