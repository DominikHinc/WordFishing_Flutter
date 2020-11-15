import 'dart:convert';

import 'package:WordFishing/models/book.dart';
import 'package:WordFishing/models/unit.dart';
import 'package:WordFishing/models/vocabulary.dart';
import 'package:WordFishing/services/db.dart';
import 'package:WordFishing/utils/vocabulary-serialization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class BooksProvider extends ChangeNotifier {
  List<Book> _books = [];
  bool _dataLoaded = false;

  final String lastUpdateStorageKey = 'last_update';
  final String localVocabularyStorageKey = 'local_vocabulary';

  final LocalStorage storage = new LocalStorage('vocabulary');

  BooksProvider() {
    _initializeBooks();
  }

  void _initializeBooks() async {
    try {
      final isReady = await storage.ready;
      if (!isReady) throw Error();
    } catch (e) {
      //TODO report error to firebase
      print("LOCAL STORAGE CANNOT BE INITIALIZED");
      return;
    }

    final databaseReference = FirebaseDatabase(app: Firebase.app()).reference();
    final databaseLastUpdate =
        (await databaseReference.child('last_update').once()).value;
    final localLastUpdate = storage.getItem(lastUpdateStorageKey);

    if (localLastUpdate == databaseLastUpdate) {
      _books =
          decodeSerializedBooks(storage.getItem(localVocabularyStorageKey));
      _dataLoadedCorrectly();
    } else {
      try {
        _books = await loadBooksFromDatabase(databaseReference);
      } catch (e) {
        //TODO report error to firebase
        print("ERROR WHILE LOADING BOOKS FROM DATABASE");
        return;
      }
      storage.setItem(lastUpdateStorageKey, databaseLastUpdate);
      storage.setItem(localVocabularyStorageKey, encodeBooks(_books));
      _dataLoadedCorrectly();
    }
  }

  void _dataLoadedCorrectly() {
    _dataLoaded = true;
    notifyListeners();
  }

  // TODO add getters for book by id, vocabulary by book id ect...

  List<Book> get books {
    return _books;
  }

  bool get dataLoaded {
    return _dataLoaded;
  }
}
