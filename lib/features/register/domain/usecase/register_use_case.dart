import 'package:clients_manager/features/register/domain/entities/register_request.dart';
import 'package:clients_manager/features/register/domain/entities/register_response.dart';
import 'package:clients_manager/features/register/domain/repository/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  Future<RegisterResponse> call(RegisterRequest request) async {
    return await registerRepository.register(request);
  }
}
