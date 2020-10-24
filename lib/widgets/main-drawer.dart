import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: DrawerHeader(
                //TODO use spacing util
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'WordFishing',
                    //TODO use HOW
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
