import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// 6-digit OTP input with auto-advance per digit and auto-submit when
/// all 6 are filled (FR-1.3.1).
///
/// Why not a single field? Per-digit fields:
/// - Make the 6-digit length visually obvious
/// - Allow per-digit error highlighting (when D-011 max attempts hit)
/// - Match the dominant pattern across PK/IN/AE banking apps
class OtpInput extends StatefulWidget {
  const OtpInput({
    required this.onCompleted,
    this.error = false,
    this.autoFocus = true,
    super.key,
  });

  /// Fired when all 6 digits are filled. The screen handler should
  /// call its mixin's `onContinue({...})` and then verify against the
  /// backend.
  final ValueChanged<String> onCompleted;

  /// Highlights all six fields red. Set to true on verification failure;
  /// reset to false when user starts editing again.
  final bool error;

  final bool autoFocus;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  static const _digitCount = 6;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_digitCount, (_) => TextEditingController());
    _focusNodes = List.generate(_digitCount, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    // Auto-advance on input
    if (value.isNotEmpty && index < _digitCount - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    // Auto-submit when all 6 are filled
    final code = _controllers.map((c) => c.text).join();
    if (code.length == _digitCount) {
      widget.onCompleted(code);
    }
  }

  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  void clear() {
    for (final c in _controllers) {
      c.clear();
    }
    if (_focusNodes.first.canRequestFocus) {
      _focusNodes.first.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_digitCount, (index) {
        return SizedBox(
          width: 44,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (KeyEvent event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                _onBackspace(index);
              }
            },
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              autofocus: widget.autoFocus && index == 0,
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                filled: true,
                fillColor: colors.surfaceContainerHighest.withValues(
                  alpha: 0.6,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: widget.error
                        ? Colors.red.shade400
                        : colors.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: widget.error
                        ? Colors.red.shade400
                        : FeloColors.feloiTeal,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) => _onDigitChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}
