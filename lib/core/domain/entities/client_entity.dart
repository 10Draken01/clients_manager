import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';

class ClientEntity {
  final String id;
  final String claveCliente;
  final String nombre;
  final String celular;
  final String email;
  final CharacterIconEntity characterIcon;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientEntity({
    required this.id,
    required this.claveCliente,
    required this.nombre,
    required this.celular,
    required this.email,
    required this.characterIcon,
    required this.createdAt,
    required this.updatedAt,
  });
}
