import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

/// Reusable selection row used by language and theme pickers.
class _SelectableRow extends StatelessWidget {
  const _SelectableRow({
    required this.label,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.icon,
  });

  final String label;
  final String? subtitle;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: FeloCard(
        onTap: onTap,
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label),
                  if (subtitle != null)
                    Text(subtitle!,
                        style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                color: FeloColors.feloiTeal,
              ),
          ],
        ),
      ),
    );
  }
}

class LanguagePickerScreen extends ConsumerStatefulWidget {
  const LanguagePickerScreen({super.key});

  @override
  ConsumerState<LanguagePickerScreen> createState() =>
      _LanguagePickerScreenState();
}

class _LanguagePickerScreenState extends ConsumerState<LanguagePickerScreen> {
  String _selected = 'en';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.languageTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SelectableRow(
            label: l10n.languageEnglish,
            subtitle: 'English',
            selected: _selected == 'en',
            onTap: () => setState(() => _selected = 'en'),
          ),
          _SelectableRow(
            label: l10n.languageUrdu,
            subtitle: 'اردو',
            selected: _selected == 'ur',
            onTap: () => setState(() => _selected = 'ur'),
          ),
          const SizedBox(height: 8),
          Text(l10n.languageHelper,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class ThemePickerScreen extends ConsumerStatefulWidget {
  const ThemePickerScreen({super.key});

  @override
  ConsumerState<ThemePickerScreen> createState() => _ThemePickerScreenState();
}

class _ThemePickerScreenState extends ConsumerState<ThemePickerScreen> {
  String _selected = 'dark';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.themeTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SelectableRow(
            icon: Icons.brightness_auto_rounded,
            label: l10n.themeSystem,
            selected: _selected == 'system',
            onTap: () => setState(() => _selected = 'system'),
          ),
          _SelectableRow(
            icon: Icons.light_mode_rounded,
            label: l10n.themeLight,
            selected: _selected == 'light',
            onTap: () => setState(() => _selected = 'light'),
          ),
          _SelectableRow(
            icon: Icons.dark_mode_rounded,
            label: l10n.themeDark,
            selected: _selected == 'dark',
            onTap: () => setState(() => _selected = 'dark'),
          ),
        ],
      ),
    );
  }
}

class NotificationPreferencesScreen extends ConsumerStatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  ConsumerState<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends ConsumerState<NotificationPreferencesScreen> {
  bool _budgets = true;
  bool _goals = true;
  bool _family = true;
  bool _coach = false;
  bool _system = true;
  bool _quietHours = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.notifPrefsTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _ToggleCard(
            label: l10n.notifPrefsBudgets,
            value: _budgets,
            onChanged: (v) => setState(() => _budgets = v),
          ),
          _ToggleCard(
            label: l10n.notifPrefsGoals,
            value: _goals,
            onChanged: (v) => setState(() => _goals = v),
          ),
          _ToggleCard(
            label: l10n.notifPrefsFamily,
            value: _family,
            onChanged: (v) => setState(() => _family = v),
          ),
          _ToggleCard(
            label: l10n.notifPrefsCoach,
            value: _coach,
            onChanged: (v) => setState(() => _coach = v),
          ),
          _ToggleCard(
            label: l10n.notifPrefsSystem,
            value: _system,
            onChanged: (v) => setState(() => _system = v),
          ),
          const SizedBox(height: 8),
          _ToggleCard(
            label: l10n.notifPrefsQuietHours,
            subtitle: l10n.notifPrefsQuietHoursHelper,
            value: _quietHours,
            onChanged: (v) => setState(() => _quietHours = v),
          ),
        ],
      ),
    );
  }
}

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: FeloCard(
        padding: EdgeInsets.zero,
        child: SwitchListTile.adaptive(
          value: value,
          onChanged: onChanged,
          title: Text(label),
          subtitle: subtitle != null ? Text(subtitle!) : null,
        ),
      ),
    );
  }
}

class DataExportScreen extends ConsumerStatefulWidget {
  const DataExportScreen({super.key});

  @override
  ConsumerState<DataExportScreen> createState() => _DataExportScreenState();
}

class _DataExportScreenState extends ConsumerState<DataExportScreen> {
  bool _requested = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.dataExportTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.dataExportBody),
          const SizedBox(height: 16),
          for (final scope in const [
            ('all', Icons.inventory_2_outlined),
            ('transactions', Icons.receipt_long_outlined),
            ('budgets', Icons.pie_chart_outline_rounded),
            ('goals', Icons.flag_outlined),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FeloCard(
                child: Row(
                  children: [
                    Icon(scope.$2),
                    const SizedBox(width: 12),
                    Expanded(child: Text(_scopeLabel(l10n, scope.$1))),
                    const Icon(Icons.check_circle_rounded,
                        color: FeloColors.feloiTeal),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          FeloButton(
            label: _requested
                ? l10n.dataExportRequested
                : l10n.dataExportRequestCta,
            onPressed: _requested ? null : () => setState(() => _requested = true),
          ),
          if (_requested) ...[
            const SizedBox(height: 12),
            Text(l10n.dataExportEta,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ],
      ),
    );
  }

  String _scopeLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'all':
        return l10n.dataExportScopeAll;
      case 'transactions':
        return l10n.dataExportScopeTransactions;
      case 'budgets':
        return l10n.dataExportScopeBudgets;
      case 'goals':
        return l10n.dataExportScopeGoals;
      default:
        return '';
    }
  }
}

class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() =>
      _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  final _confirmController = TextEditingController();
  bool get _ready =>
      _confirmController.text.trim().toUpperCase() == 'DELETE';

  @override
  void initState() {
    super.initState();
    _confirmController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.deleteAccountTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 36),
                const SizedBox(height: 12),
                Text(
                  l10n.deleteAccountWarningTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(l10n.deleteAccountWarningBody),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.deleteAccountTypePrompt),
          const SizedBox(height: 8),
          TextField(
            controller: _confirmController,
            decoration: InputDecoration(
              labelText: l10n.deleteAccountConfirmLabel,
              hintText: 'DELETE',
            ),
          ),
          const SizedBox(height: 20),
          FeloButton(
            label: l10n.deleteAccountCta,
            onPressed: _ready
                ? () {
                    showDialog<void>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l10n.deleteAccountSubmittedTitle),
                        content: Text(l10n.deleteAccountSubmittedBody),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              context.go('/auth');
                            },
                            child: Text(l10n.commonDone),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.aboutTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.appName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(l10n.aboutTagline),
                const SizedBox(height: 16),
                _AboutRow(label: l10n.aboutVersion, value: '0.1.0+1'),
                _AboutRow(label: l10n.aboutBuild, value: 'phase1.dev'),
                _AboutRow(label: l10n.aboutCopyright, value: '© 2026 Felo'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _AboutRow(
            label: l10n.helpTerms,
            value: l10n.commonView,
            onTap: () => context.go('/help'),
          ),
          _AboutRow(
            label: l10n.helpPrivacy,
            value: l10n.commonView,
            onTap: () => context.go('/help'),
          ),
          _AboutRow(
            label: l10n.helpLicenses,
            value: l10n.commonView,
            onTap: () => context.go('/help'),
          ),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  const _AboutRow({required this.label, required this.value, this.onTap});

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: FeloCard(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(child: Text(label)),
            Text(value, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
