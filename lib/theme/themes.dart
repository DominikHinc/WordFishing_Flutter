import 'package:WordFishing/theme/palette.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return new ThemeData(
    primaryColor: Palette.primary,
    accentColor: Palette.accents,
    scaffoldBackgroundColor: Palette.background,
    backgroundColor: Palette.background,
    shadowColor: Palette.secondary,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Palette.white,
      ),
      bodyText1: TextStyle(
        color: Palette.secondary,
      ),
      bodyText2: TextStyle(
        color: Palette.secondary,
      ),
      subtitle1: TextStyle(
        color: Palette.secondary,
      ),
      subtitle2: TextStyle(
        color: Palette.white,
      ),
      headline3: TextStyle(
        color: Palette.secondary,
      ),
      headline4: TextStyle(
        fontSize: 28,
        color: Palette.neutralDark,
      ),
      headline5: TextStyle(
        fontSize: 18,
        color: Palette.neutralDark,
      ),
    ),
    buttonColor: Palette.white,
    cardColor: Palette.neutral,
    hintColor: Palette.secondary,
    //THIS IS ONLY USED FOR THE LOGO
    canvasColor: Palette.white,
    //THIS IS USED FOR THE SNACKBAR
    indicatorColor: Palette.lightgreen,
    errorColor: Palette.lightred,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData getDarkTheme() {
  return new ThemeData(
    primaryColor: Palette.secondary,
    accentColor: Palette.primary,
    scaffoldBackgroundColor: Palette.backgroundSecondary,
    backgroundColor: Palette.backgroundSecondary,
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
      subtitle1: TextStyle(
        color: Palette.white,
      ),
      subtitle2: TextStyle(
        color: Palette.white,
      ),
      headline3: TextStyle(
        color: Palette.white,
      ),
      headline4: TextStyle(
        fontSize: 28,
        color: Palette.white,
      ),
      headline5: TextStyle(
        fontSize: 18,
        color: Palette.white,
      ),
    ),
    buttonColor: Palette.white,
    cardColor: Palette.secondary,
    hintColor: Palette.neutral,
    //THIS IS ONLY USED FOR THE LOGO
    canvasColor: Palette.white,
    //THIS IS USED FOR THE SNACKBAR
    indicatorColor: Palette.darkgreen,
    errorColor: Palette.primary,
    sliderTheme: SliderThemeData(thumbShape: RoundSliderThumbShape()),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
