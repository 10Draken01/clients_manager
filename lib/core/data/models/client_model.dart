
import 'package:clients_manager/core/data/models/character_icon_model.dart';
import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/core/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  final String id;
  final String claveCliente;
  final String nombre;
  final String celular;
  final String email;
  final CharacterIconEntity characterIcon;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientModel({
    required this.id,
    required this.claveCliente,
    required this.nombre,
    required this.celular,
    required this.email,
    required this.characterIcon,
    required this.createdAt,
    required this.updatedAt,
  }): super(
    id: id,
    claveCliente: claveCliente,
    nombre: nombre,
    celular: celular,
    email: email,
    characterIcon: characterIcon,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'],
      claveCliente: json['claveCliente'],
      nombre: json['nombre'],
      celular: json['celular'],
      email: json['email'],
      characterIcon: CharacterIconModel.fromDynamic(json['characterIcon']).toEntity(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  ClientEntity toEntity() {
    return ClientEntity(
      id: id,
      claveCliente: claveCliente,
      nombre: nombre,
      celular: celular,
      email: email,
      characterIcon: characterIcon,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}