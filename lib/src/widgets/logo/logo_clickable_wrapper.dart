import 'package:flutter/widgets.dart';

import '../../delegate.dart';
import '../clickable.dart';

class LogoClickableWrapper extends StatelessWidget {
  final Widget child;
  final QuickDelegate delegate;

  const LogoClickableWrapper({
    required this.child,
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableWidget(
      onTap: delegate.goHome,
      child: child,
    );
  }
}
