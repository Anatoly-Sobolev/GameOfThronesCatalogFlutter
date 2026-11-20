import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_of_thrones_catalog/app.dart';
import 'package:game_of_thrones_catalog/common/navigation/app_router.dart';
import 'package:game_of_thrones_catalog/features/character/domain/character_model.dart';
import 'package:game_of_thrones_catalog/features/character/domain/i_character_repository.dart';
import 'package:game_of_thrones_catalog/features/character/presentation/bloc/detail/character_detail_cubit.dart';
import 'package:game_of_thrones_catalog/features/character/presentation/bloc/detail/character_detail_state.dart';

class FixtureRepository implements ICharacterRepository {
  const FixtureRepository();
  static final entries =
      [
            'Jon Snow',
            'Daenerys Targaryen',
            'Arya Stark',
            'Eddard Stark',
            'Sansa Stark',
          ]
          .asMap()
          .entries
          .map(
            (entry) => CharacterModel(
              id: entry.key + 1,
              name: entry.value,
              gender: '',
              culture: '',
              born: '',
              titles: [],
              aliases: [],
              playedBy: [],
              fatherId: entry.key == 4 ? 4 : null,
            ),
          )
          .toList();
  @override
  Future<List<CharacterModel>> getCharacters({
    String query = '',
    int page = 1,
  }) async => page == 1
      ? entries.where((item) => item.name.contains(query)).toList()
      : [];
  @override
  Future<CharacterModel?> getCharacterById(int id) async =>
      entries.where((item) => item.id == id).firstOrNull;
}

void main() {
  testWidgets('shows and filters characters', (tester) async {
    await tester.pumpWidget(
      const GameOfThronesApp(
        repository: FixtureRepository(),
        initialLocale: Locale('ru'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Jon Snow'), findsOneWidget);
    expect(find.text('Daenerys Targaryen'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Arya');
    await tester.pump(const Duration(milliseconds: 401));
    await tester.pumpAndSettle();

    expect(find.text('Arya Stark'), findsOneWidget);
    expect(find.text('Jon Snow'), findsNothing);
  });

  testWidgets('updates localized titles after locale change', (tester) async {
    await tester.pumpWidget(
      const GameOfThronesApp(
        repository: FixtureRepository(),
        initialLocale: Locale('ru'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Персонажи Игры престолов'), findsOneWidget);

    await tester.tap(find.text('RU'));
    await tester.pumpAndSettle();

    expect(find.text('Game of Thrones characters'), findsOneWidget);
  });

  testWidgets('shows not found screen for invalid character id', (
    tester,
  ) async {
    appRouter.go('/characters/abc');
    addTearDown(() => appRouter.go('/'));

    await tester.pumpWidget(
      const GameOfThronesApp(
        repository: FixtureRepository(),
        initialLocale: Locale('ru'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Персонаж не найден'), findsWidgets);
  });

  test('loads a real father relation from the model', () async {
    final cubit = CharacterDetailCubit(const FixtureRepository());
    await cubit.load(5);
    final state = cubit.state as CharacterDetailLoaded;

    expect(state.character.name, 'Sansa Stark');
    expect(state.father?.name, 'Eddard Stark');

    await cubit.close();
  });
}
