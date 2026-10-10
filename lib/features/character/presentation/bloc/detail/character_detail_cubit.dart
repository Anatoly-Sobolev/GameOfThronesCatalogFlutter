import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_character_repository.dart';
import 'character_detail_state.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  CharacterDetailCubit(this._repository) : super(const CharacterDetailState());

  final ICharacterRepository _repository;

  Future<void> load(int id) async {
    final character = await _repository.getCharacterById(id);
    if (character == null) {
      if (isClosed) {
        return;
      }
      emit(const CharacterDetailState(status: CharacterDetailStatus.notFound));
      return;
    }

    final father = character.fatherId == null
        ? null
        : await _repository.getCharacterById(character.fatherId!);

    if (isClosed) {
      return;
    }

    emit(
      CharacterDetailState(
        status: CharacterDetailStatus.success,
        character: character,
        father: father,
      ),
    );
  }
}
