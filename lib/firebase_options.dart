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
    apiKey: 'AIzaSyDjbvdOIgdAIyXkqXE3LPL9nZH8QJl0Mgc',
    appId: '1:200866747654:web:55c314aea0cacdcbb83a87',
    messagingSenderId: '200866747654',
    projectId: 'billapp-bea2d',
    authDomain: 'billapp-bea2d.firebaseapp.com',
    storageBucket: 'billapp-bea2d.appspot.com',
    measurementId: 'G-K6Y2FZ8KJF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiIAaoKLfdqbcJzB5prMO38hhZ1Rg0Lks',
    appId: '1:200866747654:android:46bdc60bb9feea63b83a87',
    messagingSenderId: '200866747654',
    projectId: 'billapp-bea2d',
    storageBucket: 'billapp-bea2d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCROTcwJdCt6IfU4BgIP84LmJHgUlDW7Eo',
    appId: '1:200866747654:ios:e570b36c6bcc231cb83a87',
    messagingSenderId: '200866747654',
    projectId: 'billapp-bea2d',
    storageBucket: 'billapp-bea2d.appspot.com',
    androidClientId: '200866747654-18pjjuaks4kdmv6p24nuj4pqpgo1jlic.apps.googleusercontent.com',
    iosClientId: '200866747654-orjn0254q0svnt3ak4ophpjr4tqnd795.apps.googleusercontent.com',
    iosBundleId: 'com.example.billapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCROTcwJdCt6IfU4BgIP84LmJHgUlDW7Eo',
    appId: '1:200866747654:ios:9ea62b3cdae09b37b83a87',
    messagingSenderId: '200866747654',
    projectId: 'billapp-bea2d',
    storageBucket: 'billapp-bea2d.appspot.com',
    androidClientId: '200866747654-18pjjuaks4kdmv6p24nuj4pqpgo1jlic.apps.googleusercontent.com',
    iosClientId: '200866747654-q7g6cddh0ndvu47gp9bi98v663rqt0aq.apps.googleusercontent.com',
    iosBundleId: 'com.example.billapp.RunnerTests',
  );
}