import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final ValueSetter<bool> callback;

  /// The dialog title.
  final String title;

  const ConfirmDialog({
    super.key,
    required this.callback,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            callback(false);
          },
          child: const Text('common.no').tr(),
        ),
        ElevatedButton(
          onPressed: () => callback(true),
          child: const Text('common.yes').tr(),
        ),
      ],
    );
  }
}
