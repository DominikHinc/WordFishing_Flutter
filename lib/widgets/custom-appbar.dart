import 'package:WordFishing/providers/drawer-animation-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatefulWidget {
  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    final drawerAnimationProvider =
        Provider.of<DrawerTransformationProvider>(context);
    return AppBar(
      title: Text('test'),
      leading: Container(
        child: FlatButton(
          child: drawerAnimationProvider.toggle
              ? Icon(Icons.menu, color: Theme.of(context).buttonColor)
              : Icon(Icons.menu_open, color: Theme.of(context).buttonColor),
          onPressed: () {
            drawerAnimationProvider.toggleTransform();
          },
        ),
      ),
    );
  }
}
