// lib/core/services/firebase/firebase_messaging_service.dart

import 'dart:async';

import 'package:clients_manager/core/services/routes/app_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clients_manager/core/services/encrypt/encryption_service.dart';
import 'package:clients_manager/core/services/routes/values_objects/app_routes.dart';

class FirebaseMessagingService {
  final FirebaseMessaging firebaseMessaging;
  final EncryptionService encryptionService;

  Timer? _countdownTimer;

  FirebaseMessagingService({
    required this.firebaseMessaging,
    required this.encryptionService,
  });

  /// 🚀 Inicializar Firebase Messaging
  Future<void> initialize(BuildContext context) async {
    try {
      // Solicitar permisos de notificaciones
      await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        provisional: false,
        sound: true,
      );

      // Escuchar notificaciones en foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('📬 Notificación recibida en foreground: ${message.data}');
        _handleNotification(message);
      });

      // Escuchar cuando se toca una notificación
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('👆 Notificación tocada: ${message.data}');
        _handleNotification(message);
      });

      // Obtener token FCM
      final token = await firebaseMessaging.getToken();
      debugPrint('🔑 Token FCM: $token');
      debugPrint('✅ Firebase Messaging inicializado correctamente');
    } catch (e) {
      debugPrint('❌ Error al inicializar Firebase Messaging: $e');
    }
  }

  /// 📨 Manejar notificaciones recibidas
  Future<void> _handleNotification(RemoteMessage message) async {
    final action = message.data['action'] as String?;

    debugPrint('🔍 Acción recibida: $action');

    switch (action) {
      case 'session_closed':
        debugPrint('🔐 Sesión cerrada por servidor');
        await _handleSessionClosed();
      case 'delete_user_data':
        debugPrint('🧹 Datos de usuario eliminados por servidor');
        await _handleUserDataDeletion();
      default:
        debugPrint('⚠️ Acción desconocida: $action');
    }
  }

  /// 🔐 Manejar cierre de sesión
  Future<void> _handleSessionClosed() async {
    try {
      final context = navigationKey.currentContext;

      if (context == null || !context.mounted) {
        debugPrint('❌ Contexto no disponible para mostrar diálogo');
        return;
      }

      // 1️⃣ Mostrar diálogo con contador regresivo
      await _showSessionClosedDialogWithCountdown(context);

      // 2️⃣ Limpiar datos del usuario
      await _deleteUserData();

      // 3️⃣ Navegar al login
      await _navigateToLogin();
    } catch (e) {
      debugPrint('❌ Error al cerrar sesión: $e');
      await _navigateToLogin();
    }
  }

  /// 🗑️ Manejar eliminación de datos del usuario
  Future<void> _handleUserDataDeletion() async {
    try {
      final context = navigationKey.currentContext;

      if (context == null || !context.mounted) {
        debugPrint('❌ Contexto no disponible');
        return;
      }

      // 1️⃣ Limpiar datos primero
      await _deleteUserData();

      // 2️⃣ Mostrar diálogo (sin contador, se puede cerrar con tap)
      await _showUserDataDeletionDialog(context);

    } catch (e) {
      debugPrint('❌ Error al eliminar datos: $e');
      await _navigateToLogin();
    }
  }

  /// 🗑️ Mostrar diálogo de eliminación de datos sin contador
  Future<void> _showUserDataDeletionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: () async => true,
          child: AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Row(
              children: [
                Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 12),
                const Text('Datos Eliminados'),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16),
                Text(
                  'Tus datos han sido eliminados.\n\nTu cuenta ha sido desactivada.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Entendido'),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 📱 Mostrar diálogo con cuenta regresiva
  Future<void> _showSessionClosedDialogWithCountdown(
    BuildContext context,
  ) async {
    // Cancelar timer anterior si existe
    _countdownTimer?.cancel();

    final ValueNotifier<int> secondsLeft = ValueNotifier<int>(5);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        // Iniciar timer con cuenta regresiva
        _countdownTimer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            if (secondsLeft.value > 0) {
              secondsLeft.value--;
            } else {
              timer.cancel();
              _countdownTimer = null;
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            }
          },
        );

        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Row(
              children: [
                Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.error,
                ),
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
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
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
    ).whenComplete(() {
      // Asegurar que el timer se cancela cuando el diálogo se cierra
      _countdownTimer?.cancel();
      _countdownTimer = null;
    });
  }

  /// 🧹 Eliminar datos del usuario
  Future<void> _deleteUserData() async {
    try {
      debugPrint('🧹 Limpiando datos del usuario...');
      await encryptionService.clear();
      debugPrint('✅ Datos limpiados correctamente');
    } catch (e) {
      debugPrint('❌ Error al limpiar datos: $e');
    }
  }

  /// 🚪 Navegar a la pantalla de login
  Future<void> _navigateToLogin() async {
    try {
      final context = navigationKey.currentContext;
      if (context != null && context.mounted) {
        context.go(AppRoutes.login.path);
        debugPrint('✅ Navegación a login completada');
      }
    } catch (e) {
      debugPrint('❌ Error al navegar: $e');
    }
  }

  /// 🛑 Limpiar recursos (llamar en dispose)
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }
}