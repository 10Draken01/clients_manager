import 'package:clients_manager/core/src/domain/data_transfer_objects/save_data_user/request_save_data_user_d_t_o.dart';
import 'package:clients_manager/core/src/domain/data_transfer_objects/save_data_user/response_save_data_user_d_t_o.dart';
import 'package:clients_manager/core/src/domain/repository/local_data_user_repository.dart';

class SaveLocalDataUserEncryptedUseCase {
  final LocalDataUserRepository _localDataUserRepository;

  SaveLocalDataUserEncryptedUseCase(this._localDataUserRepository);

  Future<ResponseSaveDataUserDTO> call(RequestSaveDataUserDTO request) async {
    try {
      await _localDataUserRepository.saveLocalDataUserEncrypted(request.user);
      return ResponseSaveDataUserDTO(
        success: true,
        message: "User saved successfully",
      );
    } catch (e) {
      return ResponseSaveDataUserDTO(
        success: false,
        message: "Error saving user",
      );
    }
  }
}