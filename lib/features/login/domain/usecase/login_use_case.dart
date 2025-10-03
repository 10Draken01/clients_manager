import 'package:clients_manager/features/login/domain/entities/login_request.dart';
import 'package:clients_manager/features/login/domain/entities/login_response.dart';
import 'package:clients_manager/features/login/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<LoginResponse> call(LoginRequest request) async {
    return await loginRepository.login(request);
  }
}
