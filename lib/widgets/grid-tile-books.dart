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
    return OpacityButton(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Container(
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
            height: 40,
            child: GridTileBar(
              title: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate('class'),
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        gridTileBarTextOne,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontFamily: 'Montserrat',
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
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        gridTileBarTextTwo,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ), //TODO move gridtile to a new widget
    );
  }
}
