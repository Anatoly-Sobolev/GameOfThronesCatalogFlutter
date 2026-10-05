import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../list/character_list_cubit.dart';
import '../list/character_list_state.dart';
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

    return AppScaffold(
      title: strings.appTitle,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<CharacterListCubit>().search(value);
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: strings.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<CharacterListCubit>().search('');
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CharacterListCubit, CharacterListState>(
                builder: (context, state) {
                  if (state.status != CharacterListStatus.success) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.characters.isEmpty) {
                    return Center(
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
                    );
                  }

                  return ListView.separated(
                    key: const PageStorageKey('character-list'),
                    itemCount: state.characters.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final character = state.characters[index];
                      return CharacterCard(
                        key: ValueKey(character.id),
                        character: character,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
