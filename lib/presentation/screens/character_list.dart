import 'package:bloc_api_rick_and_morty/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CharacterList extends StatelessWidget {
  final List<Result> characters;
  final ScrollController scrollController;
  final bool isLoading;

  const CharacterList({
    super.key,
    required this.characters,
    required this.scrollController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.87,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: isLoading ? characters.length + 2 : characters.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < characters.length) {
          final result = characters[index];
          return GestureDetector(
            onTap: () {
              context.go('/characters', extra: result);
            },
            child: Card(
              child: Column(
                children: [
                  Hero(
                    tag: result.id!,
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/images/descarga.gif'),
                      image: NetworkImage(result.image!),
                    ),
                  ),
                  Text(
                    result.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
