// lib/view/widget/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/view_model/theme_view_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDarkModeToggle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showDarkModeToggle = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: showDarkModeToggle
          ? [
              Consumer<ThemeViewModel>(
                builder: (context, themeViewModel, _) {
                  return IconButton(
                    icon: Icon(
                      themeViewModel.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                    onPressed: () => themeViewModel.toggleTheme(),
                  );
                },
              ),
            ]
          : null,
    );
  }
}
