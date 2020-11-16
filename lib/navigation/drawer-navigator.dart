import 'package:WordFishing/screens/drawer-background-screen.dart';
import 'package:WordFishing/screens/drawer-animated-screen.dart';
import 'package:flutter/material.dart';

class DrawerNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerBackgroundScreen(),
          DrawerAnimatedScreen(),
        ],
      ),
    );
  }
}
