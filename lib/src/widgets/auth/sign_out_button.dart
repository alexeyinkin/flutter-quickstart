import 'package:flutter/material.dart';

import '../../notifiers/authentication.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await authenticationNotifier.signOut();
      },
      icon: const Icon(Icons.logout),
    );
  }
}
