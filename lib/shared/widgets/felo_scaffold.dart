import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';

enum FeloRootTab { home, activity, budgets, coach, goals }

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
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: selectedTab == null
          ? null
          : NavigationBar(
              selectedIndex: selectedTab!.index,
              onDestinationSelected: (index) => _goToTab(context, FeloRootTab.values[index]),
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
                  icon: const Icon(Icons.pie_chart_outline_rounded),
                  selectedIcon: const Icon(Icons.pie_chart_rounded),
                  label: context.l10n.navBudgets,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                  selectedIcon: const Icon(Icons.chat_bubble_rounded),
                  label: context.l10n.navCoach,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.flag_outlined),
                  selectedIcon: const Icon(Icons.flag_rounded),
                  label: context.l10n.navGoals,
                ),
              ],
            ),
    );
  }

  void _goToTab(BuildContext context, FeloRootTab tab) {
    switch (tab) {
      case FeloRootTab.home:
        context.go('/home');
      case FeloRootTab.activity:
        context.go('/transactions');
      case FeloRootTab.budgets:
        context.go('/budgets');
      case FeloRootTab.coach:
        context.go('/coach');
      case FeloRootTab.goals:
        context.go('/goals');
    }
  }
}
