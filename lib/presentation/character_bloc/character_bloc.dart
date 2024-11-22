import 'package:bloc_api_rick_and_morty/data/api_rick_morty.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final ApiProvider apiProvider;

  CharacterBloc(this.apiProvider) : super(CharactersLoading()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<FetchCharactersByName>(_onFetchCharactersByName);
  }

  void _onFetchCharacters(FetchCharacters event, Emitter<CharacterState> emit) async {
    emit(CharactersLoading());
    try {
      final characters = await apiProvider.getResult(event.page);
      emit(CharactersLoaded(characters)); // Aquí emitimos directamente los resultados
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  void _onFetchCharactersByName(FetchCharactersByName event, Emitter<CharacterState> emit) async {
    emit(CharactersLoading());
    try {
      final characterList = await apiProvider.getCharacter(event.name);
      final characters = characterList.map((character) => character.results!).expand((x) => x).toList();
      emit(CharactersLoaded(characters)); // Aquí emitimos directamente los resultados
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}
