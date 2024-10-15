import 'package:flutter/material.dart';

class UserpicWidget extends StatelessWidget {
  final double size;
  final String? src;

  const UserpicWidget(
    this.src, {
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: src == null
          ? Icon(Icons.person, size: size)
          : Image.network(src!, width: size, height: size),
    );
  }
}
