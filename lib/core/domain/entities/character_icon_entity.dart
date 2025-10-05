import 'package:clients_manager/core/domain/values_objects/character_icon_types.dart';

class CharacterIconEntity {
  final CharacterIconType type;
  final int? iconId;
  final String? id;
  final String? url;

  CharacterIconEntity({
    required this.type,
    this.iconId,
    this.id,
    this.url
  });
}