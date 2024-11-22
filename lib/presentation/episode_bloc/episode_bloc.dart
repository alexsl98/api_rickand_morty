import 'package:bloc_api_rick_and_morty/data/api_rick_morty.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'episode_event.dart';
import 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final ApiProvider apiProvider;

  EpisodeBloc(this.apiProvider) : super(EpisodesLoading()) {
    on<FetchEpisodes>(_onFetchEpisodes);
  }

  void _onFetchEpisodes(FetchEpisodes event, Emitter<EpisodeState> emit) async {
    emit(EpisodesLoading());
    try {
      final episodes = await apiProvider.getEpisode(event.character);
      emit(EpisodesLoaded(episodes));
    } catch (e) {
      emit(EpisodesError(e.toString()));
    }
  }
}
