import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/providers/drawer-navigation-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerAnimator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drawerAnimationProvider =
        Provider.of<DrawerAnimationProvider>(context);
    final drawerCurrentScreen = Provider.of<DrawerNavigationProvider>(context);

    return AnimatedContainer(
      transform: Matrix4.translationValues(
          drawerAnimationProvider.xOffset, drawerAnimationProvider.yOffset, 0)
        ..scale(drawerAnimationProvider.scaleFactor),
      duration: Duration(milliseconds: 250),
      child: drawerCurrentScreen.changeScreenToggle(),
    );
  }
}
