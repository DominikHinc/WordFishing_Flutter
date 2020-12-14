import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/widgets/progress-bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementScreenTile extends StatefulWidget {
  @override
  _AchievementScreenTileState createState() => _AchievementScreenTileState();
}

class _AchievementScreenTileState extends State<AchievementScreenTile> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);
    final books = booksProvider.books;
    final mediaQuerySize = MediaQuery.of(context).size;
    final paddingValue = spacing[3];

    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          setState(() {
            isActive = !isActive;
            print(isActive);
          });
        },
        child: Column(
          children: books.map((book) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: spacing[3],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      width: mediaQuerySize.width / 1.2,
                      height: mediaQuerySize.height / 7.5,
                      child: Padding(
                        padding: EdgeInsets.all(paddingValue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Container(
                                child: Image.network(
                                  book.imgUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    book.title,
                                    textAlign: TextAlign.center,
                                  ),
                                  ProgressBar(
                                    maxAmount: 30,
                                    currentProgress: 0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    color: Theme.of(context).primaryColor,
                    height: isActive ? 400 : 0,
                    width: mediaQuerySize.width / 1.3,
                    child: isActive
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("data"),
                              Text("data"),
                              Text("data"),
                            ],
                          )
                        : null,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
