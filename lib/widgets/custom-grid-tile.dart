import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/opacity-button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  final String imageUrl;
  final String topDataText;
  final String bottomDataText;
  final String title;
  final String topText;
  final String bottomText;

  CustomGridTile({
    this.imageUrl = ' ',
    this.topDataText = ' ',
    this.bottomDataText = ' ',
    this.title,
    this.bottomText = ' ',
    this.topText = ' ',
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: title.isEmpty || imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
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
                      child: Text(title),
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
                    Row(
                      children: <Widget>[
                        Text(
                          translate(context, topText),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          topDataText,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          translate(context, bottomText),
                          style: Theme.of(context).textTheme.subtitle2,
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
    );
  }
}
