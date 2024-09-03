import 'package:flutter/widgets.dart';
import 'package:model_interfaces/model_interfaces.dart';

class MultilingualTextEditingController
    extends ValueNotifier<MultilingualString> {
  final Map<String, TextEditingController> controllers;

  MultilingualTextEditingController({
    required Iterable<String> languageCodes,
  })  : controllers = {
          for (final lang in languageCodes) lang: TextEditingController(),
        },
        super(MultilingualString());

  @override
  MultilingualString get value => MultilingualString({
        for (final entry in controllers.entries) entry.key: entry.value.text,
      });

  @override
  set value(MultilingualString newValue) {
    for (final entry in controllers.entries) {
      final lang = entry.key;
      entry.value.text = newValue[lang] ?? '';
    }

    notifyListeners();
  }
}
