import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/navigation/drawer-routes-config.dart';
import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/providers/drawer-navigation-provider.dart';
import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/utils/scaling.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/drawer-button-animator.dart';
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

    final drawerButtonDecorationBoxBorder = Radius.circular(4.0);
    final drawerButtonDecorationBoxHeight = normalizeHeight(context, 25);
    final drawerButtonDecorationBoxWidth = normalizeWidth(context, 2.5);

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
                  double scaleFactor = isSelected ? scaling[2] : scaling[1];
                  return InkWell(
                    onTap: () {
                      currentScreenProvider.setScreenRouteName(
                          context,
                          (buttonConfigs[index] as DrawerScreenProperties)
                              .routeNameLocal);
                      drawerAnimationProvider.toggleTransform(context);
                    },
                    child: Row(
                      children: <Widget>[
                        DrawerButtonAnimator(
                          scaleFactor: scaleFactor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: drawerButtonDecorationBoxBorder,
                              bottomRight: drawerButtonDecorationBoxBorder,
                            ),
                            child: Container(
                              height: drawerButtonDecorationBoxHeight,
                              width: drawerButtonDecorationBoxWidth,
                              color: Theme.of(context).buttonColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: normalizePadding(context, spacing[3]),
                          ),
                        ),
                        DrawerButtonAnimator(
                          scaleFactor: scaleFactor,
                          child: Text(
                            translate(
                                context,
                                (buttonConfigs[index] as DrawerScreenProperties)
                                    .drawerButtonTranslationKey),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ],
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
