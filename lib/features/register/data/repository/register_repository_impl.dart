import 'package:clients_manager/features/register/data/datasource/register_service.dart';
import 'package:clients_manager/features/register/domain/entities/register_request.dart';
import 'package:clients_manager/features/register/domain/entities/register_response.dart';
import 'package:clients_manager/features/register/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterService registerService;

  RegisterRepositoryImpl({required this.registerService});

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await registerService.register(request);

      return response.toEntity();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}
