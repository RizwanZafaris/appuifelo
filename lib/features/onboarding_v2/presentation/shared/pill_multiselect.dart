import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// Universal multi-select pill chip group.
///
/// Used by: Phase 4.1 earning types, Phase 4.2 accounts, Phase 4.4
/// investment types, Phase 6.1 family/remittance options, Phase 6.2
/// corridor countries.
///
/// **Single source of truth** — change pill styling once and every screen
/// that uses pills updates.
class PillMultiselect<T> extends StatelessWidget {
  const PillMultiselect({
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.labelOf,
    this.iconOf,
    this.spacing = 10,
    this.runSpacing = 10,
    super.key,
  });

  final List<T> options;
  final Set<T> selectedValues;
  final ValueChanged<Set<T>> onChanged;
  final String Function(T)? labelOf;
  final IconData? Function(T)? iconOf;
  final double spacing;
  final double runSpacing;

  String _label(T option) =>
      labelOf?.call(option) ?? option.toString();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: options.map((option) {
        final selected = selectedValues.contains(option);
        return _Pill(
          label: _label(option),
          icon: iconOf?.call(option),
          selected: selected,
          onTap: () {
            final next = Set<T>.from(selectedValues);
            if (selected) {
              next.remove(option);
            } else {
              next.add(option);
            }
            onChanged(next);
          },
        );
      }).toList(),
    );
  }
}

/// Single-select variant — selecting one deselects the others.
class PillSingleSelect<T> extends StatelessWidget {
  const PillSingleSelect({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.labelOf,
    this.iconOf,
    super.key,
  });

  final List<T> options;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String Function(T)? labelOf;
  final IconData? Function(T)? iconOf;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final selected = selectedValue == option;
        return _Pill(
          label: labelOf?.call(option) ?? option.toString(),
          icon: iconOf?.call(option),
          selected: selected,
          onTap: () => onChanged(selected ? null : option),
        );
      }).toList(),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? FeloColors.feloiTeal.withValues(alpha: 0.15)
          : colors.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(99),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              width: selected ? 1.5 : 1,
              color: selected
                  ? FeloColors.feloiTeal
                  : colors.outlineVariant.withValues(alpha: 0.4),
            ),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18,
                  color:
                      selected ? FeloColors.feloiTeal : colors.onSurface,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      color: selected
                          ? FeloColors.feloiTeal
                          : colors.onSurface,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
