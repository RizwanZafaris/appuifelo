import 'package:flutter/material.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class FeloFeaturePlaceholder extends StatelessWidget {
  const FeloFeaturePlaceholder({
    required this.title,
    required this.body,
    super.key,
    this.selectedTab,
    this.icon = Icons.auto_awesome_rounded,
    this.children = const [],
  });

  final String title;
  final String body;
  final FeloRootTab? selectedTab;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return FeloScaffold(
      title: title,
      selectedTab: selectedTab,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(body),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (children.isEmpty)
            FeloEmptyState(
              title: context.l10n.emptyTitle,
              body: context.l10n.emptyBody,
            )
          else
            ...children,
        ],
      ),
    );
  }
}
