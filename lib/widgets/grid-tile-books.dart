import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/widgets/opacity-button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:WordFishing/services/app-localizations.dart';

class GridTileBooks extends StatelessWidget {
  final String imageUrl;
  final String gridTileBarTextOne;
  final String gridTileBarTextTwo;

  GridTileBooks({
    this.imageUrl = ' ',
    this.gridTileBarTextOne = ' ',
    this.gridTileBarTextTwo = ' ',
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
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: CachedNetworkImage(
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
                          AppLocalizations.of(context).translate('class'),
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline6
                                .fontFamily,
                          ),
                        ),
                        Text(
                          gridTileBarTextOne,
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline6
                                .fontFamily,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('chapters'),
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline6
                                .fontFamily,
                          ),
                        ),
                        Text(
                          gridTileBarTextTwo,
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline6
                                .fontFamily,
                          ),
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
