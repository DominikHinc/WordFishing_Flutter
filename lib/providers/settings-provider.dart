import 'package:WordFishing/utils/translate.dart';
import 'package:flutter/material.dart';

enum InputType { TEXT_INPUT, MULTIPLE_CHOICE }
enum LanguageType { POLISH_ENGLISH, ENGLISH_POLISH }

class SettingsProvider extends ChangeNotifier {
  /// Whether user will learn by typing the words
  /// or by multiple choice
  InputType _inputType = InputType.TEXT_INPUT;

  /// How user wants to learn
  /// Enum structure: <QUESTION_LANGUAGE>_<ANSWER_LANGUAGE>
  LanguageType _languageType = LanguageType.ENGLISH_POLISH;

  /// How many times does a word needs to be answered correctly
  /// to be removed from the current list
  double _numberOfRepeats = 1;

  double get numberOfRepeats {
    return _numberOfRepeats;
  }

  InputType get inputType {
    return _inputType;
  }

  LanguageType get languageType {
    return _languageType;
  }

  void switchLanguageType(LanguageType languageType) {
    _languageType = languageType;
    notifyListeners();
  }

  void changeNumberOfRepeats(double numberOfRepeats) {
    _numberOfRepeats = numberOfRepeats;
    notifyListeners();
  }

  String getAnswerLanguageTranslation(BuildContext context) {
    return languageType == LanguageType.ENGLISH_POLISH
        ? translate(context, "english")
        : translate(context, "polish");
  }

  String getQuestionLanguageTranslation(BuildContext context) {
    return languageType == LanguageType.ENGLISH_POLISH
        ? translate(context, "polish")
        : translate(context, "english");
  }
}
