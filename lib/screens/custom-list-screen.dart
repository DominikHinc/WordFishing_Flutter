import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:flutter/material.dart';

class CustomListScreen extends StatelessWidget {
  static const routeName = "./CustomList";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create your own list!"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Custom List Screen"),
      ),
    );
  }
}
