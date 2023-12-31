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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALI_BdxpN7o_cKJOPAaPDRKb81v64syP0',
    appId: '1:780318268681:android:c7be1068b3f120779487d8',
    messagingSenderId: '780318268681',
    projectId: 'apt-rite-346310',
    databaseURL: 'https://apt-rite-346310-default-rtdb.firebaseio.com',
    storageBucket: 'apt-rite-346310.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDEwlhHainxSwHd1g20UheITR8pOTY--A',
    appId: '1:780318268681:ios:6eba7c16404f28f29487d8',
    messagingSenderId: '780318268681',
    projectId: 'apt-rite-346310',
    databaseURL: 'https://apt-rite-346310-default-rtdb.firebaseio.com',
    storageBucket: 'apt-rite-346310.appspot.com',
    androidClientId: '780318268681-04qc0jau87cr1e7u8g1bla3u8e14alon.apps.googleusercontent.com',
    iosClientId: '780318268681-8blntegm1mv66gc7kviaqid9l2bup2mi.apps.googleusercontent.com',
    iosBundleId: 'com.example.gdscBloc',
  );
}
