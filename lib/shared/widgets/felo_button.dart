import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/core/theme/felo_radius.dart';
import 'package:felo/core/theme/felo_shadows.dart';

enum FeloButtonVariant { primary, secondary, ghost }

class FeloButton extends StatefulWidget {
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
  State<FeloButton> createState() => _FeloButtonState();
}

class _FeloButtonState extends State<FeloButton> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;
    const radius = FeloCornerRadius.mdAll;
    final foregroundColor = switch (widget.variant) {
      FeloButtonVariant.primary => Colors.white,
      FeloButtonVariant.secondary => colors.onPrimaryContainer,
      FeloButtonVariant.ghost => colors.primary,
    };
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 18),
          const SizedBox(width: 8),
        ],
        Flexible(child: Text(widget.label, overflow: TextOverflow.ellipsis)),
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

    final decoration = switch (widget.variant) {
      FeloButtonVariant.primary => BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [FeloColors.lavenderPrimary, FeloColors.lavenderStrong],
        ),
        borderRadius: radius,
        boxShadow: enabled ? FeloShadows.lg : null,
        border: _focused ? Border.all(color: colors.primary, width: 2) : null,
      ),
      FeloButtonVariant.secondary => BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: radius,
        border: _focused ? Border.all(color: colors.primary, width: 2) : null,
      ),
      FeloButtonVariant.ghost => BoxDecoration(
        borderRadius: radius,
        border: _focused ? Border.all(color: colors.primary, width: 2) : null,
      ),
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
            onTap: widget.onPressed,
            focusColor: colors.primary.withValues(alpha: 0.08),
            onFocusChange: (hasFocus) {
              if (hasFocus != _focused) {
                setState(() => _focused = hasFocus);
              }
            },
            child: Ink(
              decoration: decoration,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      widget.variant == FeloButtonVariant.ghost ? 48 : 52,
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
