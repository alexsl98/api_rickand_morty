import 'dart:convert';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));
String characterToJson(Character data) => json.encode(data.toJson());

class Character {
  Info? info;
  List<Result>? results;

  Character({
    this.info,
    this.results,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };

  // Getters para propiedades de Result
  get episode => results?.map((result) => result.episode).toList() ?? [];
  get name => results?.map((result) => result.name).toList() ?? [];
  get id => results?.map((result) => result.id).toList() ?? [];
  get image => results?.map((result) => result.image).toList() ?? [];
  get status => results?.map((result) => result.status).toList() ?? [];
  get species => results?.map((result) => result.species).toList() ?? [];
  get origin => results?.map((result) => result.origin).toList() ?? [];
}

class Info {
  int? count;
  int? pages;
  String? next;
  dynamic prev;

  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Result {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Location? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  Result({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null ? [] : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}

class Location {
  String? name;
  String? url;

  Location({
    this.name,
    this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
