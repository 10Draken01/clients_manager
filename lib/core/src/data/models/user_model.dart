
import 'package:clients_manager/core/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  
  UserModel({
    required String id,
    required String username,
    required String email,
    String? password,
  }) : super(
    id: id,
    username: username,
    email: email,
    password: password,
  );

  // Convertir de Entity a Model
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      password: entity.password,
    );
  }

  // Convertir a JSON para almacenar
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Convertir desde JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
    );
  }

  // Convertir a Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
      password: password,
    );
  }
}