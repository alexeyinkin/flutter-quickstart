import 'package:flutter/material.dart';
import 'package:model_editors/model_editors.dart';

import '../../notifiers/multilingual_text_editing_controller.dart';
import '../../util/iterable.dart';

class MultilingualTextField extends StatelessWidget
    implements ControllerWidget {
  @override
  final MultilingualTextEditingController controller;

  const MultilingualTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final entry in controller.controllers.entries)
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(entry.key),
              ),
              Expanded(
                child: TextField(
                  controller: entry.value,
                ),
              ),
            ],
          ),
      ].intersperse(const SizedBox(height: 2)).toList(growable: false),
    );
  }
}
