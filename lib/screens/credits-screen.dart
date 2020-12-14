import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = './Credits';
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "credits_screen_label";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "credits_screen_label",
      ),
      body: Center(
        child: Text(
          "Application made by: \n\n Dominik Hinc \n\n Adam Tymosz \n\n Special thanks for providing \n us with vocabulary to: \n\n Marcin Hesse",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
