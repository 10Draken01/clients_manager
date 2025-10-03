import 'package:clients_manager/features/register/domain/entities/register_request.dart';

class CreateRegisterRequestUseCase {
  RegisterRequest call(String? username, String? email, String? password) {
    if (email == null || email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (password == null || password.isEmpty) {
      throw Exception('Password cannot be empty');
    }
    if (username == null || username.isEmpty) {
      throw Exception('Username cannot be empty');
    }
    return RegisterRequest(username: username, email: email, password: password);
  }
}