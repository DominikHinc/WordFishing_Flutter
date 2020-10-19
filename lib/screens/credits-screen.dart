import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  static const routeName = './Credits';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credits"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Application made by Adam Tymosz and Dominik Hinc"),
      ),
    );
  }
}
