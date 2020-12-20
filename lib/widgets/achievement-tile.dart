import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/progress-bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AchievementTile extends StatefulWidget {
  final bookTitle;
  final bookImgUrl;
  final int numberOfBookUnits;
  final List<String> listOfCompletedUnits;

  AchievementTile(this.bookTitle, this.bookImgUrl, this.numberOfBookUnits,
      this.listOfCompletedUnits);

  @override
  _AchievementTileState createState() => _AchievementTileState();
}

class _AchievementTileState extends State<AchievementTile> {
  bool isExpanded = false;

  List<Widget> _achievementsList(
    BuildContext context,
    double height,
    double width,
    double bottomBorderRadius,
  ) {
    List<Widget> achievementsList = [];
    for (int i = 1; i <= widget.numberOfBookUnits; i++) {
      final isCompleted = widget.listOfCompletedUnits.contains(i.toString());
      final isLastElement = widget.numberOfBookUnits == i;
      achievementsList.add(Container(
        padding: EdgeInsets.symmetric(horizontal: spacing[4]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${translate(context, "achievementToComplete")} $i",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Icon(
              isCompleted ? Icons.done : Icons.close,
              size: height / 3,
              color: isCompleted
                  ? Theme.of(context).indicatorColor
                  : Theme.of(context).errorColor,
            )
          ],
        ),
        height: height,
        width: width,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: isLastElement
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(bottomBorderRadius),
                  bottomRight: Radius.circular(bottomBorderRadius),
                )
              : null,
          border: !isLastElement
              ? Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).backgroundColor,
                  ),
                )
              : null,
        ),
      ));
    }
    return achievementsList;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bookContainerWidth = screenWidth * .9;
    final bookContainerHeight = screenWidth / 2.5;
    final mainContainerBorderRadius = bookContainerHeight / 12;
    final achievementCompleteTileHeight = bookContainerHeight / 2;
    final achievementCompleteTileWidth = bookContainerWidth * .9;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: spacing[4]),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              width: bookContainerWidth,
              height: bookContainerHeight,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(mainContainerBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: -2,
                    blurRadius: 7,
                    offset: Offset(1, 3),
                  )
                ],
              ),
              padding: EdgeInsets.all(spacing[3]),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      (mainContainerBorderRadius - spacing[3] / 6),
                    ),
                    child: CachedNetworkImage(imageUrl: widget.bookImgUrl),
                  ),
                  Expanded(
                    // height: bookContainerHeight,
                    // width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.bookTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spacing[2]),
                          child: ProgressBar(
                            maxAmount: widget.numberOfBookUnits.toDouble(),
                            currentProgress:
                                widget.listOfCompletedUnits.length.toDouble(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: isExpanded
                ? achievementCompleteTileHeight * widget.numberOfBookUnits
                : 0,
            child: SingleChildScrollView(
              child: Column(
                children: _achievementsList(
                  context,
                  achievementCompleteTileHeight,
                  achievementCompleteTileWidth,
                  mainContainerBorderRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
