import 'package:clients_manager/features/login/presentation/pages/login_screen.dart';
import 'package:clients_manager/features/register/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';

/// 🗺️ Clase para manejar todas las rutas de la app
class AppRoutes {
  // 🚫 Constructor privado para que no se pueda instanciar
  AppRoutes._();

  // 📍 Nombres de las rutas (constantes)
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  // Agregar más rutas aquí...

  /// 🗺️ Map con todas las rutas
  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    // home: (context) => const HomeScreen(),
    // profile: (context) => const ProfileScreen(),
  };

  /// 🚀 Método para navegar a una nueva pantalla
  /// Se puede regresar con el botón de atrás
  static Future<T?> navigateTo<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// 🔄 Método para reemplazar la pantalla actual
  /// NO se puede regresar con el botón de atrás
  static Future<T?> navigateAndReplace<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// 🗑️ Método para limpiar el stack completo y navegar
  /// Elimina todas las pantallas anteriores
  static Future<T?> navigateAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      predicate ?? (route) => false, // Por defecto elimina todo
    );
  }

  /// ◀️ Método para regresar a la pantalla anterior
  static void goBack<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// 🏠 Método específico para ir al Home desde cualquier parte
  /// Limpia todo el stack
  static Future<void> goToHome(BuildContext context) {
    return navigateAndRemoveUntil(context, home);
  }

  /// 🔐 Método específico para hacer logout
  /// Limpia todo el stack y va al login
  static Future<void> logout(BuildContext context) {
    return navigateAndRemoveUntil(context, login);
  }
}