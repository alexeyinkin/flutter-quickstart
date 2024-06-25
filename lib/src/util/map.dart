import '../quickstart.dart';

extension QuickMapStringStringExtension<T> on Map<String, T> {
  T? quickTr() {
    final lang = QuickStart.delegate.settingsNotifier.lang;
    return this[lang];
  }
}
