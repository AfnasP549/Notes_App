import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final int maxLines;
  final double fontSize;
  final bool isTitleField;
  final bool showBorder;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool autofocus;  

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.maxLines = 1,
    this.fontSize = 16.0,
    this.isTitleField = false,
    this.showBorder = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.autofocus = false, 
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.2,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    return TextField(
      controller: controller,
      style: TextStyle(fontSize: fontSize),
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      autofocus: autofocus,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: isTitleField ? FontWeight.bold : FontWeight.normal,
        ),
        border: showBorder ? border : InputBorder.none,
        enabledBorder: showBorder ? border : InputBorder.none,
        focusedBorder: showBorder
            ? border.copyWith(
                borderSide: const BorderSide(color: Colors.teal, width: 1.5),
              )
            : InputBorder.none,
        errorText: errorText,
        counterText: '',
      ),
    );
  }
}
