import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/models/units_screen_arguments.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:WordFishing/widgets/custom-grid-tile.dart';
import 'package:WordFishing/widgets/custom-grid-view.dart';
import 'package:WordFishing/widgets/empty-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = './Books';
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "book_screen_label";
  @override
  Widget build(BuildContext context) {
    var booksProvider = Provider.of<BooksProvider>(context);
    var books = booksProvider.books;
    String translated = translate(context, "number_of_units");
    return Center(
      child: Scaffold(
        appBar: CustomAppBar(
          "book_screen_label",
        ),
        body: CustomGridView(
          childAspectRatio: 0.7,
          children: [
            if (booksProvider.dataLoaded)
              ...books.map((book) {
                return CustomGridTile(
                  onPressed: () {
                    Navigator.pushNamed(context, "./Units",
                        arguments: UnitsScreenArguments(book.id));
                  },
                  imageUrl: book.imgUrl,
                  title: book.title,
                  topText: book.title,
                  bottomText: "$translated: ${book.numberOfUnits}",
                );
              })
            else
              EmptyScreen(),
          ],
        ),
      ),
    );
  }
}
