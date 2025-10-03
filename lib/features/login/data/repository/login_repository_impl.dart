import 'package:clients_manager/features/login/data/datasource/login_service.dart';
import 'package:clients_manager/features/login/domain/entities/login_request.dart';
import 'package:clients_manager/features/login/domain/entities/login_response.dart';
import 'package:clients_manager/features/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService loginService;

  LoginRepositoryImpl({required this.loginService});

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await loginService.login(request);

      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}
