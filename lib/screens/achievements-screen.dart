import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./Achievements";
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "achievements_screen_label";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "achievements_screen_label",
      ),
      body: Center(
        child: Text("Achievements Screen"),
      ),
    );
  }
}
