import 'package:flutter/material.dart';

import '../../../domain/character_model.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({required this.character, this.radius = 28, super.key});

  final CharacterModel character;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      child: Text(
        character.name.substring(0, 1),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontSize: radius,
        ),
      ),
    );
  }
}
