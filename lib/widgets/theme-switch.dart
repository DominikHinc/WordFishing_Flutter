import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String darkThemeTranslate = translate(context, "dark_theme_name");
    String lightThemeTranslate = translate(context, "light_theme_name");
    var appThemeProvider = Provider.of<ApplicationThemeProvider>(context);
    return Row(
      children: [
        Switch(
          onChanged: (value) {
            appThemeProvider.switchTheme(value ? Themes.DARK : Themes.LIGHT);
          },
          value: appThemeProvider.currentThemeType == Themes.DARK,
        ),
        Text(
          'Mode: ${appThemeProvider.currentThemeType == Themes.DARK ? darkThemeTranslate : lightThemeTranslate}',
          style: TextStyle(color: Theme.of(context).textTheme.subtitle2.color),
        )
      ],
    );
  }
}
