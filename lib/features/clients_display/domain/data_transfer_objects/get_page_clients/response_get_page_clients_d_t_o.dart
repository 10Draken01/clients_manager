import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';

class ResponseGetPageClientsDTO {
  final bool success;
  final String message;
  final List<ClientEntity>? clients;
  final int? totalClients;

  ResponseGetPageClientsDTO({
    required this.success,
    required this.message,
    this.clients,
    this.totalClients,
  });
}
