// domain/repositories/user_repository.dart
import 'package:clients_manager/core/src/domain/entities/user_entity.dart';

abstract class LocalDataUserRepository {
  Future<void> saveLocalDataUserEncrypted(UserEntity user);
  Future<UserEntity?> getLocalDataUserUnencrypted(String userId);
  Future<void> deleteLocalDataUserEncrypted(String userId);
}