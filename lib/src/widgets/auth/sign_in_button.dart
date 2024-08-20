import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../quickstart.dart';

class SignInButton extends StatelessWidget {
  final String providerId;

  const SignInButton(this.providerId);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await QuickStart.delegate.authenticationNotifier
              .signInWithProviderId(providerId);
        } catch (ex) {
          print(ex);
          rethrow;
        }
      },
      child: SelectionContainer.disabled(
        child: Text('auth.signInWith.${providerId.replaceAll('.', '_')}'.tr()),
      ),
    );
  }
}
