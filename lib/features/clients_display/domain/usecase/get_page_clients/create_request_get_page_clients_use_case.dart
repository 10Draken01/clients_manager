import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/get_page_clients/request_get_page_clients_d_t_o.dart';

class CreateRequestGetPageClientsUseCase {
  RequestGetPageClientsDTO call(int? page) {

    if(page == null) {
      throw Exception('Page cannot be null');
    }
    if(page < 1) {
      throw Exception('Page must be greater than 0');
    }
    return RequestGetPageClientsDTO(page: page);
  }
}