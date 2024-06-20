import 'package:app_state/app_state.dart';
import 'package:enum_map/enum_map.dart';

import '../pages/home/page.dart';
import '../pages/settings/page.dart';

@MakeUnmodifiableMap()
enum QuickTabEnum {
  home,
  settings,
}

final quickBottomPages = UnmodifiableQuickTabEnumMap<AbstractPage>(
  home: QuickHomePage(),
  settings: QuickSettingsPage(),
);
