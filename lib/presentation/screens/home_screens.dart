import 'package:bloc_api_rick_and_morty/presentation/character_bloc/character_bloc.dart';
import 'package:bloc_api_rick_and_morty/presentation/character_bloc/character_event.dart';
import 'package:bloc_api_rick_and_morty/presentation/character_bloc/character_state.dart';
import 'package:bloc_api_rick_and_morty/presentation/screens/character_list.dart';
import 'package:bloc_api_rick_and_morty/presentation/widgets/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final characterBloc = BlocProvider.of<CharacterBloc>(context);
    characterBloc.add(FetchCharacters(page));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        characterBloc.add(FetchCharacters(page));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchCharacter());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharactersLoaded) {
              return CharacterList(
                characters: state.characters,
                scrollController: scrollController,
                isLoading: isLoading,
              );
            } else if (state is CharactersError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
