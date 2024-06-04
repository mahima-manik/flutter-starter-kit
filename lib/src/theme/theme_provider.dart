import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode; // setting light mode initially

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    notifyListeners();
  }
}
