import 'package:app_state/app_state.dart';
import 'package:flutter/cupertino.dart';

import 'path.dart';

class QuickHomeNotifier extends ChangeNotifier with PageStateMixin<void> {
  @override
  QuickHomePath get path => const QuickHomePath();
}
