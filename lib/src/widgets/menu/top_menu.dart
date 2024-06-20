import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../delegate.dart';
import '../../util/iterable.dart';
import '../language/switch.dart';
import 'menu_item.dart';
// import 'profile_menu_item_widget.dart';

class QuickTopMenuWidget<T extends Enum> extends StatelessWidget {
  const QuickTopMenuWidget({
    required this.delegate,
  });

  final QuickDelegate<T> delegate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (final tab in delegate.tabs)
          MenuItemWidget<T>(
            delegate: delegate,
            tab: tab,
            title: 'menu.${tab.name}'.tr(),
          ),
        if (delegate.settingsNotifier.locales.length > 1)
          LanguageSwitchWidget(
            delegate: delegate,
            showText: false,
          ),
        // const ProfileMenuItemWidget(),
      ].intersperse(const SizedBox(width: 40)).toList(growable: false),
    );
  }
}
