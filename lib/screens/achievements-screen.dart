import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  static const routeName = "./Achievements";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Achievements!"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Achievements Screen"),
      ),
    );
  }
}
