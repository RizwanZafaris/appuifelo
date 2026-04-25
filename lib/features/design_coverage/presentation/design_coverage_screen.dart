import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/design/stitch_screen_registry.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class DesignCoverageScreen extends StatelessWidget {
  const DesignCoverageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final directCount = stitchScreenSpecs
        .where((spec) => spec.hasDirectImplementation)
        .length;
    return FeloScaffold(
      title: 'Stitch screen coverage',
      selectedTab: FeloRootTab.doHub,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          FeloCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stitchScreenSpecs.length} Stitch screens registered',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  '$directCount mapped to current Flutter flows. '
                  '${stitchScreenSpecs.length - directCount} are available '
                  'through placeholder routes for implementation tracking.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final spec in stitchScreenSpecs) ...[
            _ScreenCoverageRow(spec: spec),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class DesignScreenAvailabilityScreen extends StatelessWidget {
  const DesignScreenAvailabilityScreen({required this.screenId, super.key});

  final String screenId;

  @override
  Widget build(BuildContext context) {
    final spec = stitchScreenById(screenId);
    if (spec == null) {
      return FeloScaffold(
        title: 'Unknown design screen',
        selectedTab: FeloRootTab.doHub,
        child: FeloEmptyState(
          title: 'Design screen not registered',
          body: screenId,
          actionLabel: 'Back to coverage',
          onAction: () => context.go('/design-screens'),
        ),
      );
    }

    return FeloScaffold(
      title: spec.title,
      selectedTab: FeloRootTab.doHub,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          FeloCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spec.id,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  spec.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FeloChip(
                      label: spec.hasDirectImplementation
                          ? 'Mapped to Flutter flow'
                          : 'Placeholder route',
                      selected: spec.hasDirectImplementation,
                    ),
                    const FeloChip(label: 'Stitch export'),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  spec.hasDirectImplementation
                      ? 'This design maps to ${spec.implementationRoute}. '
                            'Use the action below to open the nearest current '
                            'Flutter implementation.'
                      : 'This design screen is registered and reachable in '
                            'Flutter as an implementation placeholder. Build '
                            'the production UI from this route when its feature '
                            'moves into scope.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (spec.implementationRoute case final route?)
            FilledButton.icon(
              onPressed: () => context.go(route),
              icon: const Icon(Icons.open_in_new_rounded),
              label: Text('Open $route'),
            )
          else
            FilledButton.icon(
              onPressed: () => context.go('/do'),
              icon: const Icon(Icons.widgets_rounded),
              label: const Text('Open Do hub'),
            ),
        ],
      ),
    );
  }
}

class _ScreenCoverageRow extends StatelessWidget {
  const _ScreenCoverageRow({required this.spec});

  final StitchScreenSpec spec;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      onTap: () => context.go(spec.availabilityRoute),
      semanticLabel: spec.title,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            spec.hasDirectImplementation
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: spec.hasDirectImplementation
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spec.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  spec.implementationRoute ?? spec.availabilityRoute,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
