import 'dart:convert';

import 'package:WordFishing/services/db.dart';
import 'package:WordFishing/utils/achievements-serialization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AchievementProvider extends ChangeNotifier {
  static const _dbNodeName = 'achievements';

  final LocalStorage _storage = new LocalStorage('achievements');
  final String _localAchievementsStorageKey = 'local_achievements';

  Map<String, List<String>> _completedBookUnits = {};

  AchievementProvider() {
    _initializeList();
  }

  void _initializeList() async {
    try {
      final isReady = await _storage.ready;
      if (!isReady) throw Error();
    } catch (e, s) {
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'ACHIEVEMENTS CANNOT BE INITIALIZED');
      return;
    }

    final localAchievements = _storage.getItem(_localAchievementsStorageKey);

    if (localAchievements != null) {
      _completedBookUnits = decodeAchievementsList(localAchievements);
    }
  }

  List<String> getBookCompletedUnits(String bookId) {
    if (!_completedBookUnits.containsKey(bookId)) {
      _completedBookUnits[bookId] = [];
    }
    return _completedBookUnits[bookId];
  }

  void addUnitCompleted(String bookId, String unitNumber) {
    if (_completedBookUnits.containsKey(bookId)) {
      if (!(_completedBookUnits[bookId].contains(unitNumber))) {
        _completedBookUnits[bookId].add(unitNumber);
        _saveList();
        notifyListeners();
      }
    } else {
      _completedBookUnits[bookId] = [unitNumber];
      _saveList();
      notifyListeners();
    }
  }

  void _saveList() {
    _storage.setItem(
        _localAchievementsStorageKey, jsonEncode(_completedBookUnits));
  }

  Future<bool> saveListToDatabase() async {
    try {
      return await saveUserDataToDatabase(
        _dbNodeName,
        jsonEncode(_completedBookUnits),
      );
    } catch (e) {
      throw Error();
    }
  }

  void _mergeNewList(Map<String, List<String>> fromList) {
    fromList.keys.forEach((bookId) {
      if (!_completedBookUnits.containsKey(bookId)) {
        _completedBookUnits[bookId] = fromList[bookId];
      } else {
        fromList[bookId].forEach((unitNumber) {
          if (!_completedBookUnits[bookId].contains(unitNumber)) {
            _completedBookUnits[bookId].add(unitNumber);
          }
        });
      }
    });
  }

  Future<bool> syncWithDatabase() async {
    try {
      final dbResponse = await getUserDataFromDatabase(
        _dbNodeName,
      );

      if (dbResponse == null) return false;

      _mergeNewList(
        decodeAchievementsList(
          dbResponse,
        ),
      );

      _saveList();

      notifyListeners();

      return true;
    } catch (e) {
      throw Error();
    }
  }

  Map<String, List<String>> get completedBookUnits {
    return _completedBookUnits;
  }
}
