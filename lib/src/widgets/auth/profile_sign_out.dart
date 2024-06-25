import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../quickstart.dart';
import 'firebase_user.dart';
import 'sign_out_button.dart';

class ProfileSignOutWidget extends StatelessWidget {
  final User firebaseUser;

  const ProfileSignOutWidget({
    required this.firebaseUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: QuickStart.delegate.addSpacing([
        FirebaseUserWidget(firebaseUser),
        const SignOutButton(),
      ]),
    );
  }
}
