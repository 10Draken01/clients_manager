import 'package:clients_manager/features/clientes/domain/entities/clientes_data.dart';

class ClientesResponse {
  final bool success;
  final ClientesData clientesData;

  ClientesResponse({required this.success, required this.clientesData});
}
