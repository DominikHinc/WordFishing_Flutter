import 'dart:io';

import 'package:WordFishing/navigation/routes-config.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/services/app-localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FirebaseAnalytics analytics;
FirebasePerformance performance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  analytics = FirebaseAnalytics();
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      // In order to see the error on the fire base you should: throw FlutterError('Error Message');
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
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
