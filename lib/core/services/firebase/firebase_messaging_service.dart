// lib/core/services/firebase/firebase_messaging_service.dart

import 'dart:async';

import 'package:clients_manager/core/services/routes/app_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ✅ AGREGAR IMPORT
import 'package:clients_manager/core/services/encrypt/encryption_service.dart';
import 'package:clients_manager/core/services/routes/values_objects/app_routes.dart';

class FirebaseMessagingService {
  final FirebaseMessaging firebaseMessaging;
  final EncryptionService encryptionService;

  FirebaseMessagingService({
    required this.firebaseMessaging,
    required this.encryptionService,
  });

  Future<void> initialize(BuildContext context) async {
    try {
      await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        provisional: false,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('📬 Notificación recibida: ${message.data}');
        _handleNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('👆 Notificación tocada: ${message.data}');
        _handleNotification(message);
      });

      final token = await firebaseMessaging.getToken();
      print('🔑 Token FCM: $token');
      print('✅ Firebase Messaging inicializado');
    } catch (e) {
      print('❌ Error: $e');
    }
  }

  Future<void> _handleNotification(RemoteMessage message) async {
    final action = message.data['action'];
    if (action == 'session_closed') {
      print('🔐 Cerrar sesión');
      await _handleSessionClosed();
    }
  }

  Future<void> _handleSessionClosed() async {
    try {
      final context = navigationKey.currentContext;

      if (context == null || !context.mounted) return;

      // 1️⃣ Mostrar diálogo CON contador
      await _showSessionClosedDialogWithCountdown(context);

      // 2️⃣ Limpiar datos
      await _deleteDataUser();

      // 3️⃣ Navegar
      final navContext = navigationKey.currentContext;
      if (navContext != null && navContext.mounted) {
        navContext.go(AppRoutes.login.path);
      }
    } catch (e) {
      print('❌ Error: $e');
      navigationKey.currentContext?.go(AppRoutes.login.path);
    }
  }

  /// 📱 Mostrar diálogo con cuenta regresiva
  Future<void> _showSessionClosedDialogWithCountdown(
    BuildContext context,
  ) async {
    // ✅ Contador de segundos
    final ValueNotifier<int> secondsLeft = ValueNotifier<int>(5);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        // ✅ Timer que cuenta hacia atrás
        Timer.periodic(const Duration(seconds: 1), (timer) {
          if (secondsLeft.value > 0) {
            secondsLeft.value--; // Restar 1 segundo
          } else {
            timer.cancel(); // Detener timer
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(); // Cerrar diálogo
            }
          }
        });

        return WillPopScope(
          onWillPop: () async => false, // No permitir cerrar con back
          child: AlertDialog(
            title: Row(
              children: [
                Icon(Icons.lock, color: Theme.of(context).colorScheme.error),
                const SizedBox(width: 12),
                const Text('Sesión Cerrada'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Tu sesión ha sido cerrada.\n\nTus datos se limpiarán...',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // ✅ CUENTA REGRESIVA
                ValueListenableBuilder<int>(
                  valueListenable: secondsLeft,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        const Text('Redirigiendo en:'),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.errorContainer,
                          ),
                          child: Text(
                            '$value',
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('segundo${value != 1 ? "s" : ""}'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteDataUser() async {
    try {
      print('🧹 Limpiando datos...');
      await encryptionService.clear();
      print('✅ Datos limpios');
    } catch (e) {
      print('❌ Error: $e');
    }
  }
}
