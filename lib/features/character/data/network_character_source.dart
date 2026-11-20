import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import '../domain/load_failure.dart';
import 'character_api.dart';
import 'character_dto.dart';

class NetworkCharacterSource {
  NetworkCharacterSource(this.api);
  final CharacterApi api;
  Future<List<CharacterDto>> page(String query, int page) =>
      _read(() => api.page(query, page));
  Future<CharacterDto> detail(int id) => _read(() => api.detail(id));

  Future<T> _read<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) throw LoadFailure.missing;
      throw switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => LoadFailure.timeout,
        DioExceptionType.connectionError => LoadFailure.offline,
        DioExceptionType.badResponse => LoadFailure.server,
        _ => LoadFailure.invalidResponse,
      };
    } on CheckedFromJsonException {
      throw LoadFailure.invalidResponse;
    } on TypeError {
      throw LoadFailure.invalidResponse;
    } on FormatException {
      throw LoadFailure.invalidResponse;
    }
  }
}
