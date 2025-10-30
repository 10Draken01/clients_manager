
import 'package:clients_manager/core/src/domain/entities/user_entity.dart';

class ResponseGetDataUserDTO {
  final bool success;
  final String message;
  final UserEntity? user;

  ResponseGetDataUserDTO({required this.success, required this.message, this.user});
}