import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = "./Auth";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up!"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Auth Screen"),
      ),
    );
  }
}
