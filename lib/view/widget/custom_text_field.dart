import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
 // final bool isError;
  final String? errorText;
  final int maxLines;
  final double fontSize;
  final bool isTitleField;
  final bool showBorder;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
   //this.isError = false,
    this.errorText,
    this.maxLines = 1,
    this.fontSize = 16.0,
    this.isTitleField = false,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: fontSize),
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: isTitleField ? FontWeight.bold : FontWeight.normal,
        ),
        border: showBorder ? const OutlineInputBorder() : InputBorder.none,
        enabledBorder: showBorder ? const OutlineInputBorder() : InputBorder.none,
        focusedBorder: showBorder ? const OutlineInputBorder() : InputBorder.none,
       // errorText: isError ? errorText : null,
      ),
    );
  }
}
