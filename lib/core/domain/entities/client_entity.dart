import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';

class ClientEntity {
  final String? id;
  final String claveCliente;
  final String nombre;
  final String celular;
  final String email;
  CharacterIconEntity characterIcon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClientEntity({
    this.id,
    required this.claveCliente,
    required this.nombre,
    required this.celular,
    required this.email,
    CharacterIconEntity? characterIcon,
    this.createdAt,
    this.updatedAt,
  }) : characterIcon = characterIcon ?? CharacterIconEntity.create();
}
