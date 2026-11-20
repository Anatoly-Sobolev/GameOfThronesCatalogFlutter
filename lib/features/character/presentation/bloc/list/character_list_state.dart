import '../../../domain/character_model.dart';

sealed class CharacterListState {
  const CharacterListState({required this.query});

  final String query;
}

final class CharacterListLoading extends CharacterListState {
  const CharacterListLoading({super.query = ''});
}

final class CharacterListLoaded extends CharacterListState {
  const CharacterListLoaded(
    this.characters, {
    required super.query,
    this.more = true,
    this.failed = false,
  });
  final bool more;
  final bool failed;
  final List<CharacterModel> characters;
}

final class CharacterListNotFound extends CharacterListState {
  const CharacterListNotFound({required super.query});
}

final class CharacterListError extends CharacterListState {
  const CharacterListError({required super.query});
}
