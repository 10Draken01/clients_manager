
import 'package:clients_manager/core/domain/data_transfer_objects/create_client/request_create_client_d_t_o.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/create_client/response_create_client_d_t_o.dart';
import 'package:clients_manager/core/domain/repository/api_clients_repository.dart';

class CreateClientUseCase {
  final ApiClientsRepository apiClientsRepository;

  CreateClientUseCase({required this.apiClientsRepository});

  Future<ResponseCreateClientDTO> call(
    RequestCreateClientDTO request,
  ) async {
    return await apiClientsRepository.createClient(request);
  }
}
