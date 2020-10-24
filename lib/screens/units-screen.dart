import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:flutter/material.dart';

class UnitsScreen extends StatelessWidget {
  static const routeName = './Units';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose unit"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Choose unit"),
      ),
    );
  }
}
