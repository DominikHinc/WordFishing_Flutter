import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:flutter/material.dart';

class DrawerButtonAnimator extends StatelessWidget {
  final double scaleFactor;
  final Widget child;
  DrawerButtonAnimator({
    @required this.scaleFactor,
    @required this.child,
  });
  @override
  Widget build(BuildContext context) {
    final drawerAnimationDuration = Duration(milliseconds: 150);
    return AnimatedContainer(
      duration: drawerAnimationDuration,
      transform: Matrix4.translationValues(0, 0, 0)..scale(scaleFactor),
      margin: EdgeInsets.only(
          bottom: normalizePadding(context, spacing[5]) * scaleFactor),
      child: child,
    );
  }
}
