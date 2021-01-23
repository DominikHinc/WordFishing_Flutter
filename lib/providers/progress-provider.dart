import 'package:WordFishing/models/question.dart';
import 'package:WordFishing/services/db.dart';
import 'package:WordFishing/utils/progress-serialization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ProgressProvider extends ChangeNotifier {
  static const _dbNodeName = 'progress';

  final LocalStorage _storage = new LocalStorage('progress');
  final String _localProgressStorageKey = 'local_aprogress';
  Map<String, Map<String, List<Question>>> _vocabularyProgress = {};

  ProgressProvider() {
    _initializeList();
  }

  void _initializeList() async {
    try {
      final isReady = await _storage.ready;
      if (!isReady) throw Error();
    } catch (e, s) {
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'PROGRESS CANNOT BE INITIALIZED');
      return;
    }
    final localProgress = _storage.getItem(_localProgressStorageKey);
    if (localProgress != null) {
      _vocabularyProgress = decodeProgress(localProgress);
    }
  }

  void _saveProgress() {
    _storage.setItem(
        _localProgressStorageKey, encodeProgress(_vocabularyProgress));
  }

  void addVocabularyProgressList(
    String bookId,
    String unitNumber,
    List<Question> questionsList,
  ) {
    if (_vocabularyProgress.containsKey(bookId)) {
      _vocabularyProgress[bookId][unitNumber] = questionsList;
    } else {
      _vocabularyProgress[bookId] = {unitNumber: questionsList};
    }
    _saveProgress();
    notifyListeners();
  }

  Map<String, Map<String, List<Question>>> get vocabularyProgress {
    return _vocabularyProgress;
  }

  Map<String, List<Question>> getBookUnitsProgress(String bookId) {
    return _vocabularyProgress[bookId];
  }

  List<Question> getUnitProgress(String bookId, String unitNumber) {
    return _vocabularyProgress.containsKey(bookId)
        ? _vocabularyProgress[bookId][unitNumber]
        : null;
  }

  void deleteUnitProgress(String bookId, String unitNumber) {
    if (_vocabularyProgress.containsKey(bookId)) {
      _vocabularyProgress[bookId].remove(unitNumber);
      notifyListeners();
    }
  }

  void _mergeNewList(Map<String, Map<String, List<Question>>> fromList) {
    print(fromList);
    fromList.keys.forEach((bookId) {
      if (!_vocabularyProgress.containsKey(bookId)) {
        _vocabularyProgress[bookId] = fromList[bookId];
      } else {
        fromList[bookId].keys.forEach((unitNumber) {
          _vocabularyProgress[bookId][unitNumber] =
              fromList[bookId][unitNumber];
        });
      }
    });
  }

  Future<bool> saveListToDatabase() async {
    try {
      return await saveUserDataToDatabase(
        _dbNodeName,
        encodeProgress(
          _vocabularyProgress,
        ),
      );
    } catch (e) {
      throw Error();
    }
  }

  Future<bool> syncWithDatabase() async {
    try {
      final dbResponse = await getUserDataFromDatabase(
        _dbNodeName,
      );

      if (dbResponse == null) return false;

      _mergeNewList(decodeProgress(dbResponse));

      _saveProgress();

      notifyListeners();

      return true;
    } catch (e) {
      throw Error();
    }
  }
}
