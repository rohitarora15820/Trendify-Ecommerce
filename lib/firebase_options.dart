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
    apiKey: 'AIzaSyAOvYPUh5nOnDFWtuyKD_gsx1YctxGdcTI',
    appId: '1:359108531724:web:26b003192912f449114029',
    messagingSenderId: '359108531724',
    projectId: 'trendify-faf3e',
    authDomain: 'trendify-faf3e.firebaseapp.com',
    storageBucket: 'trendify-faf3e.appspot.com',
    measurementId: 'G-E8S6R470TK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAq61Q9lhiMrudbmCufG0df7T0Cox9m1oc',
    appId: '1:359108531724:android:5ee2bea20f3d4d58114029',
    messagingSenderId: '359108531724',
    projectId: 'trendify-faf3e',
    storageBucket: 'trendify-faf3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAn4AP4X3HER-Sthctzq30V_QmoizlZ4l4',
    appId: '1:359108531724:ios:d61f46147a4aa0bf114029',
    messagingSenderId: '359108531724',
    projectId: 'trendify-faf3e',
    storageBucket: 'trendify-faf3e.appspot.com',
    androidClientId: '359108531724-u2cpjld8pkgcejtm4ijcmlngcjdlah5a.apps.googleusercontent.com',
    iosClientId: '359108531724-ddgot5rerl2cltrm5knijmmcg91fv3hp.apps.googleusercontent.com',
    iosBundleId: 'com.example.tstore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAn4AP4X3HER-Sthctzq30V_QmoizlZ4l4',
    appId: '1:359108531724:ios:ab43ffccd49535a1114029',
    messagingSenderId: '359108531724',
    projectId: 'trendify-faf3e',
    storageBucket: 'trendify-faf3e.appspot.com',
    androidClientId: '359108531724-u2cpjld8pkgcejtm4ijcmlngcjdlah5a.apps.googleusercontent.com',
    iosClientId: '359108531724-v0odo3q21hirp6sek73fl4uh3kg1vq8v.apps.googleusercontent.com',
    iosBundleId: 'com.example.tstore.RunnerTests',
  );
}
