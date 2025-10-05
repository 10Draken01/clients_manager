
import 'package:clients_manager/core/data/datasource/get_page_clients_service.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/request_get_page_clients_d_t_o.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/response_get_page_clients_d_t_o.dart';
import 'package:clients_manager/core/domain/repository/api_clients_repository.dart';

class ApiClientsRepositoryImpl implements ApiClientsRepository {
  final GetPageClientsService getPageClientsService;

  ApiClientsRepositoryImpl({
    required this.getPageClientsService,
  });

  @override
  Future<ResponseGetPageClientsDTO> getPageClients(RequestGetPageClientsDTO request) async {
    try {
      final response = await getPageClientsService.getPageClients(request);

      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}
