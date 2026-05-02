import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

/// Network / offline error state. Shown when sync fails or connectivity
/// drops while a screen depends on remote data.
class NetworkErrorScreen extends ConsumerWidget {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.networkErrorTitle,
      selectedTab: FeloRootTab.home,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_rounded, size: 72),
              const SizedBox(height: 16),
              Text(
                l10n.networkErrorHeading,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.networkErrorBody,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 24),
              FeloButton(
                label: l10n.networkErrorRetry,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// App-lock screen. Shown after biometric timeout or fresh launch when
/// biometric lock is enabled.
class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  final _pinController = TextEditingController();
  bool _error = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _attempt() {
    // Stub: PIN "1234" unlocks; biometric is mocked.
    if (_pinController.text == '1234') {
      context.go('/home');
    } else {
      setState(() => _error = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.appLockTitle,
      selectedTab: FeloRootTab.home,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline_rounded, size: 72),
              const SizedBox(height: 16),
              Text(
                l10n.appLockHeading,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 16),
              FeloInput(
                label: l10n.appLockPinLabel,
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              if (_error) ...[
                const SizedBox(height: 8),
                Text(l10n.appLockWrongPin,
                    style: TextStyle(color: Colors.red.shade400)),
              ],
              const SizedBox(height: 16),
              FeloButton(
                label: l10n.appLockUnlock,
                onPressed: _attempt,
              ),
              const SizedBox(height: 8),
              FeloButton(
                label: l10n.appLockUseBiometric,
                variant: FeloButtonVariant.secondary,
                icon: Icons.fingerprint_rounded,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Deep-link landing page when a user taps a family invite link.
/// Reads token from query param and shows accept/decline UI.
class FamilyInviteAcceptScreen extends ConsumerStatefulWidget {
  const FamilyInviteAcceptScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<FamilyInviteAcceptScreen> createState() =>
      _FamilyInviteAcceptScreenState();
}

class _FamilyInviteAcceptScreenState
    extends ConsumerState<FamilyInviteAcceptScreen> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.familyInviteTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.groups_2_outlined, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.familyInviteFromHeading,
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(l10n.familyInviteDescription),
                const SizedBox(height: 12),
                _PermissionRow(
                  label: l10n.familyInvitePermViewTxns,
                  granted: true,
                ),
                _PermissionRow(
                  label: l10n.familyInvitePermViewBudgets,
                  granted: true,
                ),
                _PermissionRow(
                  label: l10n.familyInvitePermEditBudgets,
                  granted: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_accepted)
            FeloCard(
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded,
                      color: FeloColors.feloiTeal),
                  const SizedBox(width: 12),
                  Expanded(child: Text(l10n.familyInviteAccepted)),
                ],
              ),
            )
          else ...[
            FeloButton(
              label: l10n.familyInviteAcceptCta,
              onPressed: () => setState(() => _accepted = true),
            ),
            const SizedBox(height: 8),
            FeloButton(
              label: l10n.familyInviteDeclineCta,
              variant: FeloButtonVariant.secondary,
              onPressed: () => context.go('/home'),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            l10n.familyInviteTokenHint(widget.token),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({required this.label, required this.granted});

  final String label;
  final bool granted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            granted ? Icons.check_circle_rounded : Icons.cancel_outlined,
            size: 18,
            color: granted ? FeloColors.feloiTeal : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
