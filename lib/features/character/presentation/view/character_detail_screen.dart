import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/character_model.dart';
import '../detail/character_detail_cubit.dart';
import '../detail/character_detail_state.dart';
import 'widgets/character_avatar.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      builder: (context, state) {
        if (state.status == CharacterDetailStatus.loading) {
          return AppScaffold(
            title: strings.appTitle,
            showBackButton: true,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final character = state.character;
        if (character == null) {
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

        return AppScaffold(
          title: character.name,
          showBackButton: true,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(child: CharacterAvatar(character: character, radius: 48)),
              const SizedBox(height: 24),
              _DetailRow(
                label: strings.gender,
                value: _genderText(character.gender, strings),
              ),
              _DetailRow(
                label: strings.culture,
                value: _valueOrUnknown(character.culture, strings.unknown),
              ),
              _DetailRow(
                label: strings.born,
                value: _valueOrUnknown(character.born, strings.unknown),
              ),
              _DetailRow(
                label: strings.titles,
                value: _listOrUnknown(character.titles, strings.unknown),
              ),
              _DetailRow(
                label: strings.aliases,
                value: _listOrUnknown(character.aliases, strings.unknown),
              ),
              _DetailRow(
                label: strings.playedBy,
                value: _listOrUnknown(character.playedBy, strings.unknown),
              ),
              const SizedBox(height: 20),
              if (state.relatedCharacter != null)
                _RelatedCharacterCard(
                  character: state.relatedCharacter!,
                  title: strings.relatedCharacter,
                ),
            ],
          ),
        );
      },
    );
  }

  String _genderText(String value, AppLocalizations strings) {
    if (value == 'Male') {
      return strings.male;
    }
    if (value == 'Female') {
      return strings.female;
    }
    return strings.unknown;
  }

  String _valueOrUnknown(String value, String unknown) {
    if (value.isEmpty || value == 'Unknown') {
      return unknown;
    }
    return value;
  }

  String _listOrUnknown(List<String> values, String unknown) {
    return values.isEmpty ? unknown : values.join(', ');
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
