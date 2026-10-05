import 'character_model.dart';

abstract interface class ICharacterRepository {
  List<CharacterModel> getCharacters();

  CharacterModel? getCharacterById(int id);
}
