import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_character_repository.dart';
import '../../../domain/character_model.dart';
import 'character_list_state.dart';

class CharacterListCubit extends Cubit<CharacterListState> {
  CharacterListCubit(this._repository) : super(const CharacterListLoading());
  final ICharacterRepository _repository;
  Timer? _timer;
  int _generation = 0;
  int _page = 1;
  bool _busy = false;

  Future<void> load() => _fetch(state.query, _generation, []);
  void search(String query) {
    _timer?.cancel();
    _generation++;
    _busy = false;
    _page = 1;
    emit(CharacterListLoading(query: query));
    _timer = Timer(const Duration(milliseconds: 400), load);
  }

  Future<void> more() async {
    final current = state;
    if (current is CharacterListLoaded && current.more) {
      await _fetch(current.query, _generation, current.characters);
    }
  }

  Future<void> _fetch(
    String query,
    int generation,
    List<CharacterModel> previous,
  ) async {
    if (_busy) return;
    _busy = true;
    try {
      final page = await _repository.getCharacters(query: query, page: _page);
      if (isClosed || generation != _generation) return;
      _page++;
      final combined = [...previous, ...page];
      emit(
        combined.isEmpty
            ? CharacterListNotFound(query: query)
            : CharacterListLoaded(
                combined,
                query: query,
                more: page.length == 20,
              ),
      );
    } catch (_) {
      if (isClosed || generation != _generation) return;
      emit(
        previous.isEmpty
            ? CharacterListError(query: query)
            : CharacterListLoaded(previous, query: query, failed: true),
      );
    } finally {
      if (generation == _generation) _busy = false;
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
