import 'package:flutter/material.dart';

import '../../notifiers/slug_editing_controller.dart';
import '../../quickstart.dart';

class SlugTextField extends StatelessWidget {
  final SlugEditingController controller;

  const SlugTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: QuickStart.delegate.addSpacing([
        Expanded(
          child: TextField(controller: controller.textEditingController),
        ),
        ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            return ToggleButtons(
              isSelected: [controller.isLocked],
              children: const [Icon(Icons.link)],
              onPressed: (_) => controller.isLocked = !controller.isLocked,
            );
          },
        ),
      ]),
    );
  }
}
