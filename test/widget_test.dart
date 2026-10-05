import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_of_thrones_catalog/app.dart';

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
}
