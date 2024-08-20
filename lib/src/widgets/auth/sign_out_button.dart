import 'package:flutter/material.dart';

import '../../quickstart.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await QuickStart.delegate.authenticationNotifier.signOut();
      },
      icon: const Icon(Icons.logout),
    );
  }
}
