import '../domain/character_model.dart';
import '../domain/i_character_repository.dart';
import 'mock_characters.dart';

class CharacterRepository implements ICharacterRepository {
  @override
  Future<List<CharacterModel>> getCharacters({String query = ''}) async {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return mockCharacters;
    }

    return [
      for (final character in mockCharacters)
        if (character.name.toLowerCase().contains(normalizedQuery)) character,
    ];
  }

  @override
  Future<CharacterModel?> getCharacterById(int id) async {
    for (final character in mockCharacters) {
      if (character.id == id) {
        return character;
      }
    }
    return null;
  }
}
