import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/cross-platform-svg.dart';
import 'package:flutter/material.dart';

class AchievementPopup extends StatelessWidget {
  final displayed;
  final double size;
  final int duration;
  final String message;

  AchievementPopup({
    @required this.message,
    this.displayed = false,
    this.size,
    this.duration = 200,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final logoSize = size != null ? size : screenWidth / 6;

    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: duration),
          width: screenWidth,
          transform: Matrix4.translationValues(0, displayed ? 0 : -logoSize, 0),
          decoration: BoxDecoration(color: theme.primaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CrossPlatformSvg.asset(
                color: theme.canvasColor,
                height: logoSize,
                width: logoSize,
              ),
              Text(
                "${translate(context, "achievement_unlocked")}\n$message",
                style: theme.textTheme.headline6,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        )
      ],
    );
  }
}
