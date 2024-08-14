import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../delegate.dart';
import '../clickable.dart';

const _scrollTopDuration = Duration(milliseconds: 500);

class LogoClickableWrapper extends StatelessWidget {
  final Widget child;
  final QuickDelegate delegate;

  const LogoClickableWrapper({
    required this.child,
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = PrimaryScrollController.of(context);

    return ClickableWidget(
      onTap: () {
        if (_scrollToTopIfCan(controller)) {
          return;
        }
        delegate.goHome();
      },
      child: child,
    );
  }
}

bool _scrollToTopIfCan(ScrollController controller) {
  if (!controller.hasClients) return false;
  if (controller.offset == 0) return false;

  unawaited(
    controller.animateTo(
      0,
      duration: _scrollTopDuration,
      curve: Curves.linearToEaseOut,
    ),
  );

  return true;
}
