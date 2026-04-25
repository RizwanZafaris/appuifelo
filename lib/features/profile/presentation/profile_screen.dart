import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(profileSettingsProvider);
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
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FeloCard(
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
