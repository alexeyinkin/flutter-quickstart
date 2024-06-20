import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

enum FontSizeEnum {
  s(20),
  m(30),
  l(40),
  xl(50);

  const FontSizeEnum(this.size);

  final double size;
}

// TODO(alexeyinkin): Make a macro to generate 'copyWith' and 'lerp'.
class QuickThemeExtension extends ThemeExtension<QuickThemeExtension> {
  const QuickThemeExtension({
    required this.circleAvatarBackgroundColor,
    required this.cardTitle,
    required this.h1,
    required this.h2,
    required this.headerColor,
    required this.menuItem,
    required this.nestingColor,
    required this.normal,
    required this.onHeaderColor,
    required this.tabStyle,
  });

  final Color circleAvatarBackgroundColor;
  final TextStyle cardTitle;
  final TextStyle h1;
  final TextStyle h2;
  final Color headerColor;
  final TextStyle menuItem;
  final Color nestingColor;
  final TextStyle normal;
  final Color onHeaderColor;
  final TextStyle tabStyle;

  @override
  QuickThemeExtension copyWith({
    Color? circleAvatarBackgroundColor,
    TextStyle? cardTitle,
    TextStyle? h1,
    TextStyle? h2,
    Color? headerColor,
    TextStyle? menuItem,
    Color? nestingColor,
    TextStyle? normal,
    Color? onHeaderColor,
    TextStyle? tabStyle,
  }) {
    return QuickThemeExtension(
      circleAvatarBackgroundColor:
          circleAvatarBackgroundColor ?? this.circleAvatarBackgroundColor,
      cardTitle: cardTitle ?? this.cardTitle,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      headerColor: headerColor ?? this.headerColor,
      menuItem: menuItem ?? this.menuItem,
      nestingColor: nestingColor ?? this.nestingColor,
      normal: normal ?? this.normal,
      onHeaderColor: onHeaderColor ?? this.onHeaderColor,
      tabStyle: tabStyle ?? this.tabStyle,
    );
  }

  @override
  QuickThemeExtension lerp(
    ThemeExtension<QuickThemeExtension>? other,
    double t,
  ) {
    if (other is! QuickThemeExtension) {
      return this;
    }
    return QuickThemeExtension(
      circleAvatarBackgroundColor: Color.lerp(
            circleAvatarBackgroundColor,
            other.circleAvatarBackgroundColor,
            t,
          ) ??
          circleAvatarBackgroundColor,
      cardTitle: TextStyle.lerp(cardTitle, other.cardTitle, t) ?? cardTitle,
      h1: TextStyle.lerp(h1, other.h1, t) ?? h1,
      h2: TextStyle.lerp(h2, other.h2, t) ?? h2,
      headerColor: Color.lerp(headerColor, other.headerColor, t) ?? headerColor,
      menuItem: TextStyle.lerp(menuItem, other.menuItem, t) ?? menuItem,
      nestingColor:
          Color.lerp(nestingColor, other.nestingColor, t) ?? nestingColor,
      normal: TextStyle.lerp(normal, other.normal, t) ?? normal,
      onHeaderColor:
          Color.lerp(onHeaderColor, other.onHeaderColor, t) ?? onHeaderColor,
      tabStyle: TextStyle.lerp(tabStyle, other.tabStyle, t) ?? tabStyle,
    );
  }

  static final instance = QuickThemeExtension(
    circleAvatarBackgroundColor: Colors.transparent,
    cardTitle: GoogleFonts.firaSansExtraCondensed(
      textStyle: TextStyle(
        // TODO(alexeyinkin): Enum with font sizes, https://github.com/alexeyinkin/senior-dev/issues/113
        fontSize: FontSizeEnum.s.size,
        fontWeight: FontWeight.bold,
      ),
    ),
    h1: GoogleFonts.firaSansExtraCondensed(
      textStyle: TextStyle(
        color: QuickColors.colorWhite,
        fontSize: FontSizeEnum.xl.size,
        fontWeight: FontWeight.bold,
      ),
    ),
    h2: GoogleFonts.firaSansExtraCondensed(
      textStyle: TextStyle(
        fontSize: FontSizeEnum.m.size,
        fontWeight: FontWeight.bold,
      ),
    ),
    headerColor: QuickColors.colorBlack,
    menuItem: GoogleFonts.firaSansExtraCondensed(
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: FontSizeEnum.s.size,
        fontWeight: FontWeight.bold,
      ),
    ),
    nestingColor: QuickColors.nestingColor,
    normal: GoogleFonts.firaSansExtraCondensed(
      textStyle: const TextStyle(),
    ),
    onHeaderColor: QuickColors.colorBlack,
    tabStyle: GoogleFonts.firaSansExtraCondensed(
      color: QuickColors.colorBlack,
      fontSize: FontSizeEnum.s.size,
      fontWeight: FontWeight.bold,
    ),
  );
}
