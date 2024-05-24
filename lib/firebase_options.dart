// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  static String androidApiKey = "";
  static String iosApiKey = "";
  static String androidAppId = "";
  static String iosAppId = "";
  static String messagingSenderID = "";
  static String projectID = "";
  static String storageBucket = "";
  static String iosBundleId = "";

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

  Future getKeys() async {
    await dotenv.load();
    androidApiKey = dotenv.get("ANDROID_API_KEY", fallback: "");
    iosApiKey = dotenv.get("IOS_API_KEY", fallback: "");
    androidAppId = dotenv.get("ANDROID_APP_ID", fallback: "");
    iosAppId = dotenv.get("IOS_APP_ID", fallback: "");
    messagingSenderID = dotenv.get("MESSAGING_SENDER_ID", fallback: "");
    projectID = dotenv.get("PROJECT_ID", fallback: "");
    storageBucket = dotenv.get("STORAGE_BUCKET", fallback: "");
    iosBundleId = dotenv.get("IOS_BUNDLE_ID", fallback: "");
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: androidApiKey,
    appId: androidAppId,
    messagingSenderId: messagingSenderID,
    projectId: projectID,
    storageBucket: storageBucket,
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: iosApiKey,
    appId: iosAppId,
    messagingSenderId: messagingSenderID,
    projectId: projectID,
    storageBucket: storageBucket,
    iosBundleId: iosBundleId,
  );
}