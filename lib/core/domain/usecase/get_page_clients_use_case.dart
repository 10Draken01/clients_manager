
import 'package:clients_manager/core/domain/data_transfer_objects/request_get_page_clients_d_t_o.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/response_get_page_clients_d_t_o.dart';
import 'package:clients_manager/core/domain/repository/api_clients_repository.dart';

class GetPageClientsUseCase {
  final ApiClientsRepository apiClientsRepository;

  GetPageClientsUseCase({required this.apiClientsRepository});

  Future<ResponseGetPageClientsDTO> call(
    RequestGetPageClientsDTO request,
  ) async {
    return await apiClientsRepository.getPageClients(request);
  }
}
