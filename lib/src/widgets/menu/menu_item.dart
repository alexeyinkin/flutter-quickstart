import 'package:flutter/material.dart';

import '../../delegate.dart';
import '../../theme/extension.dart';
import '../clickable.dart';

class MenuItemWidget<T extends Enum> extends StatelessWidget {
  const MenuItemWidget({
    required this.delegate,
    required this.tab,
    required this.title,
    this.trailing,
  });

  final QuickDelegate<T> delegate;
  final String title;
  final T tab;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<QuickThemeExtension>()!;

    return StreamBuilder(
      stream: delegate.pageStacks.events,
      builder: (context, snapshot) {
        return ClickableWidget(
          onTap: _onTap,
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: ext.menuItem),
                  if (trailing != null) ...[delegate.spacing, trailing!],
                ],
              ),
              if (_isSelected())
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: ColoredBox(
                    color: ext.menuItem.color!,
                    child: const SizedBox(height: 4),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  bool _isSelected() {
    return delegate.pageStacks.currentStackKey == tab.name;
  }

  void _onTap() {
    final pageStacks = delegate.pageStacks;
    final key = tab.name;

    if (pageStacks.currentStackKey == key) {
      pageStacks.currentStack?.popUntilBottom();
    } else {
      pageStacks.setCurrentStackKey(key);
    }
  }
}
