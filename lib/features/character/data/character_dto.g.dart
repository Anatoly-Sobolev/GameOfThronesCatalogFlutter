// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDto _$CharacterDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CharacterDto', json, ($checkedConvert) {
      final val = CharacterDto(
        url: $checkedConvert('url', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        gender: $checkedConvert('gender', (v) => v as String),
        culture: $checkedConvert('culture', (v) => v as String),
        born: $checkedConvert('born', (v) => v as String),
        father: $checkedConvert('father', (v) => v as String),
        aliases: $checkedConvert(
          'aliases',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        titles: $checkedConvert(
          'titles',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        playedBy: $checkedConvert(
          'playedBy',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });
