import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'extension.dart';

final quickThemeData = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: QuickColors.primaryColor,
    secondary: QuickColors.primaryColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.zero,
    fillColor: QuickColors.nestingColor,
    filled: true,
    isDense: true,
    labelStyle: TextStyle(
      color: QuickColors.minorLabel,
      fontSize: 12,
    ),
  ),
  textTheme: GoogleFonts.firaSansExtraCondensedTextTheme(
    TextTheme(
      // Just text, TextField text
      bodyLarge: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),
      bodyMedium: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),
      bodySmall: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),

      // TODO(alexeyinkin): Find out what it affects.
      displayLarge: const TextStyle(
        fontSize: 40,
      ),
      displayMedium: const TextStyle(
        fontSize: 40,
      ),
      displaySmall: const TextStyle(
        fontSize: 40,
      ),

      // TODO(alexeyinkin): Find out what it affects.
      headlineLarge: const TextStyle(
        fontSize: 40,
      ),
      headlineMedium: const TextStyle(
        fontSize: 40,
      ),
      headlineSmall: const TextStyle(
        fontSize: 40,
      ),

      // Buttons
      labelLarge: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),
      labelMedium: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),
      labelSmall: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),

      titleLarge: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),
      titleMedium: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),
      titleSmall: TextStyle(
        fontSize: FontSizeEnum.s.size,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: QuickColors.colorBlack,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: QuickColors.colorBlack,
    selectedItemColor: QuickColors.primaryColor,
  ),
  extensions: <ThemeExtension<dynamic>>[
    QuickThemeExtension.instance,
  ],
  useMaterial3: true,
);

abstract class QuickColors {
  static const activeTagColor = Color(0x40000000);
  static const colorBlack = Color(0xFF000000);
  static const colorWhite = Color(0xFFFFFFFF);
  static const error = Color(0xFFC62828);
  static const minorLabel = Color(0x30000000);
  static const nestingColor = Color(0x10000000);
  static const notificationColor = Color(0xFFE0E0E0);
  static const paleColor = Color(0x40000000);
  static const primaryColor = Color(0xFFDF0000);
}
