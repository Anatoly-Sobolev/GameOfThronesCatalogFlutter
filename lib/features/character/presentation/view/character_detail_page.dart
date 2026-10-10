import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/i_character_repository.dart';
import '../bloc/detail/character_detail_cubit.dart';
import 'character_detail_screen.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({required this.characterId, super.key});

  final int? characterId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterDetailCubit(context.read<ICharacterRepository>())
            ..load(characterId ?? -1),
      child: const CharacterDetailScreen(),
    );
  }
}
