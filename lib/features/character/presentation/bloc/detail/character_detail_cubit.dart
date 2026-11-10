import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_character_repository.dart';
import 'character_detail_state.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  CharacterDetailCubit(this._repository)
    : super(const CharacterDetailLoading());

  final ICharacterRepository _repository;

  Future<void> load(int id) async {
    final character = await _repository.getCharacterById(id);
    if (character == null) {
      if (isClosed) {
        return;
      }
      emit(CharacterDetailNotFound(id));
      return;
    }

    final fatherId = character.fatherId;
    final father = fatherId == null
        ? null
        : await _repository.getCharacterById(fatherId);

    if (isClosed) {
      return;
    }

    emit(CharacterDetailLoaded(character, father: father));
  }
}
