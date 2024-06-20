import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'screen.dart';
import 'state.dart';

class QuickHomePage extends StatefulMaterialPage<void, QuickHomeNotifier> {
  static const classFactoryKey = 'QuickHomePage';

  QuickHomePage()
      : super(
          key: const ValueKey(classFactoryKey),
          factoryKey: classFactoryKey,
          state: QuickHomeNotifier(),
          createScreen: QuickHomeScreen.new,
        );

  // ignore: avoid_unused_constructor_parameters
  factory QuickHomePage.fromState(Map<String, dynamic> state) =>
      QuickHomePage();
}
