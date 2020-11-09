import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  static const routeName = './Credits';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(normalizeHeight(context, 55)),
        child: CustomAppbar(
          label: "credits_screen_label",
        ),
      ),
      body: Center(
        child: Text("Application made by Adam Tymosz and Dominik Hinc"),
      ),
    );
  }
}
