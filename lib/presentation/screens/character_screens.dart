import 'package:bloc_api_rick_and_morty/data/api_rick_morty.dart';
import 'package:bloc_api_rick_and_morty/models/character_model.dart';
import 'package:bloc_api_rick_and_morty/presentation/episode_bloc/episode_bloc.dart';
import 'package:bloc_api_rick_and_morty/presentation/episode_bloc/episode_event.dart';
import 'package:bloc_api_rick_and_morty/presentation/screens/episode_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CharacterScreens extends StatelessWidget {
  final Result result;
  const CharacterScreens({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(result.name!),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                  tag: result.id!,
                  child: Image.network(
                    result.image!,
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardData('Status', result.status!),
                  cardData('Specie', result.species!),
                  cardData('Origin', result.origin!.name!)
                ],
              ),
            ),
            const Text('Episodio', style: TextStyle(fontSize: 18)),
            BlocProvider(
              create: (context) => EpisodeBloc(ApiProvider())..add(FetchEpisodes(result)),
              child: EpisodeList(size: size),
            )
          ],
        ),
      ),
    );
  }

  Widget cardData(String text1, String text2) {
    return Expanded(
        child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(text1),
          Text(
            text2,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ));
  }
}
