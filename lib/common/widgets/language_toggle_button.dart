import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../locale/locale_cubit.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;
    final strings = AppLocalizations.of(context)!;

    return IconButton(
      onPressed: context.read<LocaleCubit>().toggle,
      tooltip: strings.changeLanguage,
      icon: Text(
        locale.languageCode == 'ru' ? 'EN' : 'RU',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
