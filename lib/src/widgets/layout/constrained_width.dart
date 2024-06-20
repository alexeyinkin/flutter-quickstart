import 'package:flutter/widgets.dart';

class ConstrainedWidthWidget extends StatelessWidget {
  const ConstrainedWidthWidget({
    required this.child,
    required this.maxWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        ),
      ],
    );
  }
}
