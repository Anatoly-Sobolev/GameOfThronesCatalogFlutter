import 'character_model.dart';

abstract interface class ICharacterRepository {
  Future<List<CharacterModel>> getCharacters({String query = ''});

  Future<CharacterModel?> getCharacterById(int id);
}
