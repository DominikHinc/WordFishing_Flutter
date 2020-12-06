import 'package:WordFishing/widgets/sticky-text-input.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomSnackbar extends StatelessWidget {
  final double height;
  final double size;
  final bool isDisplayed;
  final Function onPressed;
  final Duration duration;
  final int margin;
  final Color color;
  CustomSnackbar({
    this.height = 100,
    this.size = 30,
    @required this.isDisplayed,
    @required this.onPressed,
    this.duration = const Duration(milliseconds: 250),
    this.margin = StickyTextInput.STICKY_TEXT_INPUT_HEIGHT,
    this.color = Colors.red,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: Container(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(child: Text("penis")),
                Text("penis"),
              ],
            ),
            Center(
              child: FlatButton(
                onPressed: onPressed,
                child: Transform(
                  transform: Matrix4.rotationY(math.pi),
                  origin: Offset(size / 2, size / 2),
                  child: Icon(
                    Icons.arrow_back,
                    size: isDisplayed ? size : 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      duration: duration,
      height: isDisplayed ? height : 0,
      decoration: BoxDecoration(color: color),
      margin: EdgeInsets.only(bottom: margin.toDouble()),
    );
  }
}
