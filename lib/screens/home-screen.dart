import 'package:WordFishing/navigation/routes-config.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/main-drawer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = INITIAL_ROUTE;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('HomeScreen'),
        ),
        body: Center(
          child: Text("Home Screen!"),
        ),
      ),
    );
  }
}
