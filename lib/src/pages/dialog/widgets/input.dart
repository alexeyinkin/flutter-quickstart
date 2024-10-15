import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  final ValueSetter<String?> callback;

  /// The dialog title.
  final String title;

  const InputDialog({
    super.key,
    required this.callback,
    required this.title,
  });

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        onSubmitted: (_) => _ok(),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.callback(null);
          },
          child: const Text('common.cancel').tr(),
        ),
        ElevatedButton(
          onPressed: _ok,
          child: const Text('common.ok').tr(),
        ),
      ],
    );
  }

  void _ok() {
    widget.callback(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
