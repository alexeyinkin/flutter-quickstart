import 'package:flutter/widgets.dart';

import '../../notifiers/authentication.dart';
import '../../quickstart.dart';

/// Calls [builder] every time the [AuthenticationNotifier] is updated.
class AuthenticationBuilder<U> extends StatelessWidget {
  final Widget Function(BuildContext context, U? user) builder;

  const AuthenticationBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final notifier =
        QuickStart.delegate.authenticationNotifier as AuthenticationNotifier<U>;

    return AnimatedBuilder(
      animation: notifier,
      builder: (context, child) {
        return builder(context, notifier.user);
      },
    );
  }
}
