import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_character_repository.dart';
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

    final father = character.fatherId == null
        ? null
        : _repository.getCharacterById(character.fatherId!);

    emit(
      CharacterDetailState(
        status: CharacterDetailStatus.success,
        character: character,
        father: father,
      ),
    );
  }
}
