import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/utils/breakpoints.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String label;
  final Function onDrawerIconPressed;

  CustomAppBar(this.label, {Key key, this.onDrawerIconPressed})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    final drawerAnimationProvider =
        Provider.of<DrawerAnimationProvider>(context);
    if (getAspectRatioBreakpoint(context) == AspectRatioBreakpoints.VERTICAL) {
      return AppBar(
        title: Text(translate(context, label)),
        leading: Container(
          child: FlatButton(
            child: drawerAnimationProvider.toggle
                ? Icon(Icons.menu, color: Theme.of(context).buttonColor)
                : Icon(Icons.menu_open, color: Theme.of(context).buttonColor),
            onPressed: () {
              drawerAnimationProvider.toggleTransform(context);
              if (onDrawerIconPressed != null) onDrawerIconPressed();
            },
          ),
        ),
      );
    }
    return Row(
      children: [
        Container(
          height: 85,
          width: 120,
          child: TextButton(
            child: drawerAnimationProvider.toggle
                ? Icon(
                    Icons.menu,
                    color: Theme.of(context).textTheme.headline6.color,
                    size: 35,
                  )
                : Icon(
                    Icons.menu_open,
                    color: Theme.of(context).textTheme.headline6.color,
                    size: 35,
                  ),
            onPressed: () {
              drawerAnimationProvider.toggleTransform(context);
            },
          ),
        ),
      ],
    );
  }
}
