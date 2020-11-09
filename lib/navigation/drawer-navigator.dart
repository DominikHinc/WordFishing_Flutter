import 'package:WordFishing/screens/drawer-screen.dart';
import 'package:WordFishing/widgets/drawer-animator.dart';
import 'package:flutter/material.dart';

class DrawerNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          DrawerAnimator(),
        ],
      ),
    );
  }
}
