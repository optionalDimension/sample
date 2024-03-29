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
    apiKey: 'AIzaSyA50Equ6T-tNdz1P0lIxKqiPcbsp8L8icQ',
    appId: '1:430671934317:web:975be05d77445f37a4e064',
    messagingSenderId: '430671934317',
    projectId: 'amal-55afa',
    authDomain: 'amal-55afa.firebaseapp.com',
    storageBucket: 'amal-55afa.appspot.com',
    measurementId: 'G-Z0DTYPMQVX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAm87sUihEhyUQZfvbFxGdOVF_Bi-R-1RI',
    appId: '1:430671934317:android:d05f7e9235e9da66a4e064',
    messagingSenderId: '430671934317',
    projectId: 'amal-55afa',
    storageBucket: 'amal-55afa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFasz1kd7oioD2XkwL52PElIKPfVJ164k',
    appId: '1:430671934317:ios:7332232116d62b4ca4e064',
    messagingSenderId: '430671934317',
    projectId: 'amal-55afa',
    storageBucket: 'amal-55afa.appspot.com',
    iosBundleId: 'com.example.sample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFasz1kd7oioD2XkwL52PElIKPfVJ164k',
    appId: '1:430671934317:ios:16e8b29e2e92b5a4a4e064',
    messagingSenderId: '430671934317',
    projectId: 'amal-55afa',
    storageBucket: 'amal-55afa.appspot.com',
    iosBundleId: 'com.example.sample.RunnerTests',
  );
}
