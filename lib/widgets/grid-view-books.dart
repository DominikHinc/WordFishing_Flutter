import 'package:WordFishing/widgets/grid-tile-books.dart';
import 'package:flutter/material.dart';

class GridViewBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        childAspectRatio: 1.2,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          GridTileBooks(),
        ],
      ),
    );
  }
}
