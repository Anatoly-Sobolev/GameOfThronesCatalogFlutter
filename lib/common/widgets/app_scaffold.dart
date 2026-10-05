import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../locale/locale_cubit.dart';
import '../theme/theme_cubit.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    required this.body,
    this.showBackButton = false,
    super.key,
  });

  final String title;
  final Widget body;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;
    final themeMode = context.watch<ThemeCubit>().state;
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: showBackButton,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: context.read<LocaleCubit>().toggle,
            tooltip: strings.changeLanguage,
            icon: Text(
              locale.languageCode == 'ru' ? 'EN' : 'RU',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: context.read<ThemeCubit>().toggle,
            tooltip: strings.changeTheme,
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(child: body),
    );
  }
}
