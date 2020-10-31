import 'package:WordFishing/screens/test-drawer-screen.dart';
import 'package:WordFishing/navigation/drawer-navigation.dart';
import 'package:flutter/material.dart';

class DrawerNavi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          DrawerNavigator(),
        ],
      ),
    );
  }
}
