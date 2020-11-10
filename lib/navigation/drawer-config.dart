import 'package:WordFishing/screens/achievements-screen.dart';
import 'package:WordFishing/screens/auth-screen.dart';
import 'package:WordFishing/screens/credits-screen.dart';
import 'package:WordFishing/screens/custom-list-screen.dart';
import 'package:WordFishing/screens/debug-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:WordFishing/screens/book-screen.dart';

class DrawerConfig {
  String label;
  Widget screen;
  DrawerConfig({
    @required this.label,
    @required this.screen,
  });
}

List<DrawerConfig> getDrawerButtonConfigs(BuildContext context) {
  return [
    new DrawerConfig(
      label: translate(
        context,
        'book_screen_label',
      ),
      screen: BookScreen(),
    ),
    new DrawerConfig(
      label: translate(
        context,
        'auth_screen_label',
      ),
      screen: AuthScreen(),
    ),
    new DrawerConfig(
      label: translate(
        context,
        'achievements_screen_label',
      ),
      screen: AchievementsScreen(),
    ),
    new DrawerConfig(
      label: translate(
        context,
        'custom_list_screen_label',
      ),
      screen: CustomListScreen(),
    ),
    new DrawerConfig(
      label: translate(
        context,
        'credits_screen_label',
      ),
      screen: CreditsScreen(),
    ),
    new DrawerConfig(
      label: translate(
        context,
        'settings_screen_label',
      ),
      screen: SettingsScreen(),
    ),
    new DrawerConfig(
      label: translate(
        context,
        'debug_screen_label',
      ),
      screen: DebugScreen(),
    ),
  ];
}
