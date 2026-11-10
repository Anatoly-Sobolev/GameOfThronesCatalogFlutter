import '../../../domain/character_model.dart';

sealed class CharacterDetailState {
  const CharacterDetailState();
}

final class CharacterDetailLoading extends CharacterDetailState {
  const CharacterDetailLoading();
}

final class CharacterDetailLoaded extends CharacterDetailState {
  const CharacterDetailLoaded(this.character, {this.father});

  final CharacterModel character;
  final CharacterModel? father;
}

final class CharacterDetailNotFound extends CharacterDetailState {
  const CharacterDetailNotFound(this.id);

  final int id;
}
