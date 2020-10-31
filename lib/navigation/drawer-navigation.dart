import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/screens/book-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drawerAnimationProvider =
        Provider.of<DrawerTransformationProvider>(context);
    return AnimatedContainer(
      transform: Matrix4.translationValues(
          drawerAnimationProvider.xOffset, drawerAnimationProvider.yOffset, 0)
        ..scale(drawerAnimationProvider.scaleFactor),
      duration: Duration(milliseconds: 250),
      child: BookScreen(),
    );
  }
}
