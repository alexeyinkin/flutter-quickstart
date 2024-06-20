import 'package:flutter/widgets.dart';

import '../../../delegate.dart';
import '../../../util/iterable.dart';
import 'line.dart';

class SettingsTableWidget extends StatelessWidget {
  final Map<String, Widget> children;
  final QuickDelegate delegate;

  const SettingsTableWidget({
    required this.children,
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final entry in children.entries)
          SettingsLineWidget(
            textKey: entry.key,
            child: entry.value,
          ),
      ].intersperse(delegate.spacing).toList(growable: false),
    );
  }
}
