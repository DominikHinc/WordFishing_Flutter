import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./Auth";
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "auth_screen_label";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "auth_screen_label",
      ),
      body: Center(
        child: Text("Auth Screen"),
      ),
    );
  }
}
