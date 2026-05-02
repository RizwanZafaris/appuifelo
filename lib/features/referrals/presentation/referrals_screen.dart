import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/referrals/data/referrals_repository.dart';
import 'package:felo/features/referrals/domain/referral_models.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class ReferralsScreen extends ConsumerWidget {
  const ReferralsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final snapshot = ref.watch(referralsSnapshotProvider);

    return FeloScaffold(
      title: l10n.referralsTitle,
      child: snapshot.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => FeloEmptyState(
          title: l10n.referralsErrorTitle,
          body: l10n.referralsErrorBody,
          actionLabel: l10n.commonRetry,
          onAction: () => ref.invalidate(referralsSnapshotProvider),
        ),
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.refresh(referralsSnapshotProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _ReferralCodeCard(code: data.code),
              const SizedBox(height: 12),
              _StatsGrid(stats: data.stats),
              const SizedBox(height: 12),
              FeloButton(
                label: l10n.referralsRedeemCta,
                icon: Icons.card_giftcard_rounded,
                onPressed: () => context.go('/referrals/redeem'),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.referralsInvitesTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              if (data.invites.isEmpty)
                FeloEmptyState(
                  title: l10n.referralsNoInvitesTitle,
                  body: l10n.referralsNoInvitesBody,
                )
              else
                for (final invite in data.invites) ...[
                  _InviteTile(invite: invite),
                  const SizedBox(height: 10),
                ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferralCodeCard extends StatelessWidget {
  const _ReferralCodeCard({required this.code});

  final ReferralCode code;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.referralsHeroTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(l10n.referralsHeroBody),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      code.code,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.referralsCopyCode,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code.code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.referralsCodeCopied)),
                      );
                    },
                    icon: const Icon(Icons.copy_rounded),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FeloButton(
            label: l10n.referralsShareCta,
            icon: Icons.ios_share_rounded,
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(text: l10n.referralsShareMessage(code.shareUrl)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});

  final ReferralStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.65,
      children: [
        _StatTile(label: l10n.referralsInvited, value: '${stats.invitedCount}'),
        _StatTile(
          label: l10n.referralsCompleted,
          value: '${stats.completedCount}',
        ),
        _StatTile(
          label: l10n.referralsPending,
          value: formatMinorMoney(
            minor: stats.pendingRewardMinor,
            currency: stats.currency,
          ),
        ),
        _StatTile(
          label: l10n.referralsEarned,
          value: formatMinorMoney(
            minor: stats.earnedRewardMinor,
            currency: stats.currency,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _InviteTile extends StatelessWidget {
  const _InviteTile({required this.invite});

  final ReferralInvite invite;

  @override
  Widget build(BuildContext context) {
    final displayName = invite.displayName.isEmpty
        ? context.l10n.referralsInviteFallbackName
        : invite.displayName;
    return FeloCard(
      child: Row(
        children: [
          CircleAvatar(child: Text(displayName.characters.first.toUpperCase())),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(invite.status),
              ],
            ),
          ),
          Text(
            formatMinorMoney(
              minor: invite.rewardMinor,
              currency: invite.currency,
            ),
          ),
        ],
      ),
    );
  }
}
