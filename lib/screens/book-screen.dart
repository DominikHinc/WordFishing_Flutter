import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/models/units_screen_arguments.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/screens/units-screen.dart';
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
    final booksProvider = Provider.of<BooksProvider>(context);
    final books = booksProvider.books;
    String translated = translate(context, "number_of_units");
    return Scaffold(
      appBar: CustomAppBar(
        "book_screen_label",
      ),
      body: booksProvider.dataLoaded
          ? CustomGridView(
              childAspectRatio: 0.7,
              children: books.map((book) {
                return CustomGridTile(
                  onPressed: () {
                    Navigator.pushNamed(context, UnitsScreen.routeName,
                        arguments: UnitsScreenArguments(book.id));
                  },
                  imageUrl: book.imgUrl,
                  title: book.title,
                  topText: book.title,
                  bottomText: "$translated: ${book.numberOfUnits}",
                );
              }).toList(),
            )
          : EmptyScreen(),
    );
  }
}
