import 'dart:convert';

import 'package:WordFishing/models/question.dart';

final _questionMapKey = 'question';
final _answerMapKey = 'answer';
final _numberOfRepeatsMapHey = 'numberOfRepeats';

String encodeProgress(Map<String, Map<String, List<Question>>> progress) {
  final mapToEncode = {};
  progress.keys.forEach((bookId) {
    progress[bookId].keys.forEach((unitNumer) {
      if (!(mapToEncode.containsKey(bookId))) mapToEncode[bookId] = {};

      mapToEncode[bookId][unitNumer] =
          progress[bookId][unitNumer].map((question) {
        return {
          _questionMapKey: question.question,
          _answerMapKey: question.answer,
          _numberOfRepeatsMapHey: question.numberOfRepeats
        };
      }).toList();
    });
  });
  return jsonEncode(mapToEncode);
}

Map<String, Map<String, List<Question>>> decodeProgress(
  String encodedProgress,
) {
  final savedProgress = jsonDecode(encodedProgress);
  final Map<String, Map<String, List<Question>>> decodedProgress = {};

  savedProgress.keys.forEach(
    (bookId) {
      if (!(decodedProgress.containsKey(bookId))) decodedProgress[bookId] = {};

      savedProgress[bookId].keys.forEach(
        (unitNumber) {
          decodedProgress[bookId][unitNumber] = [];
          savedProgress[bookId][unitNumber].forEach(
            (question) {
              decodedProgress[bookId][unitNumber].add(
                Question(
                  question: question[_questionMapKey],
                  answer: question[_answerMapKey],
                  numberOfRepeats: question[_numberOfRepeatsMapHey],
                ),
              );
            },
          );
        },
      );
    },
  );
  return decodedProgress;
}
