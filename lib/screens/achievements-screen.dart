import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/providers/achievement-provider.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/widgets/achievement-tile.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementsScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./Achievements";
  @override
  final routeNameLocal = AchievementsScreen.routeName;
  @override
  final drawerButtonTranslationKey = "achievements_screen_label";
  @override
  @override
  Widget build(BuildContext context) {
    final achievementProvider =
        Provider(create: null).of<AchievementProvider>(context);
    final booksProvider = Provider.of<BooksProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        "achievements_screen_label",
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ...booksProvider.books
              .map(
                (book) => AchievementTile(
                  book.title,
                  book.imgUrl,
                  book.numberOfUnits,
                  achievementProvider.getBookCompletedUnits(book.id),
                ),
              )
              .toList(),
          SizedBox(
            height: spacing[4],
          )
        ]),
      ),
      body: AchievementScreenTile(),
    );
  }
}
