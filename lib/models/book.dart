import 'package:WordFishing/models/unit.dart';
import 'package:flutter/material.dart';

class Book {
  String id;
  String title;
  String imgUrl;
  int numberOfUnits;
  List<Unit> units;

  Book({
    @required this.title,
    @required this.imgUrl,
    @required this.numberOfUnits,
    @required this.units,
    @required this.id,
  });
}
