
import 'package:clients_manager/core/src/domain/entities/user_entity.dart';

class ResponseLoginDTO {
  final bool success;
  final String message;
  final UserEntity? user;

  ResponseLoginDTO({required this.success, required this.message, this.user});
}