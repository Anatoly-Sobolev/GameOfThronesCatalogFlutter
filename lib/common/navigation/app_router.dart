import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/character/presentation/view/character_detail_page.dart';
import '../../features/character/presentation/view/character_list_screen.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/app_scaffold.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CharacterListScreen(),
      routes: [
        GoRoute(
          path: 'characters/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            return id == null
                ? const _NotFoundScreen()
                : CharacterDetailPage(characterId: id);
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const _NotFoundScreen(),
);

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return AppScaffold(
      title: strings.characterNotFound,
      showBackButton: true,
      body: Center(
        child: Text(
          strings.characterNotFound,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
