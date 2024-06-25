import 'package:flutter/material.dart';

import '../../quickstart.dart';
import 'sign_in_button.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget();

  @override
  Widget build(BuildContext context) {
    final delegate = QuickStart.delegate;

    return Column(
      children: delegate.addSpacing([
        for (final provider in delegate.authProviders) SignInButton(provider),
      ]),
    );
  }
}
