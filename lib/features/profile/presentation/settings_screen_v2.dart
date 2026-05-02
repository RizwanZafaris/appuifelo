import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';

/// Wio-inspired settings screen with grouped sections.
/// Clean cards, section headers, toggle switches.
class SettingsScreenV2 extends ConsumerWidget {
  const SettingsScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: FeloColors.surface,
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Card
          _ProfileCard(),
          const SizedBox(height: 24),

          // Account Section
          _SectionHeader(title: 'Account'),
          const SizedBox(height: 12),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.person_outline_rounded,
                iconColor: FeloColors.floTrust,
                title: 'Personal Info',
                subtitle: 'Name, email, phone',
                onTap: () => context.go('/profile/personal'),
              ),
              _SettingsTile(
                icon: Icons.verified_user_outlined,
                iconColor: FeloColors.floGrowth,
                title: 'KYC Verification',
                subtitle: 'Identity documents',
                onTap: () => context.go('/kyc'),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: FeloColors.floGrowth.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Verified',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: FeloColors.floGrowth,
                    ),
                  ),
                ),
              ),
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                iconColor: FeloColors.floFinance,
                title: 'Security',
                subtitle: 'Password, 2FA, biometrics',
                onTap: () => context.go('/profile/security'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Preferences Section
          _SectionHeader(title: 'Preferences'),
          const SizedBox(height: 12),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.notifications_none_rounded,
                iconColor: FeloColors.floSplit,
                title: 'Notifications',
                subtitle: 'Push, email, SMS',
                onTap: () => context.go('/profile/notifications'),
              ),
              _SettingsTile(
                icon: Icons.language_rounded,
                iconColor: FeloColors.floInvest,
                title: 'Language',
                subtitle: 'English · Urdu · Hindi',
                onTap: () => context.go('/profile/language'),
              ),
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                iconColor: FeloColors.lavenderPrimary,
                title: 'Appearance',
                subtitle: 'Light · Dark · System',
                onTap: () => context.go('/profile/theme'),
              ),
              _SettingsTile(
                icon: Icons.currency_exchange_rounded,
                iconColor: FeloColors.floTrust,
                title: 'Currency',
                subtitle: 'CAD · PKR · INR · BDT',
                onTap: () => context.go('/profile/currency'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Finance Section
          _SectionHeader(title: 'Finance'),
          const SizedBox(height: 12),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.account_balance_outlined,
                iconColor: FeloColors.floGrowth,
                title: 'Linked Accounts',
                subtitle: 'Bank cards, wallets',
                onTap: () => context.go('/accounts'),
              ),
              _SettingsTile(
                icon: Icons.receipt_long_outlined,
                iconColor: FeloColors.floFinance,
                title: 'Transaction History',
                subtitle: 'Export, filter, search',
                onTap: () => context.go('/transactions'),
              ),
              _SettingsTile(
                icon: Icons.file_download_outlined,
                iconColor: FeloColors.floSplit,
                title: 'Data Export',
                subtitle: 'CSV, PDF, JSON',
                onTap: () => context.go('/profile/export'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Support Section
          _SectionHeader(title: 'Support'),
          const SizedBox(height: 12),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.help_outline_rounded,
                iconColor: FeloColors.floInvest,
                title: 'Help Center',
                subtitle: 'FAQs, guides, contact',
                onTap: () => context.go('/help'),
              ),
              _SettingsTile(
                icon: Icons.chat_bubble_outline_rounded,
                iconColor: FeloColors.lavenderPrimary,
                title: 'Chat with Flo',
                subtitle: 'AI assistant',
                onTap: () => context.go('/coach'),
              ),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                iconColor: FeloColors.floTrust,
                title: 'About FELO',
                subtitle: 'Version, terms, privacy',
                onTap: () => context.go('/profile/about'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sign Out
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.logout_rounded,
                iconColor: FeloColors.signalCrimson,
                title: 'Sign Out',
                titleColor: FeloColors.signalCrimson,
                onTap: () => _showSignOutDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Sign Out?'),
        content: const Text('You\'ll need to sign back in to access your account.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/auth');
            },
            style: FilledButton.styleFrom(
              backgroundColor: FeloColors.signalCrimson,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: FeloColors.heroGradientLight,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rizwan Zafar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pro Member · CAD Account',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w800,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: _divideTiles(children),
      ),
    );
  }

  List<Widget> _divideTiles(List<Widget> tiles) {
    final divided = <Widget>[];
    for (var i = 0; i < tiles.length; i++) {
      divided.add(tiles[i]);
      if (i < tiles.length - 1) {
        divided.add(const Divider(height: 1, indent: 68));
      }
    }
    return divided;
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleColor,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: titleColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
