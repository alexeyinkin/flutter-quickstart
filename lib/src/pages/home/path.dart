import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../../router/tab_enum.dart';
import 'page.dart';

class QuickHomePath extends PagePath {
  static const _location = '/';

  const QuickHomePath() : super(key: QuickHomePage.classFactoryKey);

  @override
  String get location => _location;

  static QuickHomePath? tryParse(RouteInformation ri) {
    if (ri.uri.path != _location) return null;

    return const QuickHomePath();
  }

  @override
  String get defaultStackKey => QuickTabEnum.home.name;
}
