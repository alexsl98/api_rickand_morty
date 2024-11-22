import 'package:bloc_api_rick_and_morty/models/character_model.dart';
import 'package:equatable/equatable.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();
  
  @override
  List<Object> get props => [];
}

class CharactersLoading extends CharacterState {}

class CharactersLoaded extends CharacterState {
  final List<Result> characters;

  const CharactersLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharactersError extends CharacterState {
  final String message;

  const CharactersError(this.message);

  @override
  List<Object> get props => [message];
}
