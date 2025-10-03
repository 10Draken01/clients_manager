import 'package:clients_manager/features/register/domain/entities/register_request.dart';
import 'package:clients_manager/features/register/domain/entities/register_response.dart';

abstract class RegisterRepository {
  Future<RegisterResponse> register(RegisterRequest request);
}
