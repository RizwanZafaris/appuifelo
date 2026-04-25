import 'package:flutter/material.dart';

class FeloInput extends StatelessWidget {
  const FeloInput({
    required this.label,
    super.key,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      minLines: 1,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
