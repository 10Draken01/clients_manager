import 'package:clients_manager/core/domain/data_transfer_objects/request_get_page_clients_d_t_o.dart';

class CreateRequestGetPageClientsUseCase {
  final int page;

  CreateRequestGetPageClientsUseCase({required this.page});

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