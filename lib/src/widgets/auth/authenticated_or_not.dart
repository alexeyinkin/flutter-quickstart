import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../notifiers/authentication.dart';
import '../../quickstart.dart';
import '../loading/small_circular_progress_indicator.dart';
import 'sign_in.dart';

class AuthenticatedOrNotWidget extends StatelessWidget {
  final Widget Function(BuildContext context, User firebaseUser)
      authenticatedBuilder;
  final WidgetBuilder? notAuthenticatedBuilder;

  const AuthenticatedOrNotWidget({
    required this.authenticatedBuilder,
    super.key,
    this.notAuthenticatedBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final authenticationNotifier = QuickStart.delegate.authenticationNotifier;

    return ListenableBuilder(
      listenable: authenticationNotifier,
      builder: (context, _) {
        final user = FirebaseAuth.instance.currentUser;

        switch (authenticationNotifier.status) {
          case AuthenticationStatus.authenticated:
            if (user == null) return _loading();
            return authenticatedBuilder(context, user);

          case AuthenticationStatus.notAuthenticated:
          case AuthenticationStatus.authenticatedModelError:
            return notAuthenticatedBuilder?.call(context) ??
                const SignInWidget();

          case AuthenticationStatus.loadingFirebase:
          case AuthenticationStatus.authenticatedLoadingModel:
            return _loading();
        }
      },
    );
  }

  Widget _loading() => const SmallCircularProgressIndicator();
}
