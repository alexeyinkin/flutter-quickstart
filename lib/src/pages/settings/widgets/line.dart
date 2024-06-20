import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class SettingsLineWidget extends StatelessWidget {
  final Widget child;
  final String textKey;

  const SettingsLineWidget({
    required this.child,
    required this.textKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            tr('settings.$textKey') + ':',
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
