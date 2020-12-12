import 'package:WordFishing/models/learning-screen-arguments.dart';
import 'package:WordFishing/models/units_screen_arguments.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/screens/learning-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/custom-grid-tile.dart';
import 'package:WordFishing/widgets/custom-grid-view.dart';
import 'package:WordFishing/widgets/empty-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitsScreen extends StatelessWidget {
  static const routeName = './Units';
  final drawerButtonTranslationKey = "units_screen_label";
  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);
    final UnitsScreenArguments unitsScreenArguments =
        ModalRoute.of(context).settings.arguments;
    final translated = translate(context, "unit");
    return Center(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              translate(context, drawerButtonTranslationKey),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                },
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
          body: booksProvider.dataLoaded
              ? CustomGridView(
                  childAspectRatio: 1.5,
                  children: booksProvider
                      .getBookUnits(unitsScreenArguments.bookId)
                      .map((units) {
                    return CustomGridTile(
                      title: units.unitTitle,
                      bottomText: "$translated${units.unitNumber}",
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          LearningScreen.routeName,
                          arguments: LeariningScreenArguments(
                            unitsScreenArguments.bookId,
                            units.unitNumber,
                            null,
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : EmptyScreen()),
    );
  }
}
