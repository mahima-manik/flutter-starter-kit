// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDNV3kxVLv6Nm8_vvUCsX1qwTIV553s84o',
    appId: '1:884793105277:web:1baf74659f9a219ac48a14',
    messagingSenderId: '884793105277',
    projectId: 'flutter-starter-kit-d6a83',
    authDomain: 'flutter-starter-kit-d6a83.firebaseapp.com',
    storageBucket: 'flutter-starter-kit-d6a83.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFJK3SFhf0UI0NUuA3_Gc9QM8HOpQcNfQ',
    appId: '1:884793105277:android:b96156c1a80bbdffc48a14',
    messagingSenderId: '884793105277',
    projectId: 'flutter-starter-kit-d6a83',
    storageBucket: 'flutter-starter-kit-d6a83.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoHkGdo4fgSYj_4LN_r7B2TeMX_yba6JU',
    appId: '1:884793105277:ios:1e76164ebfebb7fec48a14',
    messagingSenderId: '884793105277',
    projectId: 'flutter-starter-kit-d6a83',
    storageBucket: 'flutter-starter-kit-d6a83.appspot.com',
    iosBundleId: 'com.example.flutterStarterKit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCoHkGdo4fgSYj_4LN_r7B2TeMX_yba6JU',
    appId: '1:884793105277:ios:1e76164ebfebb7fec48a14',
    messagingSenderId: '884793105277',
    projectId: 'flutter-starter-kit-d6a83',
    storageBucket: 'flutter-starter-kit-d6a83.appspot.com',
    iosBundleId: 'com.example.flutterStarterKit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDNV3kxVLv6Nm8_vvUCsX1qwTIV553s84o',
    appId: '1:884793105277:web:d0acbd40aeea48e7c48a14',
    messagingSenderId: '884793105277',
    projectId: 'flutter-starter-kit-d6a83',
    authDomain: 'flutter-starter-kit-d6a83.firebaseapp.com',
    storageBucket: 'flutter-starter-kit-d6a83.appspot.com',
  );
}