import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/core/utils/widget_utils.dart';

class FirebaseAuthServices extends ChangeNotifier {
  final FirebaseAuth _auth;
  FirebaseAuthServices(this._auth);

  // bool userSignedIn = false;

  Future<void> registerWithEmailAndPassword(
      {required String displayName,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user?.updateDisplayName(displayName);
      // userSignedIn = true;
      // notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.message!, Colors.red);
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // userSignedIn = true;
      // notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.message!, Colors.red);
    }
  }

  Future<void> userSignout() async {
    await FirebaseAuth.instance.signOut();
  }
}
