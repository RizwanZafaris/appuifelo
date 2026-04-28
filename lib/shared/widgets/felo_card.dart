import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_radius.dart';
import 'package:felo/core/theme/felo_shadows.dart';
import 'package:felo/core/theme/felo_spacing.dart';

class FeloCard extends StatefulWidget {
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
  State<FeloCard> createState() => _FeloCardState();
}

class _FeloCardState extends State<FeloCard> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    const radius = FeloCornerRadius.mdAll;
    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.92),
        borderRadius: radius,
        boxShadow: FeloShadows.sm,
        border: _focused
            ? Border.all(color: colors.primary, width: 2)
            : null,
      ),
      child: Padding(padding: widget.padding, child: widget.child),
    );

    if (widget.onTap == null) {
      return Semantics(label: widget.semanticLabel, child: card);
    }

    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: Material(
        color: colors.surface,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: widget.onTap,
          focusColor: colors.primary.withValues(alpha: 0.08),
          onFocusChange: (hasFocus) {
            if (hasFocus != _focused) {
              setState(() => _focused = hasFocus);
            }
          },
          child: card,
        ),
      ),
    );
  }
}
