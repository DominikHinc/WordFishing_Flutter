import 'package:WordFishing/providers/theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appThemeProvider = Provider.of<ApplicationThemeProvider>(context);
    return Row(
      children: [
        Switch(
          onChanged: (value) {
            appThemeProvider.switchTheme(value ? Themes.LIGHT : Themes.DARK);
          },
          value: appThemeProvider.currentThemeType == Themes.LIGHT,
        ),
        Text(
          'Mode: ${appThemeProvider.getCurrentThemeTranslation(context)}',
          style: TextStyle(color: Theme.of(context).textTheme.subtitle2.color),
        )
      ],
    );
  }
}
