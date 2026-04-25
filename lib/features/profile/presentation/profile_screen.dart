import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/auth/data/mfa_repository.dart';
import 'package:felo/features/referrals/data/referrals_repository.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(profileSettingsProvider);
    final plusProfile = ref.watch(feloPlusProfileProvider);
    final plusValue = plusProfile.maybeWhen(
      data: (profile) =>
          profile.isPlus ? l10n.feloPlusStatusPlus : l10n.feloPlusStatusFree,
      orElse: () => l10n.commonView,
    );
    final mfaStatus = ref.watch(mfaStatusProvider);
    return FeloFeaturePlaceholder(
      title: l10n.profileTitle,
      body: l10n.authBody,
      icon: Icons.person_rounded,
      children: [
        FeloCard(
          child: SwitchListTile.adaptive(
            value: settings.smsParserEnabled,
            onChanged: (_) {},
            title: Text(l10n.smsParserTitle),
          ),
        ),
        const SizedBox(height: 10),
        _ProfileRow(
          label: l10n.profileLanguage,
          value: settings.languageCode.toUpperCase(),
        ),
        _ProfileRow(label: l10n.profileTheme, value: settings.themeMode.name),
        _ProfileRow(label: l10n.profileNotifications, value: l10n.commonView),
        _ProfileRow(label: l10n.profileLogout, value: l10n.commonView),
        _ProfileRow(label: l10n.profileDelete, value: l10n.commonView),
        const SizedBox(height: 6),
        _ProfileRow(
          label: l10n.languageTitle,
          value: l10n.commonView,
          onTap: () => context.go('/settings/language'),
        ),
        _ProfileRow(
          label: l10n.themeTitle,
          value: l10n.commonView,
          onTap: () => context.go('/settings/theme'),
        ),
        _ProfileRow(
          label: l10n.notifPrefsTitle,
          value: l10n.commonView,
          onTap: () => context.go('/settings/notifications'),
        ),
        _ProfileRow(
          label: l10n.biometricTitle,
          value: l10n.commonView,
          onTap: () => context.go('/auth/biometric'),
        ),
        _ProfileRow(
          label: l10n.mfaTitle,
          value: mfaStatus.when(
            data: (status) => status.enabled
                ? l10n.mfaEnabledStatus(status.recoveryCodesRemaining)
                : l10n.mfaDisabledStatus,
            error: (_, _) => l10n.mfaDisabledStatus,
            loading: () => l10n.commonView,
          ),
          onTap: () => context.go('/auth/mfa'),
        ),
        _ProfileRow(
          label: l10n.dataExportTitle,
          value: l10n.commonView,
          onTap: () => context.go('/settings/export'),
        ),
        _ProfileRow(
          label: l10n.deleteAccountTitle,
          value: l10n.commonView,
          onTap: () => context.go('/settings/delete'),
        ),
        _ProfileRow(
          label: l10n.aboutTitle,
          value: l10n.commonView,
          onTap: () => context.go('/settings/about'),
        ),
        _ProfileRow(
          label: l10n.kycTitle,
          value: l10n.commonContinue,
          onTap: () => context.go('/kyc'),
        ),
        _ProfileRow(
          label: l10n.feloPlusTitle,
          value: plusValue,
          onTap: () => context.go('/profile/felo-plus'),
        ),
        _ProfileRow(
          label: l10n.referralsTitle,
          value: l10n.commonView,
          onTap: () => context.go('/referrals'),
        ),
        _ProfileRow(
          label: l10n.helpTitle,
          value: l10n.commonView,
          onTap: () => context.go('/help'),
        ),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value, this.onTap});

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FeloCard(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(child: Text(label)),
            Text(value),
          ],
        ),
      ),
    );
  }
}
