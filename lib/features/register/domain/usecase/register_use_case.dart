import 'package:clients_manager/features/register/domain/data_transfer_objects/request_register_d_t_o.dart';
import 'package:clients_manager/features/register/domain/data_transfer_objects/response_register_d_t_o.dart';
import 'package:clients_manager/features/register/domain/repository/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  Future<ResponseRegisterDTO> call(RequestRegisterDTO request) async {
    return await registerRepository.register(request);
  }
}
