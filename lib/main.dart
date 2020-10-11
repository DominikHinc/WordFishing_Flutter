import 'package:flutter/material.dart';
import 'package:WordFishing/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordFishing!',
      theme: ApplicationThemes.getTheme(Themes.LIGHT),
      home: Scaffold(
        appBar: AppBar(
          title: Text("WordFishing!"),
        ),
      ),
    );
  }
}
