
import 'package:clients_manager/features/login/domain/data_transfer_objects/request_login_d_t_o.dart';

class CreateRequestLoginUseCase {
  RequestLoginDTO call(String? email, String? password) {
    if (email == null || email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (password == null || password.isEmpty) {
      throw Exception('Password cannot be empty');
    }
    return RequestLoginDTO(email: email, password: password);
  }
}