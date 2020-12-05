import 'package:WordFishing/utils/normalize.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  static const double PROGRESS_BAR_HEIGHT = 30;
  final double maxAmount;
  final double currentProgress;
  ProgressBar({
    @required this.maxAmount,
    @required this.currentProgress,
  });
  //This value is later normalized in the widget

  @override
  Widget build(BuildContext context) {
    final normalizedHeight = normalizeHeight(context, PROGRESS_BAR_HEIGHT);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(normalizedHeight / 2),
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
