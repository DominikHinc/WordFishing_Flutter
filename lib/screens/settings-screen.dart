import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./Settings";
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "settings_screen_label";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "settings_screen_label",
      ),
      body: Center(
        child: Text("Settings"),
      ),
    );
  }
}
