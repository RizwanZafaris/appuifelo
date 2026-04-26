import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Universal money input — currency prefix + minor-unit semantics.
///
/// Used by: Phase 5.1 budget total + each category amount, Phase 5.2
/// goal target amount.
///
/// Parses user-typed major units into minor (cents/paisa). Reports via
/// `onChanged` as int minor units. Display formatting handled in-widget.
///
/// **Audit §8** — when `allowShorthand: true`, the input also accepts
/// "k" / "l" / "lac" / "cr" / "m" suffixes and emits the raw text via
/// `onRawChanged`. Caller runs `Validators.budgetAmount(raw)` to
/// normalize / catch unrealistic values.
class MoneyInput extends StatefulWidget {
  const MoneyInput({
    required this.label,
    required this.currency,
    required this.onChanged,
    this.initialMinor,
    this.helper,
    this.dense = false,
    this.error,
    this.allowShorthand = false,
    this.onRawChanged,
    super.key,
  });

  final String label;
  final String currency;
  final int? initialMinor;
  final ValueChanged<int> onChanged;
  final String? helper;
  final bool dense;
  final String? error;
  final bool allowShorthand;

  /// Emits the raw text (with shorthand suffix preserved) every keystroke.
  /// Only meaningful when `allowShorthand: true`.
  final ValueChanged<String>? onRawChanged;

  @override
  State<MoneyInput> createState() => _MoneyInputState();
}

class _MoneyInputState extends State<MoneyInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialMinor == null
          ? ''
          : (widget.initialMinor! / 100).toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String raw) {
    widget.onRawChanged?.call(raw);
    // Strip shorthand letters to compute the minor-unit "best guess".
    // The caller still has the raw string for full Validators pass.
    final clean = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    final parts = clean.split('.');
    final dollars = int.tryParse(parts.first.isEmpty ? '0' : parts.first) ?? 0;
    final cents = parts.length > 1
        ? int.tryParse(parts[1].padRight(2, '0').substring(0, 2)) ?? 0
        : 0;
    widget.onChanged(dollars * 100 + cents);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: widget.allowShorthand
          ? TextInputType.text
          : const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          widget.allowShorthand
              ? RegExp(r'[0-9.,kKlLmMcCrR ]')
              : RegExp(r'[0-9.,]'),
        ),
      ],
      decoration: InputDecoration(
        labelText: widget.label,
        prefixText: '${widget.currency} ',
        helperText: widget.helper,
        errorText: widget.error,
        isDense: widget.dense,
        contentPadding: widget.dense
            ? const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
            : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: _onChanged,
    );
  }
}
