import 'dart:async';

import 'package:WordFishing/navigation/routes-config.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/services/analytics/analytics-events.dart';
import 'package:WordFishing/services/performance/prerformance-events.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// THIS SCREEN IS USED FOR DEBUG PURPOUSES
class DebugScreen extends StatefulWidget {
  static const routeName = INITIAL_ROUTE;
  @override
  _DebugScreenState createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  var isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('DEBUG SCREEN'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
