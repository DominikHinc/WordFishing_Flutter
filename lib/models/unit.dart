import 'package:WordFishing/models/vocabulary.dart';
import 'package:flutter/material.dart';

class Unit {
  String bookId;
  String unitNumber;
  String unitTitle;
  List<Vocabulary> vocabulary;

  Unit({
    @required this.bookId,
    @required this.unitNumber,
    @required this.unitTitle,
    @required this.vocabulary,
  });
}
