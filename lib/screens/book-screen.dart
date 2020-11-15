import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatefulWidget with DrawerScreenProperties {
  static const routeName = './Books';
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "book_screen_label";
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  var isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: CustomAppBar(
          "book_screen_label",
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                  "Application Current Theme: ${isSwitched ? "Dark" : "Light"}"),
              Consumer<ApplicationThemeProvider>(
                builder: (_, theme, ___) => Switch(
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                    theme.switchTheme(
                        value ? Themes.DARK : Themes.LIGHT, context);
                  },
                  value: isSwitched,
                ),
              ),
              Text(
                // NEW WAY OF TRANSLATING TEXT
                translate(context, 'example_message'),
                // THIS SHOULD BE THE DEFAULT WAY OF STYLING TEXT
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
