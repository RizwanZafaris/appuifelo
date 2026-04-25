import 'package:flutter/material.dart';

class FeloChip extends StatelessWidget {
  const FeloChip({
    required this.label,
    super.key,
    this.icon,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      button: onTap != null,
      selected: selected,
      child: ActionChip(
        avatar: icon == null ? null : Icon(icon, size: 16),
        label: Text(label),
        onPressed: onTap,
        color: WidgetStateProperty.resolveWith((states) {
          if (selected) {
            return colors.primaryContainer;
          }
          return colors.surfaceContainerHighest;
        }),
        labelStyle: TextStyle(
          color: selected ? colors.onPrimaryContainer : colors.onSurface,
          fontWeight: FontWeight.w700,
        ),
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? colors.primary : colors.outlineVariant,
          ),
        ),
      ),
    );
  }
}
