import 'package:app_state/app_state.dart';
import 'package:flutter/foundation.dart';

import 'screen.dart';
import 'state.dart';

class QuickSettingsPage
    extends StatefulMaterialPage<void, QuickSettingsNotifier> {
  static const classFactoryKey = 'QuickSettingsPage';

  QuickSettingsPage()
      : super(
          key: const ValueKey(classFactoryKey),
          factoryKey: classFactoryKey,
          state: QuickSettingsNotifier(),
          createScreen: QuickSettingsScreen.new,
        );

  // ignore: avoid_unused_constructor_parameters
  factory QuickSettingsPage.fromState(Map<String, dynamic> state) =>
      QuickSettingsPage();
}
