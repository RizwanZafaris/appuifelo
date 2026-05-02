import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// Selectable card with icon + label + optional subtitle. Used by the
/// sign-up method picker (FR-1.2.1), goal cards (FR-5.2.1), and
/// permission cards (FR-3.0.1).
///
/// `selected` toggles a teal border + filled background so the user
/// sees their selection without losing the icon's affordance.
class OptionCard extends StatelessWidget {
  const OptionCard({
    required this.icon,
    required this.label,
    this.subtitle,
    this.selected = false,
    this.onTap,
    this.trailing,
    super.key,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? FeloColors.mintBase.withValues(alpha: 0.18)
          : colors.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            border: Border.all(
              width: selected ? 2 : 1,
              color: selected
                  ? FeloColors.feloiTeal
                  : colors.outlineVariant.withValues(alpha: 0.4),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
                color: selected ? FeloColors.feloiTeal : colors.onSurface,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ),
      ),
    );
  }
}
