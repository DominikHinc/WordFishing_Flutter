import 'package:flutter/material.dart';

class Question {
  final String question;
  final String answer;
  int numberOfRepeats = 1;

  Question({
    @required this.question,
    @required this.answer,
    this.numberOfRepeats,
  });
}
