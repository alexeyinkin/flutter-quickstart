import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/locales.dart';

abstract final class _Keys {
  static const locale = 'locale';
}

const quickLocales = [
  Locales.en_GB,
  Locales.zh_CN,
  Locales.hi_IN,
  Locales.es_ES,
  Locales.fr_FR,
  Locales.pt_PT,
  Locales.ru_RU,
];

class SettingsNotifier extends ChangeNotifier {
  SettingsNotifier({
    this.locales = quickLocales,
  }) : _locale = locales.first;

  final List<Locale> locales;

  Locale _locale;

  Locale get locale => _locale;

  String get lang => locale.languageCode;

  Future<void> setLocale(Locale newValue) async {
    if (!locales.contains(newValue)) {
      throw Exception('Non-whitelisted locale: $newValue');
    }

    _locale = newValue;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_Keys.locale, newValue.toString());
  }

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    _loadLocale(prefs);
  }

  void _loadLocale(SharedPreferences prefs) {
    final saved = prefs.getString(_Keys.locale);
    final locale = locales.firstWhereOrNull((l) => l.toString() == saved);

    if (locale != null) {
      _locale = locale;
    } else {
      final locale = locales.first;
      // ignore: avoid_print
      print('Lang not found: $saved, falling back to $locale.');
      _locale = locale;
    }

    notifyListeners();
  }
}
