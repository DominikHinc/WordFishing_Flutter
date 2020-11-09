import 'package:WordFishing/navigation/drawer-config.dart';
import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/providers/drawer-navigation-provider.dart';
import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<String> drawerScreenLabels = [];
  List<Widget> drawerScreens = [];

  @override
  void didChangeDependencies() {
    drawerScreenLabels.clear();
    getDrawerButtonConfigs(context).forEach((drawerConfig) {
      drawerScreenLabels.add(
        drawerConfig.label,
      );
      drawerScreens.add(
        drawerConfig.screen,
      );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final getScreenName = Provider.of<DrawerNavigationProvider>(context);
    final drawerAnimationProvider =
        Provider.of<DrawerAnimationProvider>(context);
    return GestureDetector(
      onTap: () {
        drawerAnimationProvider.toggleTransform();
      },
      child: Expanded(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(
            top: normalizePadding(context, 30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                  ),
                  SizedBox(
                    width: spacing[3],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'nick here',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        'status here',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: drawerScreenLabels.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      //TODO change this into a BoxButton or something man
                      onTap: () {
                        getScreenName.getScreenName(
                          drawerScreens[index].toString(),
                        );
                        drawerAnimationProvider.toggleTransform();
                      },
                      child: ListTile(
                        title: Text(
                          drawerScreenLabels[index],
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
