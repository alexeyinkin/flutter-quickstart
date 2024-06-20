import 'package:flag/flag.dart';
import 'package:flutter/widgets.dart';

class FlagWidget extends StatelessWidget {
  final Locale locale;
  final FlagWidgetSize size;

  const FlagWidget(
    this.locale, {
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Flag.fromString(
      locale.countryCode ?? 'invalid',
      width: size.width,
      height: size.height,
    );
  }
}

enum FlagWidgetSize {
  button(30, 20),
  list(20, 12),
  ;

  final double width;
  final double height;

  const FlagWidgetSize(this.width, this.height);
}
