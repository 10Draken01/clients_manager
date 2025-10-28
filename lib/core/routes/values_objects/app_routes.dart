import 'package:clients_manager/core/routes/entitie/route_entity.dart';

class AppRoutes {
  static const RouteEntity login = RouteEntity('login', '/login');
  static const RouteEntity register = RouteEntity('register', '/register');
  static const RouteEntity clientsDisplay = RouteEntity('clientsDisplay', '/clients_display');
  static const RouteEntity profile = RouteEntity('profile', '/profile');
  static const RouteEntity clientForm = RouteEntity('clientForm', '/client_form/:clientKey');
}