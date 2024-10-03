import 'package:flutter/material.dart';

class SmallCircularProgressIndicator extends StatelessWidget {
  final double size;
  final double? value;

  const SmallCircularProgressIndicator({
    this.size = 30,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: value == null
            ? const CircularProgressIndicator()
            : CircularProgressIndicator(
                value: value,
              ),
      ),
    );
  }
}
