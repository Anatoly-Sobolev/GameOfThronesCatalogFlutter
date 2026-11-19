import 'character_model.dart';

abstract interface class ICharacterRepository {
  Future<List<CharacterModel>> getCharacters({String query = '', int page = 1});

  Future<CharacterModel?> getCharacterById(int id);
}
