import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/view/utils/app_color.dart';
import 'package:secure_notes_app/view_model/theme_view_model.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double padding;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12.0,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, child) {
        final isDarkMode = themeViewModel.isDarkMode;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode ? AppColor.btnDark : AppColor.btnLight,
            foregroundColor: isDarkMode ? AppColor.textDark :  AppColor.textLight,
            padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        );
      },
    );
  }
}
