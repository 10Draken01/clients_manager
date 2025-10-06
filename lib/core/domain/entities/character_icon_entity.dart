import 'package:clients_manager/core/domain/values_objects/character_icon_types.dart';
import 'package:image_picker/image_picker.dart';

class CharacterIconEntity {
  CharacterIconType type;
  int? iconId;
  String? id;
  String? url;
  XFile? image;

  CharacterIconEntity({
    this.type = CharacterIconType.number,
    this.iconId = 0,
    this.id,
    this.url,
    this.image,
  });

  void setIconId(int? iconId) {
    if (iconId == null) {
      throw Exception('iconId cannot be null.');
    }
    if (iconId < 0 || iconId > 9) {
      throw Exception('iconId must be between 0 and 9.');
    }
    type = CharacterIconType.number;
    this.iconId = iconId;
  }

  void setUrl(String? url) {
    if (url == null || url.isEmpty) {
      throw Exception('url cannot be null or empty.');
    }
    this.type = CharacterIconType.url;
    this.url = url;
  }

  void setImage(XFile? image) {
    if (image == null) {
      throw Exception('image cannot be null.');
    }
    this.type = CharacterIconType.local;
    this.image = image;
  }
}
