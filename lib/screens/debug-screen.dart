import 'dart:async';

import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/services/analytics/analytics-events.dart';
import 'package:WordFishing/services/performance/prerformance-events.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// THIS SCREEN IS USED FOR DEBUG PURPOUSES
class DebugScreen extends StatefulWidget with DrawerScreenProperties {
  static const routeName = "./DebugScreen";
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "debug_screen_label";
  @override
  _DebugScreenState createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  var isSwitched = false;
  var firebaseText = '';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('test').get().then((value) {
      setState(() {
        firebaseText = value.docs.first.data()['test'];
      });
    });
    return Center(
      child: Scaffold(
        appBar: CustomAppBar(
          "debug_screen_label",
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
                    theme.switchTheme(value ? Themes.DARK : Themes.LIGHT);
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
              FlatButton(
                child: Text("Crash!"),
                onPressed: () => FirebaseCrashlytics.instance.crash(),
              ),
              FlatButton(
                child: Text("Send performance event!"),
                onPressed: () {
                  final performanceEvent = measureVocabularyLoadTime();
                  Timer(Duration(seconds: 5), () {
                    print("Stopped measuring time");
                    performanceEvent.stop();
                  });
                },
              ),
              FlatButton(
                child: Text("Send analytics event!"),
                onPressed: () {
                  print("Event will be sent");
                  sendTestEvent();
                },
              ),
              Text("Firebase Text: $firebaseText"),
            ],
          ),
        ),
      ),
    );
  }
}
