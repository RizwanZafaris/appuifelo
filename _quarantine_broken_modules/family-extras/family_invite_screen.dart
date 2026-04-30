import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class FamilyInviteScreen extends ConsumerStatefulWidget {
  const FamilyInviteScreen({super.key});

  @override
  ConsumerState<FamilyInviteScreen> createState() => _FamilyInviteScreenState();
}

class _FamilyInviteScreenState extends ConsumerState<FamilyInviteScreen> {
  final _phoneController = TextEditingController();
  FamilyRole _selectedRole = FamilyRole.member;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeloScaffold(
      title: l10n.familyInviteTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.familyInviteBody,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          FeloInput(
            label: l10n.familyInvitePhoneLabel,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            hint: l10n.familyInvitePhoneHint,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.familyInviteRoleLabel,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final role in FamilyRole.values)
                ChoiceChip(
                  label: Text(_roleLabel(role)),
                  selected: _selectedRole == role,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedRole = role);
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.familyInvitePermissionsTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                _PermissionRow(
                  icon: Icons.visibility_outlined,
                  label: l10n.familyPermissionViewTransactions,
                  allowed: _selectedRole != FamilyRole.viewer,
                ),
                _PermissionRow(
                  icon: Icons.edit_outlined,
                  label: l10n.familyPermissionEditBudgets,
                  allowed: _selectedRole == FamilyRole.admin,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FeloButton(
            label: l10n.familySendInvite,
            icon: Icons.send_rounded,
            onPressed: _sendInvite,
          ),
        ],
      ),
    );
  }

  String _roleLabel(FamilyRole role) {
    final l10n = context.l10n;
    return switch (role) {
      FamilyRole.admin => l10n.familyAdmin,
      FamilyRole.member => l10n.familyMember,
      FamilyRole.viewer => l10n.familyViewer,
    };
  }

  void _sendInvite() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;

    // In real implementation, call repository to send invite
    context.pop();
  }
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.icon,
    required this.label,
    required this.allowed,
  });

  final IconData icon;
  final String label;
  final bool allowed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            allowed ? Icons.check_circle_rounded : Icons.cancel_outlined,
            color: allowed ? Colors.green : Theme.of(context).colorScheme.outline,
            size: 20,
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}

/// Deep-link invite accept screen.
class FamilyInviteAcceptScreen extends StatelessWidget {
  const FamilyInviteAcceptScreen({required this.token, super.key});

  final String token;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FeloScaffold(
      title: l10n.familyInviteAcceptTitle,
      selectedTab: FeloRootTab.home,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.groups_2_rounded, size: 64),
            const SizedBox(height: 20),
            Text(
              l10n.familyInviteAcceptTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.familyInviteAcceptBody,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FeloButton(
              label: l10n.familyInviteAcceptButton,
              icon: Icons.check_rounded,
              onPressed: () {
                // In real implementation, call repository to accept
                context.go('/family');
              },
            ),
            const SizedBox(height: 12),
            FeloButton(
              label: l10n.commonCancel,
              variant: FeloButtonVariant.secondary,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
