import 'package:flutter/widgets.dart';

import '../../delegate.dart';
import 'flag.dart';
import 'title.dart';

class LanguageLineWidget extends StatelessWidget {
  final QuickDelegate delegate;
  final Locale locale;

  const LanguageLineWidget({
    required this.delegate,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlagWidget(
          locale,
          size: FlagWidgetSize.list,
        ),
        delegate.spacing,
        LanguageTitleWidget(locale: locale),
      ],
    );
  }
}
