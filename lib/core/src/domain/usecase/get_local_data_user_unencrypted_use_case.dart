import 'package:clients_manager/core/src/domain/data_transfer_objects/get_data_user/response_get_data_user_d_t_o.dart';
import 'package:clients_manager/core/src/domain/repository/local_data_user_repository.dart';

class GetLocalDataUserUnencryptedUseCase {
  final LocalDataUserRepository _localDataUserRepository;

  GetLocalDataUserUnencryptedUseCase(this._localDataUserRepository);

  Future<ResponseGetDataUserDTO> call() async {
    try {
      final user = await _localDataUserRepository.getLocalDataUserUnencrypted();
      if (user != null) {
        return ResponseGetDataUserDTO(
          success: true,
          message: "User retrieved successfully",
          user: user,
        );
      } else {
        return ResponseGetDataUserDTO(
          success: false,
          message: "User not found",
          user: null,
        );
      }
    } catch (e) {
      return ResponseGetDataUserDTO(
        success: false,
        message: "Error retrieving user",
        user: null,
      );
    }
  }
}