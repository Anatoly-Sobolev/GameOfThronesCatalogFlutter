import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/character_model.dart';
import '../bloc/detail/character_detail_cubit.dart';
import '../bloc/detail/character_detail_state.dart';
import '../utils/character_format.dart';
import 'widgets/character_avatar.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      builder: (context, state) => switch (state) {
        CharacterDetailLoading() => AppScaffold(
          title: strings.appTitle,
          showBackButton: true,
          body: const Center(child: CircularProgressIndicator()),
        ),
        CharacterDetailNotFound() => AppScaffold(
          title: strings.characterNotFound,
          showBackButton: true,
          body: Center(
            child: Text(
              strings.characterNotFound,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        CharacterDetailLoaded(:final character, :final father) => AppScaffold(
          title: character.name,
          showBackButton: true,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(child: CharacterAvatar(character: character, radius: 48)),
              const SizedBox(height: 24),
              _DetailRow(
                label: strings.gender,
                value: character.gender.genderLabel(strings),
              ),
              _DetailRow(
                label: strings.culture,
                value: character.culture.valueOrUnknown(strings),
              ),
              _DetailRow(
                label: strings.born,
                value: character.born.valueOrUnknown(strings),
              ),
              _DetailRow(
                label: strings.titles,
                value: character.titles.valuesOrUnknown(strings),
              ),
              _DetailRow(
                label: strings.aliases,
                value: character.aliases.valuesOrUnknown(strings),
              ),
              _DetailRow(
                label: strings.playedBy,
                value: character.playedBy.valuesOrUnknown(strings),
              ),
              const SizedBox(height: 20),
              if (father != null)
                _RelatedCharacterCard(character: father, title: strings.father),
            ],
          ),
        ),
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: Theme.of(context).textTheme.titleSmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _RelatedCharacterCard extends StatelessWidget {
  const _RelatedCharacterCard({required this.character, required this.title});

  final CharacterModel character;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.push('/characters/${character.id}'),
        leading: CharacterAvatar(character: character, radius: 22),
        title: Text(title),
        subtitle: Text(character.name),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
