import 'package:WordFishing/utils/spacing.dart';
import 'package:flutter/material.dart';

class AchievementPopUp extends StatefulWidget {
  final double imgSize;
  final Color imgColor;
  final Duration animationDuration;
  AchievementPopUp({
    this.imgSize = 110,
    this.imgColor,
    this.animationDuration = const Duration(milliseconds: 250),
  });

  @override
  _AchievementPopUpState createState() => _AchievementPopUpState();
}

class _AchievementPopUpState extends State<AchievementPopUp> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    final imgUrl = 'https://i.imgur.com/NEiooFy.png';

    return GestureDetector(
      onTap: () {
        setState(() {
          _visible = !_visible;
        });
      },
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.animationDuration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: mediaQuerySize.width / 1.2,
            height: mediaQuerySize.height / 7,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  imgUrl,
                  color: widget.imgColor,
                  width: widget.imgSize,
                  height: widget.imgSize,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: spacing[5],
                    ),
                    child: Text(
                      //PLACEHOLDER
                      'Achievement "Complete book 1" completed!',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
