import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final bool isMultiline;
  final int maxLines;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final bool autofocus;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.isMultiline = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.onEditingComplete,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: isMultiline,
      ),
      validator: validator,
      maxLines: isMultiline ? maxLines : 1,
      textInputAction: textInputAction,
      keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      autofocus: autofocus,
    );
  }
}
