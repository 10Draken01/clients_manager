import 'dart:io';

import 'package:clients_manager/core/domain/values_objects/character_icon_types.dart';

class CharacterIconEntity {
  final CharacterIconType type;
  final int? iconId;
  final String? id;
  final String? url;
  final File? file;

  CharacterIconEntity._({
    required this.type,
    this.iconId,
    this.id,
    this.url,
    this.file,
  });

  // Constructor para ícono por número (0-9)
  factory CharacterIconEntity.fromNumber(int iconId) {
    if (iconId < 0 || iconId > 9) {
      throw Exception('iconId must be between 0 and 9, got: $iconId');
    }
    return CharacterIconEntity._(
      type: CharacterIconType.number,
      iconId: iconId,
    );
  }

  // Constructor para ícono desde URL
  factory CharacterIconEntity.fromUrl({
    required String url,
    String? id,
  }) {
    if (url.isEmpty) {
      throw Exception('url cannot be empty');
    }
    return CharacterIconEntity._(
      type: CharacterIconType.url,
      id: id,
      url: url,
    );
  }

  // Constructor para ícono desde archivo local
  factory CharacterIconEntity.fromFile(File file) {
    return CharacterIconEntity._(
      type: CharacterIconType.file,
      file: file,
    );
  }

  // Constructor inteligente que decide automáticamente el tipo
  factory CharacterIconEntity.create({
    int? iconId,
    String? id,
    String? url,
    File? file,
  }) {
    // Prioridad: file > url > iconId
    if (file != null) {
      return CharacterIconEntity.fromFile(file);
    }
    
    if (url != null && url.isNotEmpty) {
      return CharacterIconEntity.fromUrl(url: url, id: id);
    }
    
    if (iconId != null) {
      return CharacterIconEntity.fromNumber(iconId);
    }
    
    // Si no hay nada, retornar ícono por defecto
    return CharacterIconEntity.fromNumber(0);
  }

  // Método para copiar con cambios
  CharacterIconEntity copyWith({
    CharacterIconType? type,
    int? iconId,
    String? id,
    String? url,
    File? file,
  }) {
    return CharacterIconEntity._(
      type: type ?? this.type,
      iconId: iconId ?? this.iconId,
      id: id ?? this.id,
      url: url ?? this.url,
      file: file ?? this.file,
    );
  }

  @override
  String toString() {
    return 'CharacterIconEntity(type: $type, iconId: $iconId, id: $id, url: $url, file: ${file?.path})';
  }
}