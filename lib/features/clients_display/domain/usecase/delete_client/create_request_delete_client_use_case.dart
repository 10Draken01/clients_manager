import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/request_delete_client_d_t_o.dart';

class CreateRequestDeleteClientUseCase {
  RequestDeleteClientDTO call(String? clientKey) {

    if(clientKey == null) {
      throw Exception('Client key cannot be null');
    }
    return RequestDeleteClientDTO(clientKey: clientKey);
  }
}