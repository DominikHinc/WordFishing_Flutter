import 'package:WordFishing/navigation/drawer-navigator.dart';
import 'package:WordFishing/screens/learning-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:WordFishing/screens/units-screen.dart';
import 'package:flutter/material.dart';

const INITIAL_ROUTE = './';

Map<String, Widget Function(BuildContext)> getRouteNames() {
  return {
    INITIAL_ROUTE: (_) => DrawerNavigator(),
    UnitsScreen.routeName: (ctx) => UnitsScreen(),
    LearningScreen.routeName: (ctx) => LearningScreen(),
    SettingsScreen.routeName: (ctx) => SettingsScreen(),
  };
}
