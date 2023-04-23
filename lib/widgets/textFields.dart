import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final TextInputType? keyBoardType;
  final String? Function(String?) validator;
  final int? maxLength;
  final bool? interactiveSelection;
  final int? maxLines;
  final TextEditingController controller;
  const CustomTextFields({
    Key? key,
    required this.hintText,
    this.icon,
    this.keyBoardType,
    required this.validator,
    this.maxLength,
    this.interactiveSelection,
    this.maxLines,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        counterText: "",

      ),
      enableInteractiveSelection: interactiveSelection,
      maxLength: maxLength,
      keyboardType: keyBoardType ?? TextInputType.text,
      maxLines: maxLines,
    );
  }
}
