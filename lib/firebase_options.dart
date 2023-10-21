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
    apiKey: 'AIzaSyB69anbQEToX09TNciaqRzSq1MSAA4SugU',
    appId: '1:246502554912:web:e3e3898ab3014d81166b45',
    messagingSenderId: '246502554912',
    projectId: 'todoapp-9d779',
    authDomain: 'todoapp-9d779.firebaseapp.com',
    storageBucket: 'todoapp-9d779.appspot.com',
    measurementId: 'G-EN8L3DJ2N2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkItsVfYZh1iMzpyW-51MUgXO_26G70iI',
    appId: '1:246502554912:android:f6a431a4249cce24166b45',
    messagingSenderId: '246502554912',
    projectId: 'todoapp-9d779',
    storageBucket: 'todoapp-9d779.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm3HzrcGXA7hIEKA3dRwMd5zumdYKO8ng',
    appId: '1:246502554912:ios:df49677b532ba785166b45',
    messagingSenderId: '246502554912',
    projectId: 'todoapp-9d779',
    storageBucket: 'todoapp-9d779.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );
}