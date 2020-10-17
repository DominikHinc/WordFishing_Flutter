import 'package:WordFishing/providers/theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isSwitched = true;

  // TODO remove placeholder code
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HomeScreen'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                  "Application Current Theme: ${isSwitched ? "Dark" : "Light"}"),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/second');
                },
                child: Text('cum?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
