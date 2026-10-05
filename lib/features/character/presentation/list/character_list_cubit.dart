import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/character_model.dart';
import '../../domain/i_character_repository.dart';
import 'character_list_state.dart';

class CharacterListCubit extends Cubit<CharacterListState> {
  CharacterListCubit(this._repository) : super(const CharacterListState());

  final ICharacterRepository _repository;
  List<CharacterModel> _allCharacters = const [];

  void load() {
    emit(state.copyWith(status: CharacterListStatus.loading));
    _allCharacters = _repository.getCharacters();
    emit(
      state.copyWith(
        status: CharacterListStatus.success,
        characters: _filter(state.query),
      ),
    );
  }

  void search(String query) {
    emit(
      state.copyWith(
        status: CharacterListStatus.success,
        query: query,
        characters: _filter(query),
      ),
    );
  }

  List<CharacterModel> _filter(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return _allCharacters;
    }

    return _allCharacters
        .where(
          (character) => character.name.toLowerCase().contains(normalizedQuery),
        )
        .toList();
  }
}
