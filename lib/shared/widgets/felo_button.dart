import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/core/theme/felo_radius.dart';
import 'package:felo/core/theme/felo_shadows.dart';

enum FeloButtonVariant { primary, secondary, ghost }

class FeloButton extends StatelessWidget {
  const FeloButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.variant = FeloButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final FeloButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final enabled = onPressed != null;
    const radius = FeloCornerRadius.mdAll;
    final foregroundColor = switch (variant) {
      FeloButtonVariant.primary => Colors.white,
      FeloButtonVariant.secondary => colors.onPrimaryContainer,
      FeloButtonVariant.ghost => colors.primary,
    };
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );

    final content = IconTheme.merge(
      data: IconThemeData(color: foregroundColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: foregroundColor,
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
        child: child,
      ),
    );

    final decoration = switch (variant) {
      FeloButtonVariant.primary => BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [FeloColors.lavenderPrimary, FeloColors.lavenderStrong],
        ),
        borderRadius: radius,
        boxShadow: enabled ? FeloShadows.lg : null,
      ),
      FeloButtonVariant.secondary => BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: radius,
      ),
      FeloButtonVariant.ghost => const BoxDecoration(borderRadius: radius),
    };

    return Semantics(
      button: true,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.54,
        child: Material(
          color: Colors.transparent,
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: onPressed,
            child: Ink(
              decoration: decoration,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: variant == FeloButtonVariant.ghost ? 48 : 52,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(child: content),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
