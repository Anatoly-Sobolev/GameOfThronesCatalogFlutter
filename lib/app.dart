import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/locale/locale_cubit.dart';
import 'common/navigation/app_router.dart';
import 'common/theme/app_theme.dart';
import 'common/theme/theme_cubit.dart';
import 'features/character/data/character_repository.dart';
import 'features/character/domain/i_character_repository.dart';
import 'features/character/presentation/bloc/list/character_list_cubit.dart';
import 'l10n/app_localizations.dart';

class GameOfThronesApp extends StatelessWidget {
  const GameOfThronesApp({required this.initialLocale, super.key});

  final Locale initialLocale;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ICharacterRepository>(
      create: (context) => CharacterRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => LocaleCubit(initialLocale)),
          BlocProvider(
            create: (context) =>
                CharacterListCubit(context.read<ICharacterRepository>())
                  ..load(),
          ),
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
    );
  }
}
