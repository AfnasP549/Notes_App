import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/view_model/theme_view_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDarkModeToggle;
  final bool centerTitle; 

  const CustomAppBar({
    super.key,
    required this.title,
    this.showDarkModeToggle = false,
    this.centerTitle = false, 
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: centerTitle,  
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
