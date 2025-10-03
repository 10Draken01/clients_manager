import 'package:clients_manager/core/domain/entities/character_icon.dart';

class Cliente {
  final String id;
  final String claveCliente;
  final String nombre;
  final String celular;
  final String email;
  final CharacterIcon characterIcon; // o usa un tipo fuerte si ya lo tienes definido
  final DateTime createdAt;
  final DateTime updatedAt;

  Cliente({
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
