class ApiData {
  // Base URL para la API
  static const String base_URL = 'http://localhost:80/api';

  // Endpoints de la API
  // Usuarios
  static const String login = '/users/login';
  static const String register = '/users/register';

  // Clientes
  static const String getClient = '/clients';
  static const String getPageClients = '/clients/page/:page';
  static const String createClient = '/clients';
  static const String updateClient = '/clients/:claveCliente';
  static const String deleteClient = '/clients/:claveCliente'; // Requiere ID del cliente

  static const String tokenApiClients = 'clientsManager';
}
