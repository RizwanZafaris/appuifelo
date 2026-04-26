import 'package:flutter/material.dart';

class FeloInput extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      autofocus: autofocus,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      minLines: 1,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
      ),
    );
  }
}
