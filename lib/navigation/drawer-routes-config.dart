import 'package:WordFishing/screens/achievements-screen.dart';
import 'package:WordFishing/screens/auth-screen.dart';
import 'package:WordFishing/screens/book-screen.dart';
import 'package:WordFishing/screens/credits-screen.dart';
import 'package:WordFishing/screens/custom-list-screen.dart';
import 'package:WordFishing/screens/debug-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> getDrawerRouteNames() {
  return {
    AchievementsScreen.routeName: (ctx) => AchievementsScreen(),
    BookScreen.routeName: (ctx) => BookScreen(),
    AuthScreen.routeName: (ctx) => AuthScreen(),
    CreditsScreen.routeName: (ctx) => CreditsScreen(),
    CustomListScreen.routeName: (ctx) => CustomListScreen(),
    SettingsScreen.routeName: (ctx) => SettingsScreen(),
    DebugScreen.routeName: (ctx) => DebugScreen(),
  };
}
