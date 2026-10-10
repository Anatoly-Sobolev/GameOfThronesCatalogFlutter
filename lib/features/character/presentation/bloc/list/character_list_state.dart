import '../../../domain/character_model.dart';

enum CharacterListStatus { initial, loading, success }

class CharacterListState {
  const CharacterListState({
    this.status = CharacterListStatus.initial,
    this.characters = const [],
    this.query = '',
  });

  final CharacterListStatus status;
  final List<CharacterModel> characters;
  final String query;

  CharacterListState copyWith({
    CharacterListStatus? status,
    List<CharacterModel>? characters,
    String? query,
  }) {
    return CharacterListState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      query: query ?? this.query,
    );
  }
}
