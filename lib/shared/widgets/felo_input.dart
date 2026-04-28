import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class FeloInput extends StatefulWidget {
  const FeloInput({
    required this.label,
    super.key,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled,
    this.textCapitalization = TextCapitalization.none,
    this.errorText,
    this.autofocus = false,
    this.onChanged,
    this.required = false,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool? enabled;
  final TextCapitalization textCapitalization;
  final String? errorText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  /// When true, the field is announced as required to assistive tech and
  /// shows a visual `*` after the label.
  final bool required;

  @override
  State<FeloInput> createState() => _FeloInputState();
}

class _FeloInputState extends State<FeloInput> {
  String? _previousError;

  @override
  void didUpdateWidget(covariant FeloInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final next = widget.errorText;
    if (next != null && next.isNotEmpty && next != _previousError) {
      // Announce the new error to assistive tech eagerly. Flutter's
      // default `TextField` exposes `errorText` semantically but doesn't
      // re-announce on change — so screen readers can miss validation
      // errors that appear after submit.
      SemanticsService.announce(
        '${widget.label}: $next',
        Directionality.of(context),
      );
    }
    _previousError = next;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final labelWithRequired =
        widget.required ? '${widget.label} *' : widget.label;
    final semanticHint = <String>[
      if (widget.required) 'required',
      if (widget.hint != null && widget.hint!.isNotEmpty) widget.hint!,
      if (hasError) 'error: ${widget.errorText}',
    ].join(', ');

    return Semantics(
      textField: true,
      label: widget.label,
      hint: semanticHint.isEmpty ? null : semanticHint,
      // Mark the field as a live region while in error so screen readers
      // re-announce on subsequent error changes.
      liveRegion: hasError,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        textCapitalization: widget.textCapitalization,
        minLines: 1,
        decoration: InputDecoration(
          labelText: labelWithRequired,
          hintText: widget.hint,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
