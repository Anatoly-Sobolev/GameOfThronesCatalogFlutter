import 'package:json_annotation/json_annotation.dart';

import '../domain/character_model.dart';

part 'character_dto.g.dart';

@JsonSerializable(checked: true, createToJson: false)
class CharacterDto {
  const CharacterDto({
    required this.url,
    required this.name,
    required this.gender,
    required this.culture,
    required this.born,
    required this.father,
    required this.aliases,
    required this.titles,
    required this.playedBy,
  });
  final String url, name, gender, culture, born, father;
  final List<String> aliases, titles, playedBy;
  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);

  CharacterModel toModel() {
    final id = int.parse(url.split('/').last);
    final names = aliases.where((alias) => alias.isNotEmpty).toList();
    return CharacterModel(
      id: id,
      name: name.isNotEmpty ? name : names.firstOrNull ?? '#$id',
      gender: gender,
      culture: culture,
      born: born,
      fatherId: int.tryParse(father.split('/').last),
      aliases: names,
      titles: titles.where((s) => s.isNotEmpty).toList(),
      playedBy: playedBy.where((s) => s.isNotEmpty).toList(),
    );
  }
}
