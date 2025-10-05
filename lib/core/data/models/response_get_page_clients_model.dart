import 'package:clients_manager/core/data/models/client_model.dart';
import 'package:clients_manager/core/domain/entities/client_entity.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/response_get_page_clients_d_t_o.dart';

class ResponseGetPageClientsModel extends ResponseGetPageClientsDTO {
  final bool success;
  final String message;
  final List<ClientEntity> clients;
  final int totalClients;

  ResponseGetPageClientsModel({
    required this.success,
    required this.message,
    required this.clients,
    required this.totalClients,
  }) : super(
         success: success,
         message: message,
         clients: clients,
         totalClients: totalClients,
       );

  factory ResponseGetPageClientsModel.fromJson(Map<String, dynamic> json) {
    return ResponseGetPageClientsModel(
      success: json['success'],
      message: json['message'],
      clients: (json['clients'] as List)
          .map((clientJson) => 
          ClientModel.fromJson(clientJson).toEntity()
          )
          .toList(),
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
