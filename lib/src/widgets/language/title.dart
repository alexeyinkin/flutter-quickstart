import 'package:flutter/widgets.dart';

class LanguageTitleWidget extends StatelessWidget {
  final Locale locale;

  const LanguageTitleWidget({
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Text(locale.languageCode.toUpperCase());
  }
}
