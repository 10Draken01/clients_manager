import 'package:clients_manager/features/clients_display/data/models/character_icon_model.dart';
import 'package:clients_manager/features/clients_display/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  final String id;
  final String clientKey;
  final String name;
  final String phone;
  final String email;
  final CharacterIconEntity characterIcon;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientModel({
    required this.id,
    required this.clientKey,
    required this.name,
    required this.phone,
    required this.email,
    required this.characterIcon,
    required this.createdAt,
    required this.updatedAt,
  }): super(
    id: id,
    clientKey: clientKey,
    name: name,
    phone: phone,
    email: email,
    characterIcon: characterIcon,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'],
      clientKey: json['clientKey'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      characterIcon: CharacterIconModel.fromDynamic(json['characterIcon']).toEntity(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  ClientEntity toEntity() {
    return ClientEntity(
      id: id,
      clientKey: clientKey,
      name: name,
      phone: phone,
      email: email,
      characterIcon: characterIcon,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}