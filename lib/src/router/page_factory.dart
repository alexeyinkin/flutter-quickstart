import 'package:app_state/app_state.dart';

import '../pages/home/page.dart';
import '../pages/settings/page.dart';

class QuickPageFactory {
  static AbstractPage? createPage(
    String factoryKey,
    Map<String, dynamic> state,
  ) {
    switch (factoryKey) {
      case QuickSettingsPage.classFactoryKey:
        return QuickSettingsPage.fromState(state);

      case QuickHomePage.classFactoryKey:
        return QuickHomePage.fromState(state);
    }

    return null;
  }
}
