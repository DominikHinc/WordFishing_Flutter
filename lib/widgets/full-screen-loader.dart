import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FullScreenLoader extends StatelessWidget {
  static const _indicatorSize = 25.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      // decoration: BoxDecoration(color: Colors.black),
      child: CircularProgressIndicator(),
    );
  }
}
