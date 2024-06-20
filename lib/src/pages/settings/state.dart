import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import 'path.dart';

class QuickSettingsNotifier extends ChangeNotifier with PageStateMixin<void> {
  @override
  QuickSettingsPath get path => const QuickSettingsPath();
}
