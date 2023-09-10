import 'package:dermo/features/user/user_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_logic.g.dart';

enum AuthStatus { initial, loading, unauthenticated, authenticated }

@riverpod
class Auth extends _$Auth {
  @override
  AuthStatus build() {
    return AuthStatus.initial;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = AuthStatus.loading;
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('The user is null after sign up.');
      }
    } catch (error) {
      state = AuthStatus.unauthenticated;
      throw Exception('Sign up failed: $error');
    }
    final user = MyUser(firstName: firstName, lastName: lastName, email: email, avatar: '');
    ref.read(dbUserProvider.notifier).createUser(user);
    state = AuthStatus.authenticated;
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = AuthStatus.loading;
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('The user is null after sign in.');
      }
    } catch (error) {
      state = AuthStatus.unauthenticated;
      throw Exception('Sign in failed: $error');
    }
    state = AuthStatus.authenticated;
  }

  Future<void> continueWithGoogle() async {
    state = AuthStatus.loading;
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        state = AuthStatus.initial;
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
      if (credential.user == null) {
        state = AuthStatus.unauthenticated;
        throw Exception('The user is null after sign in.');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception("Authentication with Google failed: $e");
    }
    state = AuthStatus.authenticated;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}
