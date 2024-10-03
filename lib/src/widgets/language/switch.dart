import 'package:flutter/material.dart';

import '../../delegate.dart';
import 'flag.dart';
import 'line.dart';

class LanguageSwitchWidget extends StatelessWidget {
  final QuickDelegate delegate;
  final bool showText;

  const LanguageSwitchWidget({
    required this.delegate,
    required this.showText,
  });

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = delegate.settingsNotifier;

    return AnimatedBuilder(
      animation: settingsNotifier,
      builder: (context, _) {
        return DropdownButton<Locale>(
          icon: const SizedBox(),
          items: [
            for (final locale in settingsNotifier.locales)
              DropdownMenuItem(
                value: locale,
                child: LanguageLineWidget(
                  delegate: delegate,
                  locale: locale,
                ),
              ),
          ],
          onChanged: (locale) async {
            await Future.wait([
              settingsNotifier.setLocale(locale!),
            ]);
          },
          selectedItemBuilder: (context) => [
            for (final locale in settingsNotifier.locales)
              FlagWidget(
                locale,
                size: FlagWidgetSize.button,
              ),
          ],
          underline: const SizedBox(),
          value: settingsNotifier.locale,
        );
      },
    );
  }
}
