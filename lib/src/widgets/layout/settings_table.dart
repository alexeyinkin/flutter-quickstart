import 'package:flutter/widgets.dart';

import '../../pages/settings/widgets/line.dart';
import '../../quickstart.dart';
import '../../util/iterable.dart';

class SettingsTableWidget extends StatelessWidget {
  final Map<String, Widget> children;
  final String? keyPrefix;

  const SettingsTableWidget({
    required this.children,
    this.keyPrefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final entry in children.entries)
          SettingsLineWidget(
            textKey: entry.key,
            keyPrefix: keyPrefix,
            child: entry.value,
          ),
      ].intersperse(QuickStart.delegate.spacing).toList(growable: false),
    );
  }
}
