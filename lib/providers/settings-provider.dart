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
  int _numberOfRepeats = 1;

  int get numberOfRepeats {
    return _numberOfRepeats;
  }

  InputType get inputType {
    return _inputType;
  }

  LanguageType get languageType {
    return _languageType;
  }
}
