import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/character_model.dart';
import 'character_avatar.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({required this.character, super.key});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/characters/${character.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CharacterAvatar(character: character),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      character.culture.isEmpty
                          ? character.gender
                          : character.culture,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
