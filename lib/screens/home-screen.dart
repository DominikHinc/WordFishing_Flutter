import 'package:WordFishing/providers/theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text("Application Current Theme: ${isSwitched ? "Dark" : "Light"}"),
        Consumer<ApplicationThemeProvider>(
          builder: (_, theme, ___) => Switch(
            onChanged: (value) {
              print(value);
              setState(() {
                isSwitched = value;
              });
              theme.switchTheme(value ? Themes.DARK : Themes.LIGHT);
            },
            value: isSwitched,
          ),
        ),
      ]),
    );
  }
}
