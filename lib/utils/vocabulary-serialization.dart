import 'dart:convert';

import 'package:WordFishing/models/book.dart';
import 'package:WordFishing/models/unit.dart';
import 'package:WordFishing/models/vocabulary.dart';

List<Vocabulary> _decodeSerializedVocabulary(
  List<dynamic> serializedVocabulary,
) {
  List<Vocabulary> vocabularyList = [];
  serializedVocabulary.forEach(
    (vocabulary) {
      vocabularyList.add(
        Vocabulary(
          pl: vocabulary['pl'],
          en: vocabulary['en'],
        ),
      );
    },
  );
  return vocabularyList;
}

List<Unit> _decodeSerializedUnits(
  List<dynamic> serializedUnits,
) {
  List<Unit> units = [];
  serializedUnits.forEach(
    (unit) {
      units.add(
        Unit(
          bookId: unit['bookId'],
          unitNumber: unit['unitNumber'],
          unitTitle: unit['unitTitle'],
          vocabulary: _decodeSerializedVocabulary(unit['vocabulary']),
        ),
      );
    },
  );
  return units;
}

List<Book> decodeSerializedBooks(
  String serializedJSON,
) {
  List<Book> books = [];
  jsonDecode(serializedJSON).forEach(
    (decodedBook) {
      books.add(
        Book(
          title: decodedBook['title'],
          imgUrl: decodedBook['imgUrl'],
          numberOfUnits: decodedBook['numberOfUnits'],
          units: _decodeSerializedUnits(decodedBook['units']),
          id: decodedBook['id'],
        ),
      );
    },
  );
  return books;
}

String encodeBooks(List<Book> books) {
  return jsonEncode([
    ...books.map((book) {
      return {
        'id': book.id,
        'title': book.title,
        'imgUrl': book.imgUrl,
        'numberOfUnits': book.numberOfUnits,
        'units': [
          ...book.units.map((unit) {
            return {
              'bookId': unit.bookId,
              'unitNumber': unit.unitNumber,
              'unitTitle': unit.unitTitle,
              'vocabulary': [
                ...unit.vocabulary.map((vocabulary) {
                  return {
                    'pl': vocabulary.pl,
                    'en': vocabulary.en,
                  };
                })
              ]
            };
          })
        ]
      };
    })
  ]).toString();
}
