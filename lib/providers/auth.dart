// User authentication provider will be added here

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  bool _isUserAuth = false;

  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        _isUserAuth = false;
      } else {
        _isUserAuth = true;
      }
      notifyListeners();
    });
  }

  Future<User> googleSignIn() async {
    GoogleSignIn googleSignIn = new GoogleSignIn();

    GoogleSignInAccount googleSignInAccount;
    try {
      googleSignInAccount = await googleSignIn.signIn();
    } catch (e, s) {
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'GOOGLE SIGN IN ERROR');
      return null;
    }

    if (googleSignInAccount == null) {
      // if user closes the sign in screen
      return null;
    }

    try {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;

      final auth = FirebaseAuth.instance;

      if (!(!user.isAnonymous &&
          await user.getIdToken() != null &&
          user.uid == auth.currentUser.uid)) {
        auth.signOut();
        return null;
      }
      return user;
    } catch (e, s) {
      await FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'AUTHENTICATION FAILED');
      throw Error();
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  bool get isUserAuth {
    return _isUserAuth;
  }
}
