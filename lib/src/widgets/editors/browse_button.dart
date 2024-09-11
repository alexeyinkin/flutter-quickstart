import 'package:flutter/material.dart';

class BrowseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BrowseButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.search),
    );
  }
}
