import 'package:WordFishing/theme/palette.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return new ThemeData(
    primaryColor: Palette.primary,
    accentColor: Palette.accents,
    scaffoldBackgroundColor: Palette.background,
    shadowColor: Palette.secondary,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Palette.secondary,
      ),
      bodyText1: TextStyle(
        color: Palette.secondary,
      ),
      bodyText2: TextStyle(
        color: Palette.secondary,
      ),
      subtitle2: TextStyle(
        color: Palette.white,
      ),
    ),
    buttonColor: Palette.white,
    canvasColor: Palette.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData getDarkTheme() {
  return new ThemeData(
    primaryColor: Palette.secondary,
    accentColor: Palette.primary,
    scaffoldBackgroundColor: Palette.backgroundSecondary,
    shadowColor: Palette.secondary,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Palette.white,
      ),
      bodyText1: TextStyle(
        color: Palette.white,
      ),
      bodyText2: TextStyle(
        color: Palette.white,
      ),
      subtitle2: TextStyle(
        color: Palette.white,
      ),
    ),
    buttonColor: Palette.white,
    canvasColor: Palette.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
