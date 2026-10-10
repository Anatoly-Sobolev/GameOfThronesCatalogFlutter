import '../../../domain/character_model.dart';

enum CharacterDetailStatus { loading, success, notFound }

class CharacterDetailState {
  const CharacterDetailState({
    this.status = CharacterDetailStatus.loading,
    this.character,
    this.father,
  });

  final CharacterDetailStatus status;
  final CharacterModel? character;
  final CharacterModel? father;
}
