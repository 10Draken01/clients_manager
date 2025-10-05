import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/core/domain/values_objects/character_icon_types.dart';

class CharacterIconModel extends CharacterIconEntity {
  final CharacterIconType type;
  final int? iconId;
  final String? id;
  final String? url;

  CharacterIconModel({required this.type, this.iconId, this.id, this.url})
    : super(type: type, iconId: iconId, id: id, url: url);

  factory CharacterIconModel.fromDynamic(dynamic jsonCharacterIcon) {
    // Identificamos si es un number/string o otro json
    if (
      jsonCharacterIcon is int ||
      jsonCharacterIcon is String && int.tryParse(jsonCharacterIcon) != null
    ) {
      return CharacterIconModel(
        type: CharacterIconType.number,
        iconId: jsonCharacterIcon is int ? jsonCharacterIcon : int.parse(jsonCharacterIcon),
      );
    } else {
      return CharacterIconModel(
        type: CharacterIconType.url,
        id: jsonCharacterIcon['id'],
        url: jsonCharacterIcon['url'],
      );
    }
  }

  CharacterIconEntity toEntity() {
    return CharacterIconEntity(
      type: type,
      iconId: iconId,
      id: id,
      url: url,
    );
  }
}
