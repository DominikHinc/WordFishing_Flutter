import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  static const routeName = "./Achievements";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(normalizeHeight(context, 55)),
        child: CustomAppbar(
          label: "achievements_screen_label",
        ),
      ),
      body: Center(
        child: Text("Achievements Screen"),
      ),
    );
  }
}
