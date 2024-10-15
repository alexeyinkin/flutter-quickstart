import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'userpic.dart';

class FirebaseUserpicWidget extends StatelessWidget {
  final double size;
  final User user;

  const FirebaseUserpicWidget(
    this.user, {
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UserpicWidget(
      user.photoURL,
      size: size,
    );
  }
}
