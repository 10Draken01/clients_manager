import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/create_client/request_create_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/create_client/response_create_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/request_delete_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/response_delete_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/get_page_clients/request_get_page_clients_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/get_page_clients/response_get_page_clients_d_t_o.dart';

abstract class ApiClientsRepository {
  // Metodo para obtener una página de clientes
  Future<ResponseGetPageClientsDTO> getPageClients(RequestGetPageClientsDTO request);

  // Metodo para crear un cliente
  Future<ResponseCreateClientDTO> createClient(RequestCreateClientDTO request);

  // Metodo para eliminar un cliente
  Future<ResponseDeleteClientDTO> deleteClient(RequestDeleteClientDTO request);

}