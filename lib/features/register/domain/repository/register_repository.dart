import 'package:clients_manager/features/register/domain/data_transfer_objects/request_register_d_t_o.dart';
import 'package:clients_manager/features/register/domain/data_transfer_objects/response_register_d_t_o.dart';

abstract class RegisterRepository {
  Future<ResponseRegisterDTO> register(RequestRegisterDTO request);
}
