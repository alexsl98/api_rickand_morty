import 'package:bloc_api_rick_and_morty/models/episode_model.dart';
import 'package:equatable/equatable.dart';

abstract class EpisodeState extends Equatable {
  const EpisodeState();
  
  @override
  List<Object> get props => [];
}

class EpisodesLoading extends EpisodeState {}

class EpisodesLoaded extends EpisodeState {
  final List<Episode> episodes;

  const EpisodesLoaded(this.episodes);

  @override
  List<Object> get props => [episodes];
}

class EpisodesError extends EpisodeState {
  final String message;

  const EpisodesError(this.message);

  @override
  List<Object> get props => [message];
}
