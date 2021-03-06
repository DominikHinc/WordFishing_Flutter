import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class CustomListScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./CustomList";
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "custom_list_screen_label";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "custom_list_screen_label",
      ),
      body: Center(
        child: Text("Custom List Screen"),
      ),
    );
  }
}
