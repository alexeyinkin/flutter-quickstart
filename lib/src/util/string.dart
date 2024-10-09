import 'package:diacritic/diacritic.dart';
import 'package:flutter/painting.dart';

const Map<String, String> _russianToEnglishMap = {
  //
  'А': 'A', 'а': 'a',
  'Б': 'B', 'б': 'b',
  'В': 'V', 'в': 'v',
  'Г': 'G', 'г': 'g',
  'Д': 'D', 'д': 'd',
  'Е': 'E', 'е': 'e',
  'Ё': 'Yo', 'ё': 'yo',
  'Ж': 'Zh', 'ж': 'zh',
  'З': 'Z', 'з': 'z',
  'И': 'I', 'и': 'i',
  'Й': 'Y', 'й': 'y',
  'К': 'K', 'к': 'k',
  'Л': 'L', 'л': 'l',
  'М': 'M', 'м': 'm',
  'Н': 'N', 'н': 'n',
  'О': 'O', 'о': 'o',
  'П': 'P', 'п': 'p',
  'Р': 'R', 'р': 'r',
  'С': 'S', 'с': 's',
  'Т': 'T', 'т': 't',
  'У': 'U', 'у': 'u',
  'Ф': 'F', 'ф': 'f',
  'Х': 'Kh', 'х': 'kh',
  'Ц': 'Ts', 'ц': 'ts',
  'Ч': 'Ch', 'ч': 'ch',
  'Ш': 'Sh', 'ш': 'sh',
  'Щ': 'Sch', 'щ': 'sch',
  'Ъ': '', 'ъ': '',
  'Ы': 'Y', 'ы': 'y',
  'Ь': '', 'ь': '',
  'Э': 'E', 'э': 'e',
  'Ю': 'Yu', 'ю': 'yu',
  'Я': 'Ya', 'я': 'ya',
};

extension QuickStartStringExtension on String {
  /// Returns a random color using this String as the seed.
  Color toPseudoRandomColor() {
    int hash = 0;

    for (int i = 0; i < length; i++) {
      hash = codeUnitAt(i) + ((hash << 5) - hash);
      hash = hash & 0xFFFFFFFF; // Ensure hash stays within 32 bits.
    }

    final hue = (hash % 360).toDouble();
    final hslColor = HSLColor.fromAHSL(1.0, hue, 0.6, 0.5);
    return hslColor.toColor();
  }

  String transliterate() {
    return splitMapJoin('', onNonMatch: _transliterateCharacter);
  }

  String transliterateToSlug() {
    return transliterate()
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }
}

String _transliterateCharacter(String char) {
  return _russianToEnglishMap[char] ?? removeDiacritics(char);
}
