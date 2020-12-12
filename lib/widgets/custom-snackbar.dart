import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/sticky-text-input.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomSnackbar extends StatelessWidget {
  final double height;
  final double size;
  final bool isCorrect;
  final bool isDisplayed;
  final Function onPressed;
  final Duration duration;
  final int margin;
  final Color color;
  final String wrongMessageBottom;
  CustomSnackbar({
    this.height = 100,
    this.size = 30,
    this.wrongMessageBottom,
    @required this.isCorrect,
    @required this.isDisplayed,
    @required this.onPressed,
    this.duration = const Duration(milliseconds: 250),
    this.margin = StickyTextInput.STICKY_TEXT_INPUT_HEIGHT,
    this.color = Colors.red,
  });
  @override
  Widget build(BuildContext context) {
    double spacingLeft = spacing[2];
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          child: Container(
            color: isCorrect
                ? Theme.of(context).indicatorColor
                : Theme.of(context).errorColor,
            height: height,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: spacing[2], left: spacingLeft),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: spacing[5]),
                          child: Container(
                            width: MediaQuery.of(context).size.width -
                                size -
                                spacingLeft,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                isCorrect
                                    ? translate(
                                        context, "correct_answer_bottom")
                                    : "${translate(context, "wrong_answer_bottom")} $wrongMessageBottom",
                                style: Theme.of(context).textTheme.headline5,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          isCorrect
                              ? translate(context, "correct_answer_top")
                              : translate(context, "wrong_answer_top"),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: isCorrect
                        ? null
                        : ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: size),
                            child: Transform(
                              transform: Matrix4.rotationY(math.pi),
                              origin: Offset(size / 2, size / 2),
                              child: IconButton(
                                onPressed: onPressed,
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: isDisplayed ? size : 0,
                                  color: Theme.of(context).buttonColor,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          duration: duration,
          height: isDisplayed ? height : 0,
          decoration: BoxDecoration(color: color),
          margin: EdgeInsets.only(bottom: margin.toDouble()),
        ),
      ],
    );
  }
}
