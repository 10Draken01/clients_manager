
import 'dart:convert';

import 'package:clients_manager/core/services/encrypt/encryption_service.dart';
import 'package:clients_manager/core/src/data/models/user_model.dart';
import 'package:clients_manager/core/src/domain/entities/user_entity.dart';
import 'package:clients_manager/core/src/domain/repository/local_data_user_repository.dart';

class LocalDataUserRepositoryImpl implements LocalDataUserRepository{
  final EncryptionService _encryptionService;
  final String keyDataUser =  'data_user';

  LocalDataUserRepositoryImpl(this._encryptionService);

  @override
  Future<void> saveLocalDataUserEncrypted(UserEntity user) async {
    try {
      
      final modelUser = UserModel.fromEntity(user);
      final userJson = jsonEncode(modelUser.toJson());
      await _encryptionService.saveString(
        keyDataUser,
        userJson,
      );
    } catch (e) {
      throw Exception('Error saving user: $e');
    }
  }

  @override
  Future<UserEntity?> getLocalDataUserUnencrypted() async {
    try {
      final userJson = await _encryptionService.getString(keyDataUser);
      print('Retrieved user JSON: $userJson');
      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  @override
  Future<void> deleteLocalDataUserEncrypted() async {
    try {
      await _encryptionService.remove(keyDataUser);
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}