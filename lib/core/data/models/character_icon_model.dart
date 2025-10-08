import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/core/domain/values_objects/character_icon_types.dart';

class CharacterIconModel {
  final CharacterIconType type;
  final int? iconId;
  final String? id;
  final String? url;

  CharacterIconModel({
    required this.type,
    this.iconId,
    this.id,
    this.url,
  });

  factory CharacterIconModel.fromDynamic(dynamic jsonCharacterIcon) {
    // Si es un número o string numérico
    if (jsonCharacterIcon is int ||
        (jsonCharacterIcon is String && int.tryParse(jsonCharacterIcon) != null)) {
      return CharacterIconModel(
        type: CharacterIconType.number,
        iconId: jsonCharacterIcon is int 
            ? jsonCharacterIcon 
            : int.parse(jsonCharacterIcon),
      );
    } 
    // Si es un objeto JSON con url
    else if (jsonCharacterIcon is Map<String, dynamic>) {
      return CharacterIconModel(
        type: CharacterIconType.url,
        id: jsonCharacterIcon['id'],
        url: jsonCharacterIcon['url'],
      );
    }
    // Fallback a ícono por defecto
    else {
      return CharacterIconModel(
        type: CharacterIconType.number,
        iconId: 0,
      );
    }
  }

  // Convertir de Entity a Model
  factory CharacterIconModel.fromEntity(CharacterIconEntity entity) {
    return CharacterIconModel(
      type: entity.type,
      iconId: entity.iconId,
      id: entity.id,
      url: entity.url,
    );
  }

  // Convertir a Entity usando los factory methods apropiados
  CharacterIconEntity toEntity() {
    switch (type) {
      case CharacterIconType.number:
        return CharacterIconEntity.fromNumber(iconId ?? 0);
      
      case CharacterIconType.url:
        return CharacterIconEntity.fromUrl(
          url: url ?? '',
          id: id,
        );
      
      case CharacterIconType.file:
        // Los modelos no manejan archivos, así que retornamos ícono por defecto
        return CharacterIconEntity.fromNumber(0);
    }
  }

  // Convertir a JSON para enviar al backend
  dynamic toJson() {
    switch (type) {
      case CharacterIconType.number:
        return iconId;
      
      case CharacterIconType.url:
        return {
          'id': id,
          'url': url,
        };
      
      case CharacterIconType.file:
        // No deberíamos llegar aquí desde un modelo
        return 0;
    }
  }

  @override
  String toString() {
    return 'CharacterIconModel(type: $type, iconId: $iconId, id: $id, url: $url)';
  }
}