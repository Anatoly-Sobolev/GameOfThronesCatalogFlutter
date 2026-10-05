import '../domain/character_model.dart';
import '../domain/i_character_repository.dart';
import 'mock_characters.dart';

class CharacterRepository implements ICharacterRepository {
  @override
  List<CharacterModel> getCharacters() => mockCharacters;

  @override
  CharacterModel? getCharacterById(int id) {
    for (final character in mockCharacters) {
      if (character.id == id) {
        return character;
      }
    }
    return null;
  }
}
