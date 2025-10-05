import 'package:clients_manager/features/login/data/datasource/login_service.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/request_login_d_t_o.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/response_login_d_t_o.dart';
import 'package:clients_manager/features/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService loginService;

  LoginRepositoryImpl({required this.loginService});

  @override
  Future<ResponseLoginDTO> login(RequestLoginDTO request) async {
    try {
      final response = await loginService.login(request);

      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}
