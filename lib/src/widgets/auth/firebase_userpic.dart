import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    final url = user.photoURL;

    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: url == null
          ? Icon(Icons.person, size: size)
          : Image.network(url, width: size, height: size),
    );
  }
}
