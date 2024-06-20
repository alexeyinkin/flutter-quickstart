import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../../router/tab_enum.dart';
import 'page.dart';

class QuickSettingsPath extends PagePath {
  static const _location = '/settings';

  const QuickSettingsPath() : super(key: QuickSettingsPage.classFactoryKey);

  @override
  String get location => _location;

  static QuickSettingsPath? tryParse(RouteInformation ri) {
    if (ri.uri.path != _location) return null;

    return const QuickSettingsPath();
  }

  @override
  String get defaultStackKey => QuickTabEnum.settings.name;
}
