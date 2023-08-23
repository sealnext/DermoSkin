// import 'dart:async';

import 'package:dermo/logic/data_objects/value_objects/email.dart';
import 'package:dermo/logic/data_objects/value_objects/password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:dermo/core/utility/types.dart';

class AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final StreamController<Id?> _authStateController = StreamController<Id?>.broadcast();
  //
  // AuthDataSource() {
  //   // redirect firebase authStateChanges() stream
  //   _auth.authStateChanges().listen((User? user) {
  //     _authStateController.add(user?.uid);
  //   });
  // }
  //
  // Stream<Id?> get onAuthStateChanged => _authStateController.stream;

  Future<Id> signUpWithEmailAndPassword({
    required Email email,
    required Password password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      if (credential.user == null) {
        throw Exception('The user is null after sign up.');
      }

      return credential.user!.uid;
    } catch (error) {
      throw Exception('Sign up failed: $error');
    }
  }

  Future<Id> signInWithEmailAndPassword({
    required Email email,
    required Password password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      if (credential.user == null) {
        throw Exception('The user is null after sign in.');
      }

      return credential.user!.uid;
    } catch (error) {
      throw Exception('Sign in failed: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }

  bool isUserSignedIn() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }
    return true;
  }
}
