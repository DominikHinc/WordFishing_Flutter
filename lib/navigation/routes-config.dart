import 'package:WordFishing/screens/home-screen.dart';
import 'package:WordFishing/screens/placeholder.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> getRouteNames() {
  return {
    '/': (_) => HomeScreen(),
    PlaceholderScreen.routeName: (_) => PlaceholderScreen(),
  };
}
