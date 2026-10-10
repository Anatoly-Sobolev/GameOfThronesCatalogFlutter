import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/list/character_list_cubit.dart';
import '../bloc/list/character_list_state.dart';
import 'widgets/character_card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: context.read<CharacterListCubit>().state.query,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocBuilder<CharacterListCubit, CharacterListState>(
      builder: (context, state) => AppScaffold(
        title: strings.appTitle,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: context.read<CharacterListCubit>().search,
                decoration: InputDecoration(
                  hintText: strings.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: state.query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            context.read<CharacterListCubit>().search('');
                          },
                          icon: const Icon(Icons.clear),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(child: _CharacterListContent(state: state)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterListContent extends StatelessWidget {
  const _CharacterListContent({required this.state});

  final CharacterListState state;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return switch (state) {
      CharacterListLoading() => const Center(
        child: CircularProgressIndicator(),
      ),
      CharacterListNotFound() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 56),
            const SizedBox(height: 12),
            Text(
              strings.nothingFound,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(strings.tryAnotherQuery),
          ],
        ),
      ),
      CharacterListLoaded(:final characters) => ListView.separated(
        key: const PageStorageKey('character-list'),
        itemCount: characters.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final character = characters[index];
          return CharacterCard(
            key: ValueKey(character.id),
            character: character,
          );
        },
      ),
    };
  }
}
