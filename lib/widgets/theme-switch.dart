import 'package:WordFishing/providers/theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  var isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<ApplicationThemeProvider>(
          builder: (_, theme, ___) => Switch(
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
              theme.switchTheme(value ? Themes.DARK : Themes.LIGHT);
            },
            value: isSwitched,
          ),
        ),
        Text(
          'Mode: ${isSwitched ? "Dark" : "Light"}',
          style: TextStyle(color: Theme.of(context).textTheme.subtitle2.color),
        )
      ],
    );
  }
}
