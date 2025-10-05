
import 'package:clients_manager/core/domain/data_transfer_objects/request_get_page_clients_d_t_o.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/response_get_page_clients_d_t_o.dart';

abstract class ApiClientsRepository {
  Future<ResponseGetPageClientsDTO> getPageClients(RequestGetPageClientsDTO request);
}