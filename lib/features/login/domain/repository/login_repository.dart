import 'package:clients_manager/features/login/domain/data_transfer_objects/request_login_d_t_o.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/response_login_d_t_o.dart';

abstract class LoginRepository {
  Future<ResponseLoginDTO> login(RequestLoginDTO request);
}
