import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/family/data/family_repository.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class FamilyGroupDetailScreen extends ConsumerWidget {
  const FamilyGroupDetailScreen({required this.groupId, super.key});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final groupAsync = ref.watch(familyGroupProvider(groupId));
    final membersAsync = ref.watch(familyMembersProvider(groupId));

    return FeloScaffold(
      title: l10n.familyGroupDetailTitle,
      selectedTab: FeloRootTab.home,
      actions: [
        IconButton(
          tooltip: l10n.familyInvite,
          onPressed: () => context.go('/family/invite'),
          icon: const Icon(Icons.person_add_rounded),
        ),
      ],
      child: groupAsync.when(
        data: (group) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            FeloCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.familyCreatedAt(
                      MaterialLocalizations.of(context).formatShortDate(
                        group.createdAt,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.familyMembersTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            membersAsync.when(
              data: (members) => Column(
                children: [
                  for (final member in members) ...[
                    _MemberCard(member: member),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(l10n.errorGeneric(e.toString())),
            ),
            const SizedBox(height: 16),
            FeloButton(
              label: l10n.familyInviteMember,
              icon: Icons.person_add_rounded,
              onPressed: () => context.go('/family/invite'),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorGeneric(e.toString()))),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});

  final FamilyMember member;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: const Icon(Icons.person_outline_rounded),
        ),
        title: Text(
          member.displayName,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(member.phoneMasked),
        trailing: Chip(
          label: Text(_roleLabel(context, member.role)),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }

  String _roleLabel(BuildContext context, FamilyRole role) {
    final l10n = context.l10n;
    return switch (role) {
      FamilyRole.admin => l10n.familyAdmin,
      FamilyRole.member => l10n.familyMember,
      FamilyRole.viewer => l10n.familyViewer,
    };
  }
}
