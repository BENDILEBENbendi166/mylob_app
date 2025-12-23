// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: "...",
          appId: "1:879373771868:web:fc31d3f6a898562bb97299",
          messagingSenderId: "879373771868",
          projectId: "mylob-ba4b4",
          databaseURL:
              "https://mylob-ba4b4-default-rtdb.europe-west1.firebasedatabase.app",
          storageBucket: "mylob-ba4b4.firebasestorage.app",
        );

      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const FirebaseOptions(
          apiKey: "...",
          appId: "1:879373771868:web:fc31d3f6a898562bb97299",
          messagingSenderId: "879373771868",
          projectId: "mylob-ba4b4",
          databaseURL:
              "https://mylob-ba4b4-default-rtdb.europe-west1.firebasedatabase.app",
          storageBucket: "mylob-ba4b4.firebasestorage.app",
          iosClientId: "YOUR_IOS_CLIENT_ID",
          iosBundleId: "YOUR_IOS_BUNDLE_ID",
        );

      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return const FirebaseOptions(
          apiKey: "...",
          appId: "1:879373771868:web:fc31d3f6a898562bb97299",
          messagingSenderId: "879373771868",
          projectId: "mylob-ba4b4",
          databaseURL:
              "https://mylob-ba4b4-default-rtdb.europe-west1.firebasedatabase.app",
          storageBucket: "mylob-ba4b4.firebasestorage.app",
        );
    }
  }
}
