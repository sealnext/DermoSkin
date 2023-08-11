import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class AuthServices {
  //Google auth sign in

  static signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sign in with apple
  static signInWhithApple() async {
    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      final appleProvider = AppleAuthProvider();
      return await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }
  }
}
