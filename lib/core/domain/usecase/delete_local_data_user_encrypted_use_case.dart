import 'package:clients_manager/core/domain/data_transfer_objects/delete_data_user/request_delete_data_user_d_t_o.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/delete_data_user/response_delete_data_user_d_t_o.dart';
import 'package:clients_manager/core/domain/repository/local_data_user_repository.dart';

class DeleteLocalDataUserEncryptedUseCase {
  final LocalDataUserRepository _localDataUserRepository;

  DeleteLocalDataUserEncryptedUseCase(this._localDataUserRepository);

  Future<ResponseDeleteDataUserDTO> call(
    RequestDeleteDataUserDTO request,
  ) async {
    try {
      await _localDataUserRepository.deleteLocalDataUserEncrypted(request.userId);
      return ResponseDeleteDataUserDTO(
        success: true,
        message: "User deleted successfully",
      );
    } catch (e) {
      return ResponseDeleteDataUserDTO(
        success: false,
        message: "Error deleting user",
      );
    }
  }
}
