import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/kyc/data/kyc_repository.dart';
import 'package:felo/features/kyc/domain/kyc_status.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class KycStatusScreen extends ConsumerWidget {
  const KycStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final statusAsync = ref.watch(kycStatusProvider);

    return FeloScaffold(
      title: l10n.kycStatusTitle,
      selectedTab: FeloRootTab.home,
      child: statusAsync.when(
        data: (status) => _StatusContent(status: status),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorGeneric(e.toString()))),
      ),
    );
  }
}

class _StatusContent extends StatelessWidget {
  const _StatusContent({required this.status});

  final KycStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _StatusCard(status: status),
        const SizedBox(height: 20),
        if (status.state == KycState.notStarted)
          FeloButton(
            label: l10n.kycStartButton,
            icon: Icons.verified_user_rounded,
            onPressed: () => context.go('/kyc'),
          ),
        if (status.state == KycState.rejected) ...[
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.kycRejectionTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  status.rejectionReason ?? l10n.kycRejectionDefault,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FeloButton(
            label: l10n.kycRetryButton,
            icon: Icons.refresh_rounded,
            onPressed: () => context.go('/kyc'),
          ),
        ],
        if (status.state == KycState.pendingReview) ...[
          FeloCard(
            child: Column(
              children: [
                Icon(
                  Icons.hourglass_top_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.kycPendingTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  status.submittedAt != null
                      ? l10n.kycPendingBody(
                          MaterialLocalizations.of(context).formatShortDate(
                            status.submittedAt!,
                          ),
                        )
                      : l10n.kycPendingBodyNoDate,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
        if (status.state == KycState.verified) ...[
          FeloCard(
            child: Column(
              children: [
                Icon(
                  Icons.verified_rounded,
                  size: 48,
                  color: Colors.green.shade600,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.kycVerifiedTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.kycVerifiedBody,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.status});

  final KycStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, color, label) = _statusInfo(context, status.state);

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: color),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${l10n.kycIdTypeLabel}: ${_idTypeLabel(l10n, status.idType)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _ChecklistRow(
            label: l10n.kycChecklistDocuments,
            complete: status.documentsUploaded,
          ),
          _ChecklistRow(
            label: l10n.kycChecklistSelfie,
            complete: status.selfieUploaded,
          ),
        ],
      ),
    );
  }

  (IconData, Color, String) _statusInfo(BuildContext context, KycState state) {
    final l10n = context.l10n;
    return switch (state) {
      KycState.notStarted => (Icons.circle_outlined, Colors.grey, l10n.kycStateNotStarted),
      KycState.inProgress => (Icons.hourglass_empty_rounded, Colors.orange, l10n.kycStateInProgress),
      KycState.pendingReview => (Icons.hourglass_top_rounded, Theme.of(context).colorScheme.primary, l10n.kycStatePendingReview),
      KycState.verified => (Icons.verified_rounded, Colors.green.shade600, l10n.kycStateVerified),
      KycState.rejected => (Icons.cancel_rounded, Theme.of(context).colorScheme.error, l10n.kycStateRejected),
    };
  }

  String _idTypeLabel(AppLocalizations l10n, String? idType) {
    return switch (idType) {
      'passport' => l10n.kycIdPassport,
      'cnic' => l10n.kycIdCnic,
      'drivers_license' => l10n.kycIdDriversLicense,
      null || '' => '—',
      _ => idType,
    };
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({required this.label, required this.complete});

  final String label;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            complete ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            color: complete ? Colors.green : Theme.of(context).colorScheme.outline,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
