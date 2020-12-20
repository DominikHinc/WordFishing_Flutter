import 'package:WordFishing/models/learning-screen-arguments.dart';
import 'package:WordFishing/models/units_screen_arguments.dart';
import 'package:WordFishing/providers/achievement-provider.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/providers/progress-provider.dart';
import 'package:WordFishing/screens/learning-screen.dart';
import 'package:WordFishing/screens/settings-screen.dart';
import 'package:WordFishing/theme/palette.dart';
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
    final achievementsProvider = Provider.of<AchievementProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
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
                    final isUnitCompleted = achievementsProvider
                        .getBookCompletedUnits(unitsScreenArguments.bookId)
                        .contains(units.unitNumber);
                    final isUnitSaved = (progressProvider.getUnitProgress(
                            unitsScreenArguments.bookId, units.unitNumber) !=
                        null);
                    return CustomGridTile(
                      title: units.unitTitle,
                      bottomText: "$translated${units.unitNumber}",
                      completed: isUnitCompleted,
                      saved: isUnitSaved,
                      onPressed: () {
                        // TODO implrove this code's quality
                        if (isUnitSaved) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "You have a saved progress!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        color: Palette.secondary,
                                      ),
                                ),
                                content: Text(
                                  "Do you want to load it?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: Palette.secondary,
                                      ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                  TextButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  )
                                ],
                              );
                            },
                          ).then((shouldLoad) {
                            if (shouldLoad == null) return;
                            Navigator.pushNamed(
                              context,
                              LearningScreen.routeName,
                              arguments: LeariningScreenArguments(
                                unitsScreenArguments.bookId,
                                units.unitNumber,
                                null,
                                shouldLoad,
                              ),
                            );
                          });
                        } else {
                          Navigator.pushNamed(
                            context,
                            LearningScreen.routeName,
                            arguments: LeariningScreenArguments(
                              unitsScreenArguments.bookId,
                              units.unitNumber,
                              null,
                              false,
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                )
              : EmptyScreen()),
    );
  }
}
