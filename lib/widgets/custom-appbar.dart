import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:WordFishing/utils/breakpoints.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatefulWidget {
  final String label;
  CustomAppbar({@required this.label});

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    final drawerAnimationProvider =
        Provider.of<DrawerAnimationProvider>(context);
    if (getAspectRatioBreakpoint(context) == AspectRatioBreakpoints.VERTICAL) {
      return AppBar(
        title: Text(translate(context, widget.label)),
        leading: Container(
          child: FlatButton(
            child: drawerAnimationProvider.toggle
                ? Icon(Icons.menu, color: Theme.of(context).buttonColor)
                : Icon(Icons.menu_open, color: Theme.of(context).buttonColor),
            onPressed: () {
              drawerAnimationProvider.toggleTransform(context);
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
