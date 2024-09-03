import 'package:model_interfaces/model_interfaces.dart';

import '../quickstart.dart';

extension QuickMultilingualStringExtension on MultilingualString {
  String? quickTr() {
    final lang = QuickStart.delegate.settingsNotifier.lang;
    return this[lang];
  }
}
