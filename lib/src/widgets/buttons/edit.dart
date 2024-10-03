import 'package:flutter/material.dart';

import 'glow.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlowWidget.defaultSizeIconButton(
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
