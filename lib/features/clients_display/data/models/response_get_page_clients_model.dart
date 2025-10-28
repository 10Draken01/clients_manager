import 'package:clients_manager/features/clients_display/data/models/client_model.dart';
import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/get_page_clients/response_get_page_clients_d_t_o.dart';

class ResponseGetPageClientsModel extends ResponseGetPageClientsDTO {
  final bool success;
  final String message;
  final List<ClientEntity>? clients;
  final int? totalClients;

  ResponseGetPageClientsModel({
    required this.success,
    required this.message,
    required this.clients,
    this.totalClients,
  }) : super(
         success: success,
         message: message,
         clients: clients,
         totalClients: totalClients,
       );

  factory ResponseGetPageClientsModel.fromJson(Map<String, dynamic> json) {
    final jsonClients = json['clients'];
    return ResponseGetPageClientsModel(
      success: json['success'],
      message: json['message'],
      clients: jsonClients != null
          ? (jsonClients as List)
                .map(
                  (clientJson) => ClientModel.fromJson(clientJson).toEntity(),
                )
                .toList()
          : null,
      totalClients: json['totalClients'],
    );
  }

  ResponseGetPageClientsDTO toEntity() {
    return ResponseGetPageClientsDTO(
      success: success,
      message: message,
      clients: clients,
      totalClients: totalClients,
    );
  }
}
