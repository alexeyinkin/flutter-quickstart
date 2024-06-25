import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../quickstart.dart';
import 'firebase_userpic.dart';

class FirebaseUserWidget extends StatelessWidget {
  final User user;

  const FirebaseUserWidget(
    this.user, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final text = user.email ?? user.displayName;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: QuickStart.delegate.addSpacing([
        FirebaseUserpicWidget(user, size: 32),
        if (text != null) Text(text),
      ]),
    );
  }
}
