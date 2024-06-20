import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../pages/home/path.dart';
import '../pages/settings/path.dart';

class QuickRouteInformationParser extends PageStacksRouteInformationParser {
  @override
  // ignore: avoid_renaming_method_parameters
  Future<PagePath> parsePagePath(RouteInformation ri) async {
    // ignore: unnecessary_null_in_if_null_operators
    return null ??
        QuickSettingsPath.tryParse(ri) ??

        // The default page if nothing worked.
        const QuickHomePath();
  }
}
