import 'package:flutter/material.dart';

import 'glow.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlowWidget.defaultSizeIconButton(
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.delete_forever),
      ),
    );
  }
}
