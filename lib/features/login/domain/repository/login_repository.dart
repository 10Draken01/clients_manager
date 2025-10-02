import 'package:clients_manager/features/login/domain/entities/login_request.dart';
import 'package:clients_manager/features/login/domain/entities/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(LoginRequest request);
}
