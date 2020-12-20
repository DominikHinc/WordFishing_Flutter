import 'dart:convert';

import 'package:WordFishing/utils/achievements-serialization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AchievementProvider extends ChangeNotifier {
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

  Map<String, List<String>> get completedBookUnits {
    return _completedBookUnits;
  }
}
