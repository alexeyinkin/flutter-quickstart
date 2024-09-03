import 'dart:ui';

extension QuickStartLocaleIterableExtension on Iterable<Locale> {
  Iterable<String> get languageCodes => map((locale) => locale.languageCode);
}
