import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsServices {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);
}
