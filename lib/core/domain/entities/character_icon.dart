sealed class CharacterIcon {}

class CharacterIconInt extends CharacterIcon {
  final int value;

  CharacterIconInt({required this.value});
}

class CharacterIconUrl extends CharacterIcon {
  final String id;
  final Uri url;

  CharacterIconUrl({required this.id, required this.url});
}
