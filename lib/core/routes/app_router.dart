import 'package:clients_manager/core/routes/values_objects/app_routes.dart';
import 'package:clients_manager/features/clients_display/presentation/pages/client_form_screen.dart';
import 'package:clients_manager/features/clients_display/presentation/pages/clients_display_screen.dart';
import 'package:clients_manager/features/login/presentation/pages/login_screen.dart';
import 'package:clients_manager/features/register/presentation/pages/register_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login.path,
  routes: [
    GoRoute(
      name: AppRoutes.login.name,
      path: AppRoutes.login.path,
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          name: AppRoutes.register.name,
          path: AppRoutes.register.path,
          builder: (context, state) => const RegisterScreen(),
        ),
      ],
    ),
    GoRoute(
      name: AppRoutes.clientsDisplay.name,
      path: AppRoutes.clientsDisplay.path,
      builder: (context, state) => const ClientsDisplayScreen(),
      routes: [
        GoRoute(
          name: AppRoutes.clientForm.name,
          path: AppRoutes.clientForm.path,
          builder: (context, state) {

            return const ClientFormScreen();
          },
        ),
      ],
    ),
  ],
);
