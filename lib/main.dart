import 'package:WordFishing/screens/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ApplicationThemeProvider(),
        ),
      ],
      child: Consumer<ApplicationThemeProvider>(
        builder: (_, theme, __) => MaterialApp(
          title: 'WordFishing',
          theme: theme.currentTheme,
          home: Scaffold(
            appBar: AppBar(
              title: Text("WordFishing!"),
            ),
            body: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
