import 'package:flutter/material.dart';

class AchievementProvider extends ChangeNotifier {
  int _currentBookIndex;
  bool _isBookSelected = false;

  int get currentBookIndex {
    return _currentBookIndex;
  }

  bool get isBookSelected {
    return _isBookSelected;
  }

  void getIsAchievementSelected(bool isBookSelected) {
    _isBookSelected = isBookSelected;
    notifyListeners();
  }

  int getCurrentAchievementIndex(int currentBookIndex) {
    return _currentBookIndex = currentBookIndex;
  }
}
