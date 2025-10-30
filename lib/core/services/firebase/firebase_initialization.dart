

import 'package:clients_manager/core/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseInitialization {
  static Future<void> initialize() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        print('✅ Firebase inicializado correctamente');
      } else {
        print('⚠️ Firebase ya estaba inicializado');
      }
    } catch (e) {
      print('❌ Error inicializando Firebase: $e');
    }
  }
}