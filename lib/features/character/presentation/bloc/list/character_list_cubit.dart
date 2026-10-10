import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_character_repository.dart';
import 'character_list_state.dart';

class CharacterListCubit extends Cubit<CharacterListState> {
  CharacterListCubit(this._repository) : super(const CharacterListLoading());

  final ICharacterRepository _repository;

  Future<void> load() async {
    final characters = await _repository.getCharacters();
    if (isClosed) {
      return;
    }
    emit(CharacterListLoaded(characters, query: ''));
  }

  Future<void> search(String query) async {
    final characters = await _repository.getCharacters(query: query);
    if (isClosed) {
      return;
    }
    emit(
      characters.isEmpty
          ? CharacterListNotFound(query: query)
          : CharacterListLoaded(characters, query: query),
    );
  }
}
