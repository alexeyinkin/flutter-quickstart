import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthenticationStatus {
  authenticated,
  authenticatedLoadingModel,
  authenticatedModelError,
  loadingFirebase,
  notAuthenticated,
}

final authenticationNotifier = AuthenticationNotifier();

class AuthenticationNotifier extends ChangeNotifier {
  AuthenticationStatus _status = AuthenticationStatus.loadingFirebase;

  AuthenticationNotifier() {
    FirebaseAuth.instance.userChanges().listen(_onFirebaseUserChange);
  }

  AuthenticationStatus get status => _status;

  Future<void> _onFirebaseUserChange(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthenticationStatus.notAuthenticated;
      notifyListeners();
    } else {
      _status = AuthenticationStatus.authenticated;
      notifyListeners();
      // TODO(alexeyinkin): Load model if configured.
    }
  }

  Future<void> signInWithProviderId(String providerId) async {
    if (providerId == AppleAuthProvider.PROVIDER_ID) {
      await signInWithProvider(AppleAuthProvider());
      return;
    }

    if (providerId == EmailAuthProvider.PROVIDER_ID) {
      await signInWithEmail();
      return;
    }

    if (providerId == FacebookAuthProvider.PROVIDER_ID) {
      await signInWithProvider(FacebookAuthProvider());
      return;
    }

    if (providerId == GameCenterAuthProvider.PROVIDER_ID) {
      await signInWithProvider(GameCenterAuthProvider());
      return;
    }

    if (providerId == GithubAuthProvider.PROVIDER_ID) {
      await signInWithProvider(GithubAuthProvider());
      return;
    }

    if (providerId == GoogleAuthProvider.PROVIDER_ID) {
      await signInWithGoogle();
      return;
    }

    if (providerId == MicrosoftAuthProvider.PROVIDER_ID) {
      await signInWithProvider(MicrosoftAuthProvider());
      return;
    }

    if (providerId == PlayGamesAuthProvider.PROVIDER_ID) {
      await signInWithProvider(PlayGamesAuthProvider());
      return;
    }

    if (providerId == TwitterAuthProvider.PROVIDER_ID) {
      await signInWithProvider(TwitterAuthProvider());
      return;
    }

    if (providerId == YahooAuthProvider.PROVIDER_ID) {
      await signInWithProvider(YahooAuthProvider());
      return;
    }
  }

  Future<void> signInWithEmail() async {
    throw UnimplementedError();
  }

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
      return;
    }

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInWithProvider(AuthProvider provider) async {
    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(provider);
    } else {
      await FirebaseAuth.instance.signInWithProvider(provider);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
