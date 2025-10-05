import 'package:clients_manager/features/register/domain/data_transfer_objects/request_register_d_t_o.dart';

class CreateRequestRegisterUseCase {
  RequestRegisterDTO call(String? username, String? email, String? password) {
    if (email == null || email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (password == null || password.isEmpty) {
      throw Exception('Password cannot be empty');
    }
    if (username == null || username.isEmpty) {
      throw Exception('Username cannot be empty');
    }
    return RequestRegisterDTO(username: username, email: email, password: password);
  }
}