import 'package:WordFishing/theme/themes.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

enum Themes { LIGHT, DARK }

class ApplicationThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme;
  Themes _currentThemeType;

  ApplicationThemeProvider({Themes themeType}) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
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
        return getDarkTheme();
        break;
    }
  }

  void switchTheme(Themes themeType) {
    _currentTheme = _getThemeData(themeType);
    _currentThemeType = themeType;
    notifyListeners();
  }

  Themes get currentThemeType {
    return _currentThemeType;
  }

  ThemeData get currentTheme {
    return _currentTheme;
  }

  String getCurrentThemeTranslation(BuildContext context) {
    return currentThemeType == Themes.LIGHT
        ? translate(context, "light_theme_name")
        : translate(context, "dark_theme_name");
  }
}
