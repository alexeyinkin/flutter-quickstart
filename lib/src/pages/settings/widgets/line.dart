import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class SettingsLineWidget extends StatelessWidget {
  final Widget child;
  final String? keyPrefix;
  final String textKey;

  const SettingsLineWidget({
    required this.child,
    required this.keyPrefix,
    required this.textKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              (keyPrefix == null ? textKey : tr('$keyPrefix.$textKey')) + ':',
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Align(alignment: Alignment.topLeft, child: child),
        ),
      ],
    );
  }
}
