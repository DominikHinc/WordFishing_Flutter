import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/widgets/opacity-button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomGridTile extends StatelessWidget {
  final String imageUrl;
  final String topDataText;
  final String bottomDataText;
  final String title;
  final String topText;
  final String bottomText;
  final Function onPressed;
  final bool saved;
  final bool completed;

  CustomGridTile({
    this.imageUrl = '',
    this.topDataText = '',
    this.bottomDataText = '',
    this.title,
    this.bottomText = '',
    this.topText = '',
    this.onPressed,
    this.saved = false,
    this.completed = false,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: -2,
                blurRadius: 7,
                offset: Offset(1, 3),
              ),
            ],
          ),
          child: OpacityButton(
            onPressed: onPressed,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Center(
                            child: Text(
                              'Unable to load content',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: spacing[3]),
                            child: Text(title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                        ),
                ),
                footer: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing[3],
                      vertical: spacing[2],
                    ),
                    child: Column(
                      children: <Widget>[
                        if (topText.length > 0)
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  topText,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                topDataText,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: spacing[1],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                bottomText,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              bottomDataText,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: spacing[3], right: spacing[3], top: spacing[1]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.save,
                color: saved
                    ? Theme.of(context).textTheme.headline6.color
                    : Colors.transparent,
              ),
              Icon(
                Icons.done,
                color: completed
                    ? Theme.of(context).indicatorColor
                    : Colors.transparent,
              ),
            ],
          ),
        )
      ],
    );
  }
}
