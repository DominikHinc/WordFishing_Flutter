import 'package:firebase_performance/firebase_performance.dart';

class PerformanceEvent {
  Trace _trace;

  PerformanceEvent(this._trace);

  void stop() {
    _trace.stop();
  }
}

// Example of how should custom performance event look like
PerformanceEvent measureVocabularyLoadTime() {
  Trace trace = FirebasePerformance.instance.newTrace('vocabulary_load');
  trace.start();
  return PerformanceEvent(trace);
}
