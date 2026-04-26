import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// Universal budget-category row — icon + label + amount input.
/// Used by Phase 5.1 budget editor.
///
/// Visual semantic flag: `inflow` rows show a small green "+" marker.
/// Driven by D-020's `budget_categories.semantic`.
class CategoryRow extends StatelessWidget {
  const CategoryRow({
    required this.icon,
    required this.label,
    required this.amountController,
    required this.currency,
    required this.onChanged,
    this.semantic = 'outflow',
    super.key,
  });

  final IconData icon;
  final String label;
  final TextEditingController amountController;
  final String currency;
  final ValueChanged<int> onChanged;
  final String semantic;

  @override
  Widget build(BuildContext context) {
    final isInflow = semantic == 'inflow';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isInflow
                  ? Colors.green.shade100
                  : FeloColors.mintBase.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isInflow ? Colors.green.shade800 : FeloColors.feloiTeal,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        label,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (isInflow) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 110,
            child: TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.right,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              decoration: InputDecoration(
                prefixText: currency,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: InputBorder.none,
              ),
              onChanged: (raw) {
                final clean = raw.replaceAll(RegExp(r'[^0-9.]'), '');
                final parts = clean.split('.');
                final dollars =
                    int.tryParse(parts.first.isEmpty ? '0' : parts.first) ?? 0;
                final cents = parts.length > 1
                    ? int.tryParse(parts[1].padRight(2, '0').substring(0, 2)) ??
                          0
                    : 0;
                onChanged(dollars * 100 + cents);
              },
            ),
          ),
        ],
      ),
    );
  }
}
