import 'package:flutter/material.dart';
import 'package:WordFishing/screens/home-screen.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:provider/provider.dart';

class RoutesConfig extends StatelessWidget {
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
          initialRoute: '/',
          routes: {
            '/': (_) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
