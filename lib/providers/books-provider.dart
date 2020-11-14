import 'package:WordFishing/models/book.dart';
import 'package:WordFishing/models/unit.dart';
import 'package:WordFishing/models/vocabulary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BooksProvider extends ChangeNotifier {
  List<Book> _books = [];
  bool _dataLoaded = false;

  BooksProvider() {
    // TODO add saving to local storage
    final databaseReference = FirebaseDatabase(app: Firebase.app()).reference();
    databaseReference.child('books').once().then((booksData) {
      databaseReference.child("vocabulary").once().then((vocabularyData) {
        (booksData.value as Map).keys.forEach((key) {
          final Map book = booksData.value[key];
          final Map bookUnits = vocabularyData.value[key];
          _books.add(Book(
            id: key,
            title: book["title"],
            imgUrl: book["img_url"],
            numberOfUnits: book["number_of_units"],
            units: bookUnits.keys.map((vocabularyKey) {
              final unitData = bookUnits[vocabularyKey];
              final List unitVocabulary = unitData['data'];
              return Unit(
                bookId: key,
                unitNumber: unitData['unit_number'],
                unitTitle: unitData['unit_title'],
                vocabulary: unitVocabulary.map((vocabulary) {
                  return Vocabulary(
                    pl: vocabulary['pl'],
                    en: vocabulary['en'],
                  );
                }).toList(),
              );
            }).toList(),
          ));
        });
      }).then((_) {
        _dataLoaded = true;
        notifyListeners();
        // TODO handle and report to firebase this error
      }).catchError((error) => print(error));
      // TODO handle and report to firebase this error
    }).catchError((error) => print(error));
  }

  // TODO add getters for book by id, vocabulary by book id ect...

  List<Book> get books {
    return _books;
  }

  bool get dataLoaded {
    return _dataLoaded;
  }
}
