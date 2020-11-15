import 'package:WordFishing/models/book.dart';
import 'package:WordFishing/models/unit.dart';
import 'package:WordFishing/models/vocabulary.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<Book>> loadBooksFromDatabase(
    DatabaseReference databaseReference) async {
  final List<Book> books = [];
  Map booksData;
  Map vocabularyData;
  try {
    booksData = (await databaseReference.child('books').once()).value;
    vocabularyData = (await databaseReference.child("vocabulary").once()).value;
  } catch (error) {
    //TODO report error to firebase
    print("ERROR WHILE LOADING BOOKS FROM DATABASE");
    print(error);
    return books;
  }

  booksData.keys.forEach((key) {
    final Map book = booksData[key];
    final Map bookUnits = vocabularyData[key];
    books.add(Book(
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

  return books;
}
