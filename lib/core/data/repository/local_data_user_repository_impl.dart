
import 'dart:convert';

import 'package:clients_manager/core/data/datasource/encryption_service.dart';
import 'package:clients_manager/core/data/models/user_model.dart';
import 'package:clients_manager/core/domain/entities/user_entity.dart';
import 'package:clients_manager/core/domain/repository/local_data_user_repository.dart';

class LocalDataUserRepositoryImpl implements LocalDataUserRepository{
  final EncryptionService _encryptionService;

  LocalDataUserRepositoryImpl(this._encryptionService);

  @override
  Future<void> saveLocalDataUserEncrypted(UserEntity user) async {
    try {
      
      final modelUser = UserModel.fromEntity(user);
      final userJson = jsonEncode(modelUser.toJson());
      await _encryptionService.saveString(
        user.id,
        userJson,
      );
    } catch (e) {
      throw Exception('Error saving user: $e');
    }
  }

  @override
  Future<UserEntity?> getLocalDataUserUnencrypted(String userId) async {
    try {
      final userJson = await _encryptionService.getString(userId);
      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  @override
  Future<void> deleteLocalDataUserEncrypted(String userId) async {
    try {
      await _encryptionService.remove(userId);
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}