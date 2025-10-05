import 'package:clients_manager/core/domain/entities/client_entity.dart';

class ResponseGetPageClientsDTO {
  final bool success;
  final String message;
  final List<ClientEntity> clients;
  final int totalClients;

  ResponseGetPageClientsDTO({
    required this.success,
    required this.message,
    required this.clients,
    required this.totalClients,
  });
}
