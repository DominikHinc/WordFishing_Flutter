import 'package:WordFishing/navigation/drawer-navigator.dart';
import 'package:WordFishing/screens/achievements-screen.dart';
import 'package:WordFishing/screens/auth-screen.dart';
import 'package:WordFishing/screens/credits-screen.dart';
import 'package:WordFishing/screens/custom-list-screen.dart';
import 'package:WordFishing/screens/debug-screen.dart';
import 'package:WordFishing/screens/home-screen.dart';
import 'package:WordFishing/screens/learning-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:WordFishing/screens/units-screen.dart';
import 'package:flutter/material.dart';

const INITIAL_ROUTE = './';

Map<String, Widget Function(BuildContext)> getRouteNames() {
  return {
    INITIAL_ROUTE: (_) => DebugScreen(),
    AuthScreen.routeName: (ctx) => AuthScreen(),
    UnitsScreen.routeName: (ctx) => UnitsScreen(),
    SettingsScreen.routeName: (ctx) => SettingsScreen(),
    LearningScreen.routeName: (ctx) => LearningScreen(),
    CreditsScreen.routeName: (ctx) => CreditsScreen(),
    CustomListScreen.routeName: (ctx) => CustomListScreen(),
    AchievementsScreen.routeName: (ctx) => AchievementsScreen(),
  };
}
