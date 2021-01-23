import 'package:WordFishing/screens/achievements-screen.dart';
import 'package:WordFishing/screens/auth-screen.dart';
import 'package:WordFishing/screens/book-screen.dart';
import 'package:WordFishing/screens/credits-screen.dart';
// import 'package:WordFishing/screens/custom-list-screen.dart';
// import 'package:WordFishing/screens/debug-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> getDrawerRouteNames() {
  return {
    BookScreen.routeName: (ctx) => BookScreen(),
    SettingsScreen.routeName: (ctx) => SettingsScreen(),
    AchievementsScreen.routeName: (ctx) => AchievementsScreen(),
    CreditsScreen.routeName: (ctx) => CreditsScreen(),
    AuthScreen.routeName: (ctx) => AuthScreen(),
    // CustomListScreen.routeName: (ctx) => CustomListScreen(),
    // DebugScreen.routeName: (ctx) => DebugScreen(),
  };
}
