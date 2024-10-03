import 'package:flutter/painting.dart';

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
}
