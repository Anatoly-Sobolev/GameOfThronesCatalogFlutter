import 'package:go_router/go_router.dart';

import '../../features/character/presentation/view/character_detail_page.dart';
import '../../features/character/presentation/view/character_list_screen.dart';

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
            return CharacterDetailPage(characterId: id);
          },
        ),
      ],
    ),
  ],
);
