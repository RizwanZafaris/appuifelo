import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// Universal goal-card grid item used by Phase 5.2 goals selection.
///
/// Visual: square-ish card with icon top, label bottom. Shows selected
/// state with teal border + filled background. The slot indicator (1/2)
/// only renders when `slot != null` so the same widget works for both
/// the grid and the per-goal detail header.
class GoalCard extends StatelessWidget {
  const GoalCard({
    required this.icon,
    required this.label,
    this.selected = false,
    this.slot,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final int? slot; // 1, 2, or null
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? FeloColors.feloiTeal.withValues(alpha: 0.12)
          : colors.surfaceContainerHighest.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              width: selected ? 2 : 1,
              color: selected
                  ? FeloColors.feloiTeal
                  : colors.outlineVariant.withValues(alpha: 0.4),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 36,
                    color:
                        selected ? FeloColors.feloiTeal : colors.onSurface,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: selected
                              ? FeloColors.feloiTeal
                              : colors.onSurface,
                        ),
                  ),
                ],
              ),
              if (slot != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: FeloColors.feloiTeal,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      slot!.toString(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Maps `goal_templates.icon_key` strings to Material icons.
/// Single source of truth for icon name → IconData mapping.
IconData iconForGoalKey(String key) {
  return switch (key) {
    'home' => Icons.home_rounded,
    'car' => Icons.directions_car_rounded,
    'graduation_cap' => Icons.school_rounded,
    'plane' => Icons.flight_rounded,
    'rings' => Icons.favorite_rounded,
    'family' => Icons.family_restroom_rounded,
    'sun' => Icons.wb_sunny_rounded,
    'trending_up' => Icons.trending_up_rounded,
    'shield' => Icons.shield_rounded,
    'kaaba' => Icons.mosque_rounded,
    'pencil' => Icons.edit_rounded,
    _ => Icons.flag_rounded,
  };
}
