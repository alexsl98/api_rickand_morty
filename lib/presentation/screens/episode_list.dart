import 'package:bloc_api_rick_and_morty/presentation/episode_bloc/episode_bloc.dart';
import 'package:bloc_api_rick_and_morty/presentation/episode_bloc/episode_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.35,
      child: BlocBuilder<EpisodeBloc, EpisodeState>(
        builder: (context, state) {
          if (state is EpisodesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EpisodesLoaded) {
            return ListView.builder(
              itemCount: state.episodes.length,
              itemBuilder: (context, index) {
                final episode = state.episodes[index];
                return ListTile(
                  leading: Text(episode.episode!),
                  title: Text(episode.name!),
                  trailing: Text(episode.airDate!),
                );
              },
            );
          } else if (state is EpisodesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
