import 'package:WordFishing/screens/home-screen.dart';
import 'package:flutter/material.dart';

const INITIAL_ROUTE = '/';

Map<String, Widget Function(BuildContext)> getRouteNames() {
  return {
    INITIAL_ROUTE: (_) => HomeScreen(),
  };
}
