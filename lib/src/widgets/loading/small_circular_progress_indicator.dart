import 'package:flutter/material.dart';

class SmallCircularProgressIndicator extends StatelessWidget {
  final double size;

  const SmallCircularProgressIndicator({
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
