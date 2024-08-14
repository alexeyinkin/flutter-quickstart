import 'dart:math' as math;

import 'package:flutter/material.dart';

class ExpandCollapseButton extends StatelessWidget {
  final bool isExpanded;
  final ValueSetter<bool> setExpanded;

  const ExpandCollapseButton({
    required this.isExpanded,
    required this.setExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Transform.rotate(
        angle: isExpanded ? math.pi / 2 : 0,
        child: const Icon(Icons.chevron_right),
      ),
      onPressed: () {
        setExpanded(!isExpanded);
      },
    );
  }
}
