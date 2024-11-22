import 'package:bloc_api_rick_and_morty/data/api_rick_morty.dart';
import 'package:bloc_api_rick_and_morty/presentation/character_bloc/character_bloc.dart';
import 'package:bloc_api_rick_and_morty/presentation/character_bloc/character_event.dart';
import 'package:bloc_api_rick_and_morty/presentation/character_bloc/character_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _circleLoading();
    }

    final apiProvider = ApiProvider(); // Crea una instancia de ApiProvider

    return BlocProvider(
      create: (context) => CharacterBloc(apiProvider)..add(FetchCharactersByName(query)), // Pasa apiProvider
      child: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharactersLoading) {
            return _circleLoading();
          } else if (state is CharactersLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return ListTile(
                  onTap: () {
                    context.go('/characters', extra: character);
                  },
                  title: Text(character.name!),
                  leading: Hero(
                    tag: character.id!,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(character.image!),
                    ),
                  ),
                );
              },
            );
          } else if (state is CharactersError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return _circleLoading();
          }
        },
      ),
    );
  }

  Widget _circleLoading() {
    return const Center(
      child: CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage('assets/images/descarga.gif'),
      ),
    );
  }
}
