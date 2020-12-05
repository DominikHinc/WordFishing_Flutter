import 'package:WordFishing/utils/spacing.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final List<Widget> children;
  final double childAspectRatio;

  CustomGridView({
    this.children,
    this.childAspectRatio = 1,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        childAspectRatio: childAspectRatio,
        primary: false,
        padding: EdgeInsets.all(
          spacing[4],
        ),
        crossAxisSpacing: spacing[3],
        mainAxisSpacing: spacing[3],
        crossAxisCount: 2,
        children: children,
      ),
    );
  }
}
