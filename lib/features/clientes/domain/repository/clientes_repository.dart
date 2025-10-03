import 'package:clients_manager/features/clientes/domain/entities/clientes_request.dart';
import 'package:clients_manager/features/clientes/domain/entities/clientes_response.dart';

abstract class ClientesRepository {
  Future<ClientesResponse> getPageClientes(ClientesRequest request);
}
