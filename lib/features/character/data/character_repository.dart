import 'package:dio/dio.dart';

import '../domain/character_model.dart';
import '../domain/i_character_repository.dart';
import '../domain/load_failure.dart';
import 'character_api.dart';
import 'network_character_source.dart';

class CharacterRepository implements ICharacterRepository {
  CharacterRepository(this.source);
  final NetworkCharacterSource source;

  factory CharacterRepository.network() {
    final client = Dio(
      BaseOptions(
        baseUrl: 'https://anapioficeandfire.com/api/',
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    return CharacterRepository(NetworkCharacterSource(CharacterApi(client)));
  }

  @override
  Future<List<CharacterModel>> getCharacters({
    String query = '',
    int page = 1,
  }) async {
    final records = await source.page(query, page);
    return records.map((dto) => dto.toModel()).toList();
  }

  @override
  Future<CharacterModel?> getCharacterById(int id) async {
    try {
      return (await source.detail(id)).toModel();
    } on LoadFailure catch (e) {
      if (e == LoadFailure.missing) return null;
      rethrow;
    }
  }

  void close() => source.api.client.close(force: true);
}
