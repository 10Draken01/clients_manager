import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';

class ClientEntity {
  final String? id;
  final String clientKey;
  final String name;
  final String phone;
  final String email;
  CharacterIconEntity characterIcon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClientEntity({
    this.id,
    required this.clientKey,
    required this.name,
    required this.phone,
    required this.email,
    CharacterIconEntity? characterIcon,
    this.createdAt,
    this.updatedAt,
  }) : characterIcon = characterIcon ?? CharacterIconEntity.create();
}
