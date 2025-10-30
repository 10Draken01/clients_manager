import 'dart:async';

import 'package:clients_manager/core/services/inactivity/presentation/pages/inactivity_screen.dart';
import 'package:clients_manager/core/services/routes/values_objects/app_routes.dart';
import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';
import 'package:clients_manager/features/clients_display/presentation/pages/client_form_screen.dart';
import 'package:clients_manager/features/clients_display/presentation/pages/clients_display_screen.dart';
import 'package:clients_manager/features/login/presentation/pages/login_screen.dart';
import 'package:clients_manager/features/register/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

CustomTransitionPage _fadeSlideTransition({
  required Widget child,
  required LocalKey pageKey,
}) {
  return CustomTransitionPage(
    key: pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero),
        ),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

/// 📱 App Router con GoRouter
/// Centraliza toda la lógica de navegación de la aplicación
final appRouter = GoRouter(
  navigatorKey: navigationKey,
  /// 🏠 Ruta inicial según autenticación
  initialLocation: AppRoutes.login.path,

  /// 🔄 Listeners para cambios de autenticación
  // refreshListenable: GoRouterRefreshStream(
  //   Stream.value(authProvider.isAuthenticated)
  // ),

  /// 🛂 Redireccionamiento basado en autenticación
  // redirect: (context, state) {
  //   final isLoggedIn = ref.watch(authProvider).isAuthenticated;
  //   final isLoggingIn = state.matchedLocation == AppRoutes.login.path;
  //
  //   if (!isLoggedIn && !isLoggingIn) {
  //     return AppRoutes.login.path;
  //   }
  //   if (isLoggedIn && isLoggingIn) {
  //     return AppRoutes.clientsDisplay.path;
  //   }
  //
  //   return null;
  // },
  routes: [
    /// 🔐 RUTA: Login
    GoRoute(
      name: AppRoutes.login.name,
      path: AppRoutes.login.path,
      builder: (context, state) => const LoginScreen(),
      routes: [
        /// 📝 RUTA ANIDADA: Register
        ///
        /// 🎬 CAMBIA LA TRANSICIÓN AQUÍ:
        /// Reemplaza _fadeSlideTransition por:
        ///   _fadeTransition
        ///   _scaleTransition
        ///   _slideBottomTransition
        ///   _sineCurveTransition
        GoRoute(
          name: AppRoutes.register.name,
          path: AppRoutes.register.path,
          pageBuilder: (context, state) => _fadeSlideTransition(
            child: const RegisterScreen(),
            pageKey: state.pageKey,
          ),
        ),
      ],
    ),

    ShellRoute(
      builder: (context, state, child) {
        return InactivityScreen(
          inactivityTimeout: const Duration(minutes: 5),
          child: child,
        );
      },
      routes: [
        /// 📱 RUTA: Clientes Display
        GoRoute(
          name: AppRoutes.clientsDisplay.name,
          path: AppRoutes.clientsDisplay.path,
          builder: (context, state) => const ClientsDisplayScreen(),
          routes: [
            /// ✏️ RUTA ANIDADA: Client Form
            GoRoute(
              name: AppRoutes.clientForm.name,
              path: AppRoutes.clientForm.path, // 'client_form/:clientId'
              pageBuilder: (context, state) {
                /// 📥 Obtener cliente del extra (pasado con context.push)
                final ClientEntity? clientToEdit = state.extra as ClientEntity?;

                return _fadeSlideTransition(
                  child: ClientFormScreen(clientToEdit: clientToEdit),
                  pageKey: state.pageKey,
                );
              },
            ),
          ],
        ),

        /// 👤 RUTA: Profile
        GoRoute(
          name: AppRoutes.profile.name,
          path: AppRoutes.profile.path,
          builder: (context, state) {
            return const Scaffold(body: Center(child: Text('Profile Screen')));
          },
        ),

        /// ❌ RUTA: Not Found
        GoRoute(
          name: AppRoutes.notFound.name,
          path: AppRoutes.notFound.path,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Página no encontrada'))),
        ),
      ],
    ),
  ],

  /// 🚨 Error handler
  errorBuilder: (context, state) {
    print('❌ GoRouter Error: ${state.error}');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('❌ Error en la navegación'),
            const SizedBox(height: 16),
            Text(
              state.error?.toString() ?? 'Error desconocido',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.login.path),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  },
);

/// 🔄 Helper para refrescar el router cuando cambia la autenticación
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
