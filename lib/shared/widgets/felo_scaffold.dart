import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_radius.dart';
import 'package:felo/core/theme/felo_shadows.dart';

enum FeloRootTab { home, activity, coach, doHub, goals }

class FeloScaffold extends StatelessWidget {
  const FeloScaffold({
    required this.title,
    required this.child,
    super.key,
    this.selectedTab,
    this.actions,
  });

  final String title;
  final Widget child;
  final FeloRootTab? selectedTab;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: child),
            const _ComplianceFooter(),
          ],
        ),
      ),
      bottomNavigationBar: selectedTab == null
          ? null
          : _FeloBottomNav(
              selectedTab: selectedTab!,
              onDestinationSelected: (tab) => _goToTab(context, tab),
            ),
    );
  }

  void _goToTab(BuildContext context, FeloRootTab tab) {
    switch (tab) {
      case FeloRootTab.home:
        context.go('/home');
      case FeloRootTab.activity:
        context.go('/transactions');
      case FeloRootTab.coach:
        context.go('/coach');
      case FeloRootTab.doHub:
        context.go('/do');
      case FeloRootTab.goals:
        context.go('/goals');
    }
  }
}

class _FeloBottomNav extends StatelessWidget {
  const _FeloBottomNav({
    required this.selectedTab,
    required this.onDestinationSelected,
  });

  final FeloRootTab selectedTab;
  final ValueChanged<FeloRootTab> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: FeloCornerRadius.lgAll,
          boxShadow: FeloShadows.md,
        ),
        child: ClipRRect(
          borderRadius: FeloCornerRadius.lgAll,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: colors.surface.withValues(alpha: 0.82),
                indicatorColor: colors.primaryContainer,
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  final selected = states.contains(WidgetState.selected);
                  return TextStyle(
                    color: selected ? colors.primary : colors.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  );
                }),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  final selected = states.contains(WidgetState.selected);
                  return IconThemeData(
                    color: selected ? colors.primary : colors.onSurfaceVariant,
                    size: 24,
                  );
                }),
              ),
              child: NavigationBar(
                height: 72,
                elevation: 0,
                selectedIndex: selectedTab.index,
                onDestinationSelected: (index) =>
                    onDestinationSelected(FeloRootTab.values[index]),
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home_rounded),
                    label: context.l10n.navHome,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.receipt_long_outlined),
                    selectedIcon: const Icon(Icons.receipt_long_rounded),
                    label: context.l10n.navActivity,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.chat_bubble_outline_rounded),
                    selectedIcon: const Icon(Icons.chat_bubble_rounded),
                    label: context.l10n.navCoach,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.widgets_outlined),
                    selectedIcon: const Icon(Icons.widgets_rounded),
                    label: context.l10n.navDo,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.flag_outlined),
                    selectedIcon: const Icon(Icons.flag_rounded),
                    label: context.l10n.navGoals,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComplianceFooter extends StatelessWidget {
  const _ComplianceFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 8),
      child: Text(
        context.l10n.complianceFooter,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withValues(alpha: 0.56),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
