import 'package:WordFishing/providers/achievement-provider.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/widgets/progress-bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementScreenTile extends StatelessWidget {
  final double maxAchievementAmount;
  final bool isCompleted;
  AchievementScreenTile({
    this.maxAchievementAmount = 10,
    this.isCompleted = false,
  });

  final bool isAchievementSelected = false;
  @override
  Widget build(BuildContext context) {
    final achievementProvider = Provider.of<AchievementProvider>(context);
    final booksProvider = Provider.of<BooksProvider>(context);
    final books = booksProvider.books;
    final mediaQuerySize = MediaQuery.of(context).size;
    final padding = spacing[3];
    final achievementListViewRounding = Radius.circular(10);
    final achievementScreenTextStyle = Theme.of(context).textTheme.subtitle2;
    final animationDuration = Duration(milliseconds: 250);

    return SingleChildScrollView(
      child: Column(
        children: books
            .asMap()
            .map(
              (i, book) {
                return MapEntry(
                  i,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        achievementProvider
                            .getIsAchievementSelected(!isAchievementSelected);
                        achievementProvider.getCurrentAchievementIndex(i);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: padding,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              width: mediaQuerySize.width / 1.2,
                              height: mediaQuerySize.height / 7.5,
                              child: Padding(
                                padding: EdgeInsets.all(padding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Container(
                                        child: Image.network(
                                          book.imgUrl,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: padding),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              book.title,
                                              textAlign: TextAlign.center,
                                              style: achievementScreenTextStyle,
                                            ),
                                            ProgressBar(
                                              maxAmount: maxAchievementAmount,
                                              currentProgress: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: achievementListViewRounding,
                              bottomRight: achievementListViewRounding,
                            ),
                            child: AnimatedContainer(
                              duration: animationDuration,
                              color: Theme.of(context).primaryColor,
                              height: achievementProvider.isBookSelected &&
                                      i == achievementProvider.currentBookIndex
                                  ? 200
                                  : 0,
                              width: mediaQuerySize.width / 1.3,
                              //TODO add a list of achievements to the ListView
                              child: ListView.builder(
                                itemCount: maxAchievementAmount.toInt(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text(
                                      "placeholder",
                                      maxLines: 2,
                                      style: achievementScreenTextStyle,
                                    ),
                                    trailing: Icon(
                                      isCompleted
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            .values
            .toList(),
      ),
    );
  }
}
