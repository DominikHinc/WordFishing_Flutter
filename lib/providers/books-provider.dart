import 'package:WordFishing/models/book.dart';
import 'package:WordFishing/models/question.dart';
import 'package:WordFishing/models/unit.dart';
import 'package:WordFishing/models/vocabulary.dart';
import 'package:WordFishing/providers/settings-provider.dart';
import 'package:WordFishing/services/db.dart';
import 'package:WordFishing/utils/vocabulary-serialization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

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
    } catch (e, s) {
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'LOCAL STORAGE CANNOT BE INITIALIZED');
      return;
    }

    final databaseReference = FirebaseDatabase(app: Firebase.app()).reference();
    final localLastUpdate = storage.getItem(lastUpdateStorageKey);
    var databaseLastUpdate = localLastUpdate;
    try {
      databaseLastUpdate =
          (await databaseReference.child('last_update').once()).value;
    } catch (e, s) {
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'CANNOT GET LAST UPDATE FROM DATABASE');
    }

    if (localLastUpdate == databaseLastUpdate) {
      final localVocabulary = storage.getItem(localVocabularyStorageKey);
      if (localVocabulary != null)
        _books = decodeSerializedBooks(localVocabulary);
      _dataLoadedCorrectly();
    } else {
      try {
        _books = await loadBooksFromDatabase(databaseReference);
      } catch (e, s) {
        await FirebaseCrashlytics.instance.recordError(e, s,
            reason: 'ERROR WHILE LOADING BOOKS FROM DATABASE');
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

  List<Book> get books {
    return _books;
  }

  bool get dataLoaded {
    return _dataLoaded;
  }

  Book getBookById(String bookId) {
    return _books.firstWhere((bookElem) => bookElem.id == bookId);
  }

  List<Unit> getBookUnits(String bookId) {
    getBookById(bookId).units.sort((a, b) =>
        int.tryParse(a.unitNumber).compareTo(int.tryParse(b.unitNumber)));
    return getBookById(bookId).units;
  }

  Unit getBookUnit(String bookId, String unitNumber) {
    return getBookUnits(bookId)
        .firstWhere((unitElem) => unitElem.unitNumber == unitNumber);
  }

  List<Vocabulary> getUnitVocabulary(String bookId, String unitNumber) {
    return getBookUnit(bookId, unitNumber).vocabulary;
  }

  List<Question> getQuestionsList(
      BuildContext context, String bookId, String unitNumber) {
    final settings = Provider.of<SettingsProvider>(context);
    return getUnitVocabulary(bookId, unitNumber).map((e) {
      return Question(
        question:
            settings.languageType == LanguageType.ENGLISH_POLISH ? e.en : e.pl,
        answer:
            settings.languageType == LanguageType.ENGLISH_POLISH ? e.pl : e.en,
        numberOfRepeats: settings.numberOfRepeats,
      );
    }).toList();
  }

  int getVocabularyListWordCount(String bookId, String unitNumber) {
    return getUnitVocabulary(bookId, unitNumber).length;
  }
}
