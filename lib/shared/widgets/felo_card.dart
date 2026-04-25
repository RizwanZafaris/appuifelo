import 'package:flutter/material.dart';

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
    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(padding: padding, child: child),
    );

    if (onTap == null) {
      return Semantics(label: semanticLabel, child: card);
    }

    return Semantics(
      button: true,
      label: semanticLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: card,
      ),
    );
  }
}
