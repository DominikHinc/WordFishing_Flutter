import 'package:WordFishing/theme/themes.dart';
import 'package:flutter/material.dart';

enum Themes { LIGHT, DARK }

class ApplicationThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme;

  ApplicationThemeProvider({Themes themeType}) {
    switchTheme(themeType);
  }

  ThemeData _getThemeData(Themes themeType) {
    switch (themeType) {
      case Themes.LIGHT:
        return getLightTheme();
        break;
      case Themes.DARK:
        return getDarkTheme();
        break;
      default:
        return getLightTheme();
        break;
    }
  }

  void switchTheme(Themes themeType) {
    _currentTheme = _getThemeData(themeType);
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _currentTheme;
  }
}
