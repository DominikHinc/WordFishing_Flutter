import 'package:WordFishing/utils/normalize.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double maxAmount;
  final double currentProgress;
  ProgressBar({
    this.maxAmount,
    this.currentProgress,
  });
  @override
  Widget build(BuildContext context) {
    final normalizedHeight = normalizeHeight(context, 30);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: normalizedHeight,
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).cardColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
              value: currentProgress / maxAmount,
            ),
          ),
        ),
        Container(
          height: normalizedHeight,
          child: Center(
            child: Text(
              "${currentProgress.toStringAsFixed(0)}/${maxAmount.toStringAsFixed(0)}",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
