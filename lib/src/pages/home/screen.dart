import 'package:flutter/material.dart';

import '../../util/build_context.dart';
import '../../widgets/layout/scaffold.dart';
import 'state.dart';

class QuickHomeScreen extends StatelessWidget {
  final QuickHomeNotifier notifier;

  const QuickHomeScreen(this.notifier);

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobileScreen();

    return QuickScaffold(
      bodySize: BodySize.finite,
      body: isMobile ? const NarrowHomeWidget() : const WideHomeWidget(),
      padding: !isMobile,
    );
  }
}

class NarrowHomeWidget extends StatelessWidget {
  const NarrowHomeWidget();

  @override
  Widget build(BuildContext context) {
    return const Text('NarrowHomeWidget');
  }
}

class WideHomeWidget extends StatelessWidget {
  const WideHomeWidget();

  @override
  Widget build(BuildContext context) {
    return const Text('WideHomeWidget');
  }
}
