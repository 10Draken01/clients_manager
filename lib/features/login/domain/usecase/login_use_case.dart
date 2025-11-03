import 'package:clients_manager/core/src/domain/entities/user_entity.dart';
import 'package:clients_manager/core/src/domain/repository/local_data_user_repository.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/request_login_d_t_o.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/response_login_d_t_o.dart';
import 'package:clients_manager/features/login/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  final LocalDataUserRepository localDataUserRepository;

  LoginUseCase({required this.loginRepository, required this.localDataUserRepository});

  Future<ResponseLoginDTO> call(RequestLoginDTO request) async {
    try {
      final response = await loginRepository.login(request);
      print('Login response: ${response.user}');
      if (response.user != null) {
        final userEntity = UserEntity(
          id: response.user!.id,
          username: response.user!.username,
          email: response.user!.email,
          password: request.password,
        );
        await localDataUserRepository.saveLocalDataUserEncrypted(userEntity);

      }
      return response;
    } catch (e) {
      return ResponseLoginDTO(
        success: false,
        message: "Error during login: ${e.toString()}",
      );
    }
  }
}
