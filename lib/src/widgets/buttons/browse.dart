import 'package:flutter/material.dart';

import 'glow.dart';

class BrowseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BrowseButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlowWidget.defaultSizeIconButton(
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.file_open),
      ),
    );
  }
}
