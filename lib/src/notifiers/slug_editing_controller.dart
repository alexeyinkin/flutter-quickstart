import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../constants/locales.dart';
import '../util/string.dart';
import 'multilingual_text_editing_controller.dart';

final _langPriorities = [Locales.en_US.languageCode];

class SlugEditingController extends ChangeNotifier {
  final textEditingController = TextEditingController();
  MultilingualTextEditingController? _titlesController;
  bool _isLocked = false;

  SlugEditingController() {
    textEditingController.addListener(_onSlugChanged);
  }

  MultilingualTextEditingController? get titlesController => _titlesController;

  set titlesController(MultilingualTextEditingController? newValue) {
    _titlesController?.removeListener(_onTitlesChanged);
    _titlesController = newValue;
    newValue?.addListener(_onTitlesChanged);
    notifyListeners();
  }

  void transliterate() {
    _isLocked = true;
    textEditingController.text = _generateSlug(); // Notifies listeners.
  }

  bool get isLocked => _isLocked;

  set isLocked(bool newValue) {
    if (newValue == _isLocked) {
      return;
    }

    if (newValue) {
      transliterate();
      return;
    }

    _isLocked = false;
    notifyListeners();
  }

  String get text => textEditingController.text;

  set text(String newValue) {
    textEditingController.text = newValue;
  }

  void _onTitlesChanged() {
    if (_isLocked) {
      final transliterated = _generateSlug();
      if (transliterated != textEditingController.text) {
        textEditingController.text = transliterated;
      }
    }
  }

  String _generateSlug() {
    final titles = _titlesController?.value;
    final title = titles?.getFirstNonEmpty(_langPriorities) ??
        titles?.values.firstWhereOrNull((s) => s != '') ??
        '';

    return title.transliterateToSlug();
  }

  void lockIfMatches() {
    final transliterated = _generateSlug();
    if (transliterated == textEditingController.text) {
      _isLocked = true;
    }
  }

  void _onSlugChanged() {
    final transliterated = _generateSlug();
    if (textEditingController.text != transliterated) {
      _isLocked = false;
    }

    notifyListeners();
  }
}
