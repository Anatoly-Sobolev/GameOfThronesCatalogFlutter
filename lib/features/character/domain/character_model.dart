class CharacterModel {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.culture,
    required this.born,
    required this.titles,
    required this.aliases,
    required this.playedBy,
  });

  final int id;
  final String name;
  final String gender;
  final String culture;
  final String born;
  final List<String> titles;
  final List<String> aliases;
  final List<String> playedBy;
}
