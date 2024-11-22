import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
  
  @override
  List<Object> get props => [];
}

class FetchCharacters extends CharacterEvent {
  final int page;

  const FetchCharacters(this.page);

  @override
  List<Object> get props => [page];
}

class FetchCharactersByName extends CharacterEvent {
  final String name;

  const FetchCharactersByName(this.name);

  @override
  List<Object> get props => [name];
}
