import 'package:firebase_analytics/firebase_analytics.dart';

// Example of how should custom analytics event look like
void sendFinishedLearningEvent() {
  FirebaseAnalytics().logEvent(name: "finished_learning");
}

void sendTestEvent() {
  FirebaseAnalytics().logEvent(name: "test_event");
}
