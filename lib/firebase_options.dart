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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBW35i7xpTR-jA-N-HyWmlU4DPuUeulMdc',
    appId: '1:103357185550:web:4286d97aa49212c7bec65f',
    messagingSenderId: '103357185550',
    projectId: 'naturebeatz-af459',
    authDomain: 'naturebeatz-af459.firebaseapp.com',
    storageBucket: 'naturebeatz-af459.appspot.com',
    measurementId: 'G-DFK3EZT2W5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnhGR8eFD7WNSwQUxSQQwyOFPMgY_Fabc',
    appId: '1:103357185550:android:bdeaba91f859dde3bec65f',
    messagingSenderId: '103357185550',
    projectId: 'naturebeatz-af459',
    storageBucket: 'naturebeatz-af459.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQchHB0wfh4F6xjx2PdRlmfG3B4rbMlqA',
    appId: '1:103357185550:ios:13ff5f0646a0fbd1bec65f',
    messagingSenderId: '103357185550',
    projectId: 'naturebeatz-af459',
    storageBucket: 'naturebeatz-af459.appspot.com',
    iosClientId: '103357185550-g3j40gpe9qp9vpbic9t9pt00mosft0hq.apps.googleusercontent.com',
    iosBundleId: 'com.example.groceryApp',
  );
}