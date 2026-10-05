import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/i_character_repository.dart';
import 'character_detail_state.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  CharacterDetailCubit(this._repository) : super(const CharacterDetailState());

  final ICharacterRepository _repository;

  void load(int id) {
    final character = _repository.getCharacterById(id);
    if (character == null) {
      emit(const CharacterDetailState(status: CharacterDetailStatus.notFound));
      return;
    }

    final allCharacters = _repository.getCharacters();
    final index = allCharacters.indexWhere((item) => item.id == id);
    final relatedIndex = (index + 1) % allCharacters.length;

    emit(
      CharacterDetailState(
        status: CharacterDetailStatus.success,
        character: character,
        relatedCharacter: allCharacters[relatedIndex],
      ),
    );
  }
}
