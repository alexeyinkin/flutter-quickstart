import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyed_collection_widgets/keyed_collection_widgets.dart';

import '../../delegate.dart';

class QuickBottomNavigationBar<T extends Enum> extends StatelessWidget {
  final QuickDelegate<T> delegate;

  const QuickBottomNavigationBar({
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return KeyedBottomNavigationBar<T>(
      currentItemKey: delegate.currentTab!,
      keyOrder: delegate.tabs,
      onTap: _onTabTap,
      items: {
        for (final tab in delegate.tabs)
          tab: BottomNavigationBarItem(
            icon: delegate.getTabIcon(tab),
            label: 'menu.${tab.name}'.tr(),
          ),
      },
    );
  }

  void _onTabTap(T tab) {
    final key = tab.name;
    final pageStacks = delegate.pageStacks;

    if (pageStacks.currentStackKey == key) {
      pageStacks.currentStack?.popUntilBottom();
    } else {
      pageStacks.setCurrentStackKey(key);
    }
  }
}
