import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase(FirebaseOptions options) async {
  await Firebase.initializeApp(
    options: options,
  );

  unawaited(FirebaseAnalytics.instance.logEvent(name: 'my_load'));
}
