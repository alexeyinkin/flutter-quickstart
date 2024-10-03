import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../delegate.dart';
import '../pages/tabs/screen.dart';
import '../quickstart.dart';
import '../widgets/toast/listener.dart';

final routerDelegate = QuickRouterDelegate(
  QuickStart.delegate,
  QuickTabsScreen(delegate: QuickStart.delegate),
);

class QuickRouterDelegate extends MaterialPageStacksRouterDelegate {
  final QuickDelegate delegate;

  QuickRouterDelegate(
    this.delegate,
    Widget widget,
  ) : super(
          delegate.pageStacks,
          child: widget,
        );

  @override
  Widget build(BuildContext context) {
    return SingleEntryOverlay(
      child: ToastListenerWidget(
        delegate: delegate,
        child: super.build(context),
      ),
    );
  }
}
