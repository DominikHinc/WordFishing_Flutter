import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/providers/achievement-provider.dart';
import 'package:WordFishing/widgets/achievement-screen-tile.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementsScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./Achievements";
  @override
  final routeNameLocal = AchievementsScreen.routeName;
  @override
  final drawerButtonTranslationKey = "achievements_screen_label";
  @override
  @override
  Widget build(BuildContext context) {
    bool isAchievementSelected = false;
    final achievementProvider = Provider.of<AchievementProvider>(context);
    return GestureDetector(
      onTap: () {
        achievementProvider.getIsAchievementSelected(isAchievementSelected);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          "achievements_screen_label",
        ),
        body: AchievementScreenTile(),
      ),
    );
  }
}
