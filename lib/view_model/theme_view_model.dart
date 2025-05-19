import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeViewModel extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get theme => _isDarkMode ? _darkTheme : _lightTheme;

  final _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity
  );

  final _darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity
  );


  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}