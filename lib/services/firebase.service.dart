import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static Future<FirebaseService> init() async {
    await Firebase.initializeApp();
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kIsWeb && !kDebugMode);

    return FirebaseService();
  }
}
