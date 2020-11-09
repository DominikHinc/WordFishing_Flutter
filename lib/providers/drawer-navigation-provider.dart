import 'package:WordFishing/screens/achievements-screen.dart';
import 'package:WordFishing/screens/auth-screen.dart';
import 'package:WordFishing/screens/credits-screen.dart';
import 'package:WordFishing/screens/custom-list-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:flutter/material.dart';
import 'package:WordFishing/screens/book-screen.dart';

class DrawerNavigationProvider extends ChangeNotifier {
  String _currentScreenName;
  String get currentScreenName {
    return _currentScreenName;
  }

  Widget _currentScreen;
  Widget get currentScreen {
    switch (currentScreenName) {
      case 'BookScreen':
        return BookScreen();
        break;
      case 'AuthScreen':
        return AuthScreen();
        break;
      case 'AchievementsScreen':
        return AchievementsScreen();
        break;
      case 'CustomListScreen':
        return CustomListScreen();
        break;
      case 'CreditsScreen':
        return CreditsScreen();
        break;
      case 'SettingsScreen':
        return SettingsScreen();
        break;
      default:
        return BookScreen();
    }
  }

  void getScreenName(String currentScreenName) {
    _currentScreenName = currentScreenName;
    notifyListeners();
  }

  Widget changeScreenToggle() {
    _currentScreen = currentScreen;
    return _currentScreen;
  }
}
