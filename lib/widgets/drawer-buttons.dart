import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final String title;

  DrawerButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        // elevation: 3,
        color: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.black,
        elevation: 3,
        child: FlatButton(
          minWidth: 500,
          onPressed: () {},
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
