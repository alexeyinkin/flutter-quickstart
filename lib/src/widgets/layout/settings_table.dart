import 'package:flutter/widgets.dart';

import '../../notifiers/validator.dart';
import '../../quickstart.dart';
import 'settings_line.dart';

class SettingsTableWidget extends StatelessWidget {
  final Map<String, Widget> children;
  final String? keyPrefix;
  final QuickValidator? validator;

  const SettingsTableWidget({
    required this.children,
    this.keyPrefix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: QuickStart.delegate.addSpacing([
        for (final entry in children.entries)
          SettingsLineWidget(
            keyPrefix: keyPrefix,
            textKey: entry.key,
            validator: validator,
            child: entry.value,
          ),
      ]),
    );
  }
}
