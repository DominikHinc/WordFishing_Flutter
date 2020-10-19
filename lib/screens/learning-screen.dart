import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:flutter/material.dart';

class LearningScreen extends StatelessWidget {
  static const routeName = './Learning';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn new Vovabulary!"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Learning screen!"),
      ),
    );
  }
}
