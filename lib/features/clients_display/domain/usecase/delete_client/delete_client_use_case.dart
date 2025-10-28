
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/request_delete_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/response_delete_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/repository/api_clients_repository.dart';

class DeleteClientUseCase {
  final ApiClientsRepository apiClientsRepository;

  DeleteClientUseCase({required this.apiClientsRepository});

  Future<ResponseDeleteClientDTO> call(
    RequestDeleteClientDTO request,
  ) async {
    return await apiClientsRepository.deleteClient(request);
  }
}
