import 'package:dio/dio.dart';

import 'character_dto.dart';

class CharacterApi {
  CharacterApi(this.client);
  final Dio client;
  Future<List<CharacterDto>> page(String query, int page) async {
    final result = await client.get<List>(
      'characters',
      queryParameters: {
        'page': page,
        'pageSize': 20,
        if (query.trim().isNotEmpty) 'name': query.trim(),
      },
    );
    return result.data!
        .cast<Map<String, dynamic>>()
        .map(CharacterDto.fromJson)
        .toList();
  }

  Future<CharacterDto> detail(int id) async {
    final result = await client.get<Map<String, dynamic>>('characters/$id');
    return CharacterDto.fromJson(result.data!);
  }
}
