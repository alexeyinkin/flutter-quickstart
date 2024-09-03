import 'package:flutter/material.dart';

import '../../constants/sizes.dart';
import '../../widgets/layout/scaffold.dart';
import 'state.dart' as s;
import 'widgets/content.dart';

class QuickSettingsScreen extends StatelessWidget {
  final s.QuickSettingsNotifier notifier;

  const QuickSettingsScreen(this.notifier);

  @override
  Widget build(BuildContext context) {
    return const QuickScaffold(
      maxWidth: QuickSizes.maxTextPageWidth,
      bodySize: BodySize.infinite,
      body: QuickSettingsContent(),
    );
  }
}
