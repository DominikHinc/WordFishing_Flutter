import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/navigation/drawer-routes-config.dart';
import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/providers/drawer-navigation-provider.dart';
import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final buttonConfigs =
        getDrawerRouteNames().entries.map((e) => e.value(context)).toList();
    final drawerAnimationProvider =
        Provider.of<DrawerAnimationProvider>(context);
    final currentScreenProvider =
        Provider.of<DrawerNavigationProvider>(context);

    return GestureDetector(
      onTap: () {
        drawerAnimationProvider.toggleTransform(context);
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(
          top: normalizePadding(context, spacing[6]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: buttonConfigs.length,
                itemBuilder: (context, index) {
                  var isSelected =
                      (buttonConfigs[index] as DrawerScreenProperties)
                              .routeNameLocal ==
                          (currentScreenProvider.currentScreen
                                  as DrawerScreenProperties)
                              .routeNameLocal;
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: normalizePadding(context, spacing[5])),
                    child: InkWell(
                      onTap: () {
                        currentScreenProvider.setScreenRouteName(
                            context,
                            (buttonConfigs[index] as DrawerScreenProperties)
                                .routeNameLocal);
                        drawerAnimationProvider.toggleTransform(context);
                      },
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4.0),
                              bottomRight: Radius.circular(4.0),
                            ),
                            child: Container(
                              height: isSelected
                                  ? normalizeHeight(context, 50.0)
                                  : normalizeHeight(context, 30.0),
                              color: Theme.of(context).buttonColor,
                              width: isSelected
                                  ? normalizeWidth(context, 5.0)
                                  : normalizeWidth(context, 3.0),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: normalizePadding(context, 10),
                            ),
                          ),
                          Text(
                            translate(
                                context,
                                (buttonConfigs[index] as DrawerScreenProperties)
                                    .drawerButtonTranslationKey),
                            style: Theme.of(context).textTheme.subtitle2,
                            textScaleFactor:
                                isSelected ? typography[2] : typography[1],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
