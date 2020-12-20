import 'package:flutter/material.dart';

class Question {
  final String question;
  final String answer;
  int numberOfRepeats;

  Question({
    @required this.question,
    @required this.answer,
    @required this.numberOfRepeats,
  });
}
