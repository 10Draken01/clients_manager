
import 'package:clients_manager/features/login/domain/entities/login_request.dart';

class CreateRequestUsecase {
  LoginRequest call(String? email, String? password) {
    if (email == null || email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (password == null || password.isEmpty) {
      throw Exception('Password cannot be empty');
    }
    return LoginRequest(email: email, password: password);
  }
}