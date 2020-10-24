import 'package:WordFishing/navigation/routes-config.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/services/app-localizations.dart';
import 'package:flutter/material.dart';
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
          supportedLocales: getSupportedLocales(),
          localizationsDelegates: getLocalizationsDelegates(),
          localeResolutionCallback: (locale, supportedLocales) =>
              getLocaleResolutionCallback(locale, supportedLocales),
          initialRoute: INITIAL_ROUTE,
          routes: getRouteNames(),
        ),
      ),
    );
  }
}
