import 'dart:async';

import 'package:WordFishing/utils/spacing.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatefulWidget {
  @override
  _EmptyScreenState createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  Timer _timer;
  Widget _emptyScreenChild = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
      SizedBox(
        height: spacing[3],
      ),
      Text(
        "Loading...",
      ),
    ],
  );
  _EmptyScreenState() {
    _timer = new Timer(const Duration(seconds: 15), () {
      setState(() {
        _emptyScreenChild = Text(
          "Service currently unavailable",
          style: Theme.of(context).textTheme.headline6,
        );
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Widget build(BuildContext context) {
    return Center(
      child: _emptyScreenChild,
    );
  }
}
