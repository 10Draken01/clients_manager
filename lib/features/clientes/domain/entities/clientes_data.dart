import 'package:clients_manager/core/domain/entities/cliente.dart';

class ClientesData {
  final List<Cliente> clientes;
  final int totalDocuments;

  ClientesData({required this.clientes, required this.totalDocuments});
}
