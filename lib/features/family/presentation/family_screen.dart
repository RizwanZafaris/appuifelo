import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/family/data/family_repository.dart';
import 'package:felo/features/family/domain/family_group.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class FamilyScreen extends ConsumerWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final groupsAsync = ref.watch(familyGroupsProvider);

    return FeloScaffold(
      title: l10n.familyTitle,
      selectedTab: FeloRootTab.home,
      child: groupsAsync.when(
        data: (groups) => _FamilyContent(groups: groups),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorGeneric(e.toString()))),
      ),
    );
  }
}

class _FamilyContent extends StatelessWidget {
  const _FamilyContent({required this.groups});

  final List<FamilyGroup> groups;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (groups.isEmpty) {
      return FeloEmptyState(
        title: l10n.familyEmptyTitle,
        body: l10n.familyEmptyBody,
        actionLabel: l10n.familyCreateGroup,
        onAction: () => context.go('/family/invite'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        FeloButton(
          label: l10n.familyCreateGroup,
          icon: Icons.add_rounded,
          onPressed: () => _showCreateGroupSheet(context),
        ),
        const SizedBox(height: 16),
        for (final group in groups) ...[
          FeloCard(
            onTap: () => context.go('/family/${group.id}'),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: const Icon(Icons.groups_2_rounded),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        l10n.familyMemberCount(group.members.length),
                      ),
                    ],
                  ),
                ),
                if (group.isDefault)
                  Chip(
                    label: Text(l10n.familyDefaultLabel),
                  ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Future<void> _showCreateGroupSheet(BuildContext context) async {
    final l10n = context.l10n;
    final controller = TextEditingController();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.familyCreateGroupTitle,
                style: Theme.of(sheetContext).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: l10n.familyGroupNameLabel,
                  hintText: l10n.familyGroupNameHint,
                ),
              ),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.commonCreate,
                icon: Icons.check_rounded,
                onPressed: () {
                  final name = controller.text.trim();
                  if (name.isNotEmpty) {
                    // In a real implementation, we'd call the repository
                    Navigator.of(sheetContext).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
    controller.dispose();
  }
}
