import 'package:clients_manager/core/data/datasource/create_client_service.dart';
import 'package:clients_manager/core/data/datasource/delete_client_service.dart';
import 'package:clients_manager/core/data/datasource/get_page_clients_service.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/create_client/request_create_client_d_t_o.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/create_client/response_create_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/request_delete_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/response_delete_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/get_page_clients/request_get_page_clients_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/get_page_clients/response_get_page_clients_d_t_o.dart';
import 'package:clients_manager/core/domain/repository/api_clients_repository.dart';

class ApiClientsRepositoryImpl implements ApiClientsRepository {
  final GetPageClientsService getPageClientsService;
  final CreateClientService createClientService;
  final DeleteClientService deleteClientService;

  ApiClientsRepositoryImpl({
    required this.getPageClientsService,
    required this.createClientService,
    required this.deleteClientService,
  });

  @override
  Future<ResponseGetPageClientsDTO> getPageClients(
    RequestGetPageClientsDTO request,
  ) async {
    try {
      final response = await getPageClientsService.getPageClients(request);

      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }

  @override
  Future<ResponseCreateClientDTO> createClient(
    RequestCreateClientDTO request,
  ) async {
    try {
      final response = await createClientService.createClient(request);
      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }

  @override
  Future<ResponseDeleteClientDTO> deleteClient(
    RequestDeleteClientDTO request,
  ) async {
    try {
      final response = await deleteClientService.deleteClient(request);
      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}
