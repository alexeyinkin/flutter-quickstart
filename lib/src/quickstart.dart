import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:url_strategy/url_strategy.dart';

import 'delegate.dart';
import 'init/firebase.dart';
import 'init/router.dart';
import 'init/update_detector.dart';

class QuickStart {
  static bool _initialized = false;

  static QuickDelegate _delegate = DefaultQuickDelegate();

  static QuickDelegate get delegate => _delegate;

  static const packageName = 'quickstart';

  static Future<void> ensureInitialized({
    QuickDelegate? delegate,
    FirebaseOptions? firebaseOptions,
  }) async {
    if (_initialized) {
      return;
    }

    if (delegate != null) {
      _delegate = delegate;
    }

    setPathUrlStrategy();
    WidgetsFlutterBinding.ensureInitialized();

    await Future.wait([
      EasyLocalization.ensureInitialized(),
      if (firebaseOptions != null) initializeFirebase(firebaseOptions),
    ]);

    if (firebaseOptions != null) {
      initializeUpdateDetector();
    }

    await _delegate.settingsNotifier.initialize();

    initializeRouter(_delegate);

    _initialized = true;
  }
}
