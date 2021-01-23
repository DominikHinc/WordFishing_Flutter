import 'package:WordFishing/models/book.dart';
import 'package:WordFishing/models/unit.dart';
import 'package:WordFishing/models/vocabulary.dart';
import 'package:WordFishing/providers/achievement-provider.dart';
import 'package:WordFishing/providers/progress-provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool> saveUserDataToDatabase(String node, dynamic data) async {
  final auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    try {
      final databaseReference =
          FirebaseDatabase(app: Firebase.app()).reference();
      await databaseReference
          .child('user_data')
          .child(auth.currentUser.uid)
          .child(node)
          .set(
            data,
          );
      return true;
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: 'ERROR WHILE SAVING TO DATABASE NODE:$node DATA:$data');
      throw Error();
    }
  } else {
    return false;
  }
}

Future<dynamic> getUserDataFromDatabase(String node) async {
  final auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    try {
      final databaseReference =
          FirebaseDatabase(app: Firebase.app()).reference();
      final dbResponse = (await databaseReference
              .child('user_data')
              .child(auth.currentUser.uid)
              .child(node)
              .once())
          .value;
      print(dbResponse);
      return dbResponse;
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: 'ERROR WHILE RECEIVING FROM DATABASE NODE:$node');
      throw Error();
    }
  } else {
    return null;
  }
}

const dataExistsNode = 'data_exists';

// Returns translation key for the message that should be displayed after save
Future<String> saveProvidersToDatabase(BuildContext context) async {
  try {
    final achievementSaveResponse =
        await Provider.of<AchievementProvider>(context, listen: false)
            .saveListToDatabase();
    final progressSaveResponse =
        await Provider.of<ProgressProvider>(context, listen: false)
            .saveListToDatabase();

    final dataExistsResponse =
        await saveUserDataToDatabase(dataExistsNode, true);

    return achievementSaveResponse && progressSaveResponse && dataExistsResponse
        ? "save_successful"
        : "save_failed";
  } catch (error) {
    return "save_failed";
  }
}

// Returns translation key for the message that should be displayed after sync
Future<String> syncProvidersWithDatabase(BuildContext context) async {
  if (await getUserDataFromDatabase(dataExistsNode) != true)
    return 'sync_nothing_saved';

  try {
    final achievementSaveResponse =
        await Provider.of<AchievementProvider>(context, listen: false)
            .syncWithDatabase();
    final progressSaveResponse =
        await Provider.of<ProgressProvider>(context, listen: false)
            .syncWithDatabase();

    return achievementSaveResponse && progressSaveResponse
        ? "sync_successful"
        : "sync_failed";
  } catch (_) {
    return "sync_failed";
  }
}

Future<List<Book>> loadBooksFromDatabase(
    DatabaseReference databaseReference) async {
  final List<Book> books = [];
  Map booksData;
  Map vocabularyData;
  try {
    booksData = (await databaseReference.child('books').once()).value;
    vocabularyData = (await databaseReference.child("vocabulary").once()).value;
  } catch (e, s) {
    await FirebaseCrashlytics.instance
        .recordError(e, s, reason: 'ERROR WHILE LOADING BOOKS FROM DATABASE');
    return books;
  }

  booksData.keys.forEach((key) {
    final Map book = booksData[key];
    final Map bookUnits = vocabularyData[key];
    books.add(Book(
      id: key,
      title: book["title"],
      imgUrl: book["img_url"],
      numberOfUnits: book["number_of_units"],
      units: bookUnits.keys.map((vocabularyKey) {
        final unitData = bookUnits[vocabularyKey];
        final List unitVocabulary = unitData['data'];
        return Unit(
          bookId: key,
          unitNumber: unitData['unit_number'],
          unitTitle: unitData['unit_title'],
          vocabulary: unitVocabulary.map((vocabulary) {
            return Vocabulary(
              pl: vocabulary['pl'],
              en: vocabulary['en'],
            );
          }).toList(),
        );
      }).toList(),
    ));
  });

  return books;
}
