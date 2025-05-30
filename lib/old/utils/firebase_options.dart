// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCV30IQKXHDlHrb84V-VYsG1-3upiynlW0',
    appId: '1:497839570079:web:f40cafeae7c9d225f1b6aa',
    messagingSenderId: '497839570079',
    projectId: 'dermoskin-2db4e',
    authDomain: 'dermoskin-2db4e.firebaseapp.com',
    storageBucket: 'dermoskin-2db4e.appspot.com',
    measurementId: 'G-KQT8L9H3WZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBT-suFTyi4qm1OCIiTND4TTsoxRwdYiSI',
    appId: '1:497839570079:android:83476e4646febf2bf1b6aa',
    messagingSenderId: '497839570079',
    projectId: 'dermoskin-2db4e',
    storageBucket: 'dermoskin-2db4e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAytl5OksvkVySN92KGicuJBf4zUuSlEZs',
    appId: '1:497839570079:ios:c7a34b9ca30ce0fbf1b6aa',
    messagingSenderId: '497839570079',
    projectId: 'dermoskin-2db4e',
    storageBucket: 'dermoskin-2db4e.appspot.com',
    iosClientId:
        '497839570079-5oaah4f5119fmj3q04lmvp6i8gq7v6vm.apps.googleusercontent.com',
    iosBundleId: 'com.example.dermo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAytl5OksvkVySN92KGicuJBf4zUuSlEZs',
    appId: '1:497839570079:ios:7b3d124bba14a444f1b6aa',
    messagingSenderId: '497839570079',
    projectId: 'dermoskin-2db4e',
    storageBucket: 'dermoskin-2db4e.appspot.com',
    iosClientId:
        '497839570079-7h845e99scqej0lhph1ut17u3tkc6rpu.apps.googleusercontent.com',
    iosBundleId: 'com.example.dermo.RunnerTests',
  );
}
