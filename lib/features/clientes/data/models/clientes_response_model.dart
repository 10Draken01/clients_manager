import 'package:clients_manager/features/clientes/domain/entities/clientes_data.dart';
import 'package:clients_manager/features/clientes/domain/entities/clientes_response.dart';

class ClientesResponseModel extends ClientesResponse {
  final bool success;
  final ClientesData clientesData;

  ClientesResponseModel({
    required this.success,
    required this.clientesData,
  }): super(
    success: success,
    clientesData: clientesData
  );

  factory ClientesResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];


    if(data != null) {
      
    }

    return ClientesResponseModel(success: json['success'], clientesData: clientesData)
  }
}