import 'package:bloc_api_rick_and_morty/models/episode_model.dart';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class ApiProvider {
  final url = 'rickandmortyapi.com';
  List<Result> character = [];
  List<Episode> episode = [];

  Future<List<Result>> getResult(int page) async {
    final result = await http
        .get(Uri.https(url, "/api/character", {'page': page.toString()}));
    final response = characterFromJson(result.body);
    character.addAll(response.results!);
    return character;
  }

  Future<List<Character>> getCharacter(String query) async {
    final response = await http.get(Uri.https(url, '/api/character', {'name': query}));
    final characterResults = characterFromJson(response.body);

    List<Character> characters = characterResults.results!.map((result) {
      return Character(
        info: characterResults.info,
        results: [result],
      );
    }).toList();

    return characters;
  }

  Future<List<Episode>> getEpisode(Result character) async {
    episode = [];
    for (var i = 1; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episode.add(response);
    }
    return episode;
  }
}
