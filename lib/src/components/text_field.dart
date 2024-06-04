import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  const FormTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: theme.colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: theme.colorScheme.onSurface),
          ),
          labelStyle: TextStyle(
            color: theme.colorScheme.onSurface,
          ),
          fillColor: theme.colorScheme.surface,
          filled: true,
        ),
      ),
    );
  }
}
