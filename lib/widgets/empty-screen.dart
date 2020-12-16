import 'dart:async';

import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatefulWidget {
  @override
  _EmptyScreenState createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  Timer _timer;
  bool _timerPassed = false;

  _EmptyScreenState() {
    _timer = new Timer(const Duration(seconds: 15), () {
      setState(() {
        _timerPassed = !_timerPassed;
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
      child: _timerPassed
          ? Text(
              translate(context, "service_currently_unavailable"),
              style: Theme.of(context).textTheme.headline6,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: spacing[3],
                ),
                Text(
                  translate(context, "loading"),
                ),
              ],
            ),
    );
  }
}
