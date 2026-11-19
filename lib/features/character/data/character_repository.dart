import 'package:dio/dio.dart';

import '../domain/character_model.dart';
import '../domain/i_character_repository.dart';

class CharacterRepository implements ICharacterRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: 'https://anapioficeandfire.com/api/',
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  CharacterModel _decode(Map<String, dynamic> row) {
    List<String> strings(String key) => (row[key] as List)
        .cast<String>()
        .where((value) => value.isNotEmpty)
        .toList();
    int? id(String url) => int.tryParse(url.split('/').last);
    final name = row['name'] as String;
    final aliases = strings('aliases');
    final characterId = id(row['url'] as String)!;
    return CharacterModel(
      id: characterId,
      name: name.isNotEmpty ? name : aliases.firstOrNull ?? '#$characterId',
      gender: row['gender'],
      culture: row['culture'],
      born: row['born'],
      titles: strings('titles'),
      aliases: aliases,
      playedBy: strings('playedBy'),
      fatherId: id(row['father'] as String),
    );
  }

  @override
  Future<List<CharacterModel>> getCharacters({
    String query = '',
    int page = 1,
  }) async {
    final response = await _client.get<List>(
      'characters',
      queryParameters: {
        'page': page,
        'pageSize': 20,
        if (query.trim().isNotEmpty) 'name': query.trim(),
      },
    );
    return response.data!.cast<Map<String, dynamic>>().map(_decode).toList();
  }

  @override
  Future<CharacterModel?> getCharacterById(int id) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        'characters/$id',
      );
      return _decode(response.data!);
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  void close() => _client.close(force: true);
}
