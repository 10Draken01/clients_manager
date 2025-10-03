class ApiData {
  // Base URL para la API
  static const String base_URL = 'http://localhost:80/api';

  // Endpoints de la API
  // Usuarios
  static const String login = '/users/login';
  static const String register = '/users/register';

  // Clientes
  static const String getClient = '/clientes';
  static const String getPageClients = '/page/:page';
  static const String addClient = '/clientes';
  static const String updateClient = '/:claveCliente';
  static const String deleteClient =
      '/:claveCliente'; // Requiere ID del cliente

  static const String tokenApiClients = 'clientsManager';
}
