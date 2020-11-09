import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class CustomListScreen extends StatelessWidget {
  static const routeName = "./CustomList";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(normalizeHeight(context, 55)),
        child: CustomAppbar(
          label: "custom_list_screen_label",
        ),
      ),
      body: Center(
        child: Text("Custom List Screen"),
      ),
    );
  }
}
