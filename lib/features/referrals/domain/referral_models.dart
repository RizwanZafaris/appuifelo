class ReferralCode {
  const ReferralCode({required this.code, required this.shareUrl});

  factory ReferralCode.fromJson(Map<String, dynamic> json) {
    final code = _stringValue(json, ['code', 'referralCode', 'referral_code']);
    final shareUrl = _stringValue(json, [
      'shareUrl',
      'share_url',
      'inviteUrl',
      'invite_url',
      'deepLink',
      'deep_link',
    ]);
    return ReferralCode(
      code: code.isEmpty ? 'FELO5' : code,
      shareUrl: shareUrl.isEmpty ? 'https://felo.app/r/$code' : shareUrl,
    );
  }

  final String code;
  final String shareUrl;
}

class ReferralStats {
  const ReferralStats({
    required this.invitedCount,
    required this.completedCount,
    required this.pendingRewardMinor,
    required this.earnedRewardMinor,
    required this.currency,
  });

  factory ReferralStats.fromJson(Map<String, dynamic> json) {
    return ReferralStats(
      invitedCount: _intValue(json, [
        'invitedCount',
        'invited_count',
        'invites',
      ]),
      completedCount: _intValue(json, [
        'completedCount',
        'completed_count',
        'convertedCount',
        'converted_count',
      ]),
      pendingRewardMinor: _intValue(json, [
        'pendingRewardMinor',
        'pending_reward_minor',
        'pendingMinor',
      ]),
      earnedRewardMinor: _intValue(json, [
        'earnedRewardMinor',
        'earned_reward_minor',
        'creditedMinor',
        'totalRewardMinor',
      ]),
      currency: _stringValue(json, ['currency', 'rewardCurrency']).isEmpty
          ? 'CAD'
          : _stringValue(json, ['currency', 'rewardCurrency']),
    );
  }

  final int invitedCount;
  final int completedCount;
  final int pendingRewardMinor;
  final int earnedRewardMinor;
  final String currency;
}

class ReferralInvite {
  const ReferralInvite({
    required this.id,
    required this.displayName,
    required this.status,
    required this.rewardMinor,
    required this.currency,
    this.createdAt,
  });

  factory ReferralInvite.fromJson(Map<String, dynamic> json) {
    final createdAtRaw = _stringValue(json, [
      'createdAt',
      'created_at',
      'redeemedAt',
      'redeemed_at',
    ]);
    return ReferralInvite(
      id: _stringValue(json, ['id', 'referralId', 'referral_id']),
      displayName: _stringValue(json, [
        'displayName',
        'display_name',
        'refereeName',
        'referee_name',
        'email',
      ]),
      status: _stringValue(json, ['status', 'state']).isEmpty
          ? 'pending'
          : _stringValue(json, ['status', 'state']),
      rewardMinor: _intValue(json, [
        'rewardMinor',
        'reward_minor',
        'creditMinor',
        'credit_minor',
      ]),
      currency: _stringValue(json, ['currency', 'rewardCurrency']).isEmpty
          ? 'CAD'
          : _stringValue(json, ['currency', 'rewardCurrency']),
      createdAt: DateTime.tryParse(createdAtRaw),
    );
  }

  final String id;
  final String displayName;
  final String status;
  final int rewardMinor;
  final String currency;
  final DateTime? createdAt;
}

class ReferralsSnapshot {
  const ReferralsSnapshot({
    required this.code,
    required this.stats,
    required this.invites,
  });

  final ReferralCode code;
  final ReferralStats stats;
  final List<ReferralInvite> invites;
}

class FeloPlusProfile {
  const FeloPlusProfile({required this.subscriptionTier});

  factory FeloPlusProfile.fromJson(Map<String, dynamic> json) {
    final tier = _stringValue(json, [
      'subscriptionTier',
      'subscription_tier',
      'tier',
    ]);
    return FeloPlusProfile(subscriptionTier: tier.isEmpty ? 'free' : tier);
  }

  final String subscriptionTier;

  bool get isPlus => subscriptionTier.toLowerCase() == 'plus';
}

int _intValue(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is int) return value;
    if (value is num) return value.round();
    if (value is String) return int.tryParse(value) ?? 0;
  }
  return 0;
}

String _stringValue(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value == null) continue;
    return value.toString();
  }
  return '';
}
