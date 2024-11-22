import 'package:bloc_api_rick_and_morty/models/character_model.dart';
import 'package:equatable/equatable.dart';


abstract class EpisodeEvent extends Equatable {
  const EpisodeEvent();
  
  @override
  List<Object> get props => [];
}

class FetchEpisodes extends EpisodeEvent {
  final Result character;

  const FetchEpisodes(this.character);

  @override
  List<Object> get props => [character];
}
