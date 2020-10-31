import 'package:WordFishing/utils/normalize.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(
        top: normalizePadding(context, 30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(),
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
                  Text('status here',
                      style: Theme.of(context).textTheme.subtitle2),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
