import 'dart:io';

import 'package:WordFishing/navigation/routes-config.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/providers/drawer-navigation-provider.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/services/app-localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      // In order to see the error on the fire base you should: throw FlutterError('Error Message');
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      // Pass all uncaught errors to Crashlytics.
      Function originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails errorDetails) async {
        await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
        // Forward to original handler.
        originalOnError(errorDetails);
      };
    }
  } catch (e) {}

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
        ChangeNotifierProvider.value(
          value: DrawerAnimationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DrawerNavigationProvider(context),
        ),
        ChangeNotifierProvider.value(
          value: BooksProvider(),
        ),
      ],
      child: Consumer<ApplicationThemeProvider>(
        builder: (_, theme, __) => MaterialApp(
          title: 'WordFishing',
          theme: theme.currentTheme,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
          ],
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
