import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_of_thrones_catalog/app.dart';
import 'package:game_of_thrones_catalog/common/navigation/app_router.dart';
import 'package:game_of_thrones_catalog/features/character/data/character_repository.dart';
import 'package:game_of_thrones_catalog/features/character/presentation/bloc/detail/character_detail_cubit.dart';
import 'package:game_of_thrones_catalog/features/character/presentation/bloc/detail/character_detail_state.dart';

void main() {
  testWidgets('shows and filters characters', (tester) async {
    await tester.pumpWidget(
      const GameOfThronesApp(initialLocale: Locale('ru')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Jon Snow'), findsOneWidget);
    expect(find.text('Daenerys Targaryen'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Arya');
    await tester.pump();

    expect(find.text('Arya Stark'), findsOneWidget);
    expect(find.text('Jon Snow'), findsNothing);
  });

  testWidgets('updates localized titles after locale change', (tester) async {
    await tester.pumpWidget(
      const GameOfThronesApp(initialLocale: Locale('ru')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Персонажи Игры престолов'), findsOneWidget);

    await tester.tap(find.text('EN'));
    await tester.pumpAndSettle();

    expect(find.text('Game of Thrones characters'), findsOneWidget);
  });

  testWidgets('shows not found screen for invalid character id', (
    tester,
  ) async {
    appRouter.go('/characters/abc');
    addTearDown(() => appRouter.go('/'));

    await tester.pumpWidget(
      const GameOfThronesApp(initialLocale: Locale('ru')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Персонаж не найден'), findsWidgets);
  });

  test('loads a real father relation from the model', () async {
    final cubit = CharacterDetailCubit(CharacterRepository());
    await cubit.load(5);
    final state = cubit.state as CharacterDetailLoaded;

    expect(state.character.name, 'Sansa Stark');
    expect(state.father?.name, 'Eddard Stark');

    await cubit.close();
  });
}
