import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/widgets/custom-grid-tile.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        childAspectRatio: 1.2,
        primary: false,
        padding: EdgeInsets.all(
          spacing[4],
        ),
        crossAxisSpacing: spacing[3],
        mainAxisSpacing: spacing[3],
        crossAxisCount: 2,
        children: <Widget>[
          CustomGridTile(),
        ],
      ),
    );
  }
}
