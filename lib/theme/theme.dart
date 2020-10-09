import 'package:flutter/material.dart';

enum Themes { LIGHT, DARK }

class ApplicationThemes {
  static var _themes = {
    Themes.LIGHT: ThemeData(
      primaryColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    Themes.DARK: ThemeData(
      primaryColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  };

  static ThemeData getTheme(Themes themeType) {
    return _themes[themeType];
  }
}
