import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';

class FamilyScreen extends ConsumerWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final members = ref.watch(familyMembersProvider);
    return FeloFeaturePlaceholder(
      title: l10n.familyTitle,
      body: l10n.familyBody,
      icon: Icons.groups_2_rounded,
      children: [
        FeloButton(label: l10n.familyInvite, icon: Icons.link_rounded, onPressed: () {}),
        const SizedBox(height: 16),
        for (final member in members) ...[
          FeloCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(child: Icon(Icons.person_outline_rounded)),
              title: Text(member.displayName),
              subtitle: Text(member.phoneMasked),
              trailing: Text(_roleLabel(context, member.role.name)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  String _roleLabel(BuildContext context, String role) {
    final l10n = context.l10n;
    return switch (role) {
      'admin' => l10n.familyAdmin,
      'member' => l10n.familyMember,
      _ => l10n.familyViewer,
    };
  }
}
