import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../delegate.dart';
import '../widgets/toast/listener.dart';

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
