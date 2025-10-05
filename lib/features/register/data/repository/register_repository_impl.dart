import 'package:clients_manager/features/register/data/datasource/register_service.dart';
import 'package:clients_manager/features/register/domain/data_transfer_objects/request_register_d_t_o.dart';
import 'package:clients_manager/features/register/domain/data_transfer_objects/response_register_d_t_o.dart';
import 'package:clients_manager/features/register/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterService registerService;

  RegisterRepositoryImpl({required this.registerService});

  @override
  Future<ResponseRegisterDTO> register(RequestRegisterDTO request) async {
    try {
      final response = await registerService.register(request);

      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}
