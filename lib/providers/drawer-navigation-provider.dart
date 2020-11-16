import 'package:WordFishing/navigation/drawer-routes-config.dart';
import 'package:flutter/material.dart';

class DrawerNavigationProvider extends ChangeNotifier {
  Widget _currentScreen;
  DrawerNavigationProvider(BuildContext context) {
    _currentScreen = getDrawerRouteNames().entries.first.value(context);
  }

  Widget get currentScreen {
    return _currentScreen;
  }

  void setScreenRouteName(BuildContext context, String routeName) {
    _currentScreen = getDrawerRouteNames()[routeName](context);
    notifyListeners();
  }
}
