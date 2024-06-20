import 'package:flutter/widgets.dart';

class QuickPadding extends StatelessWidget {
  final Widget child;

  const QuickPadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
