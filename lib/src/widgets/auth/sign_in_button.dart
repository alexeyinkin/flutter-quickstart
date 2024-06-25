import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../notifiers/authentication.dart';

class SignInButton extends StatelessWidget {
  final String providerId;

  const SignInButton(this.providerId);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await authenticationNotifier.signIn(providerId);
      },
      child: SelectionContainer.disabled(
        child: Text(
          'auth.signInWith'.tr(
            namedArgs: {
              'provider': providerId,
            },
          ),
        ),
      ),
    );
  }
}
