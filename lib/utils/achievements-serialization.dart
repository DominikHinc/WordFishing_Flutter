import 'dart:convert';

Map<String, List<String>> decodeAchievementsList(String encodedString) {
  final Map<String, List<String>> tempMap = {};
  final localDecodedAchievements =
      jsonDecode(encodedString) as Map<String, dynamic>;
  localDecodedAchievements.keys.forEach((key) {
    tempMap[key] = [...localDecodedAchievements[key]];
  });
  return tempMap;
}
