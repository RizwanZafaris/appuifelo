import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/core/theme/felo_radius.dart';
import 'package:felo/core/theme/felo_spacing.dart';

class FeloCard extends StatelessWidget {
  const FeloCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(FeloSpacing.md),
    this.onTap,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    const radius = FeloCornerRadius.mdAll;
    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.92),
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: FeloColors.lavenderMascot.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );

    if (onTap == null) {
      return Semantics(label: semanticLabel, child: card);
    }

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: colors.surface,
        borderRadius: radius,
        child: InkWell(borderRadius: radius, onTap: onTap, child: card),
      ),
    );
  }
}
