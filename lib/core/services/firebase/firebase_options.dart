// lib/core/services/firebase/firebase_options.dart

import 'dart:io';

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions no está soportado para esta plataforma.',
      );
    }
  }

  // 🔴 ANDROID - Reemplaza con tus valores de google-services.json
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAe67kELjJD8AcyZosGTYL-2FLNwzBcXDM',  // ← Tomar de google-services.json
    appId: '1:89975410429:android:60f9f5d099ed7177cd3894',
    messagingSenderId: '89975410429', // este es el project_number
    projectId: 'appmovilpm-38995ecd',
    databaseURL: 'https://appmovilpm-38995ecd.firebaseio.com',
    storageBucket: 'appmovilpm-38995ecd.firebasestorage.app',
  );

  // 🍎 iOS - Reemplaza con tus valores de GoogleService-Info.plist
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'TU_API_KEY_IOS',
    appId: 'TU_APP_ID_IOS',
    messagingSenderId: 'TU_MESSAGING_SENDER_ID',
    projectId: 'TU_PROJECT_ID',
    databaseURL: 'https://TU_PROJECT_ID.firebaseio.com',
    iosBundleId: 'com.example.clientsManager',
    storageBucket: 'TU_PROJECT_ID.appspot.com',
  );
}