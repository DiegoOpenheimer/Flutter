// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Pokemon pokemonFromJson(String str) {
  final jsonData = json.decode(str);
  return Pokemon.fromJson(jsonData);
}

String pokemonToJson(Pokemon data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Pokemon {
  List<Ability> abilities;
  int baseExperience;
  List<Species> forms;
  List<GameIndex> gameIndices;
  int height;
  List<dynamic> heldItems;
  int id;
  bool isDefault;
  String locationAreaEncounters;
  List<Move> moves;
  String name;
  int order;
  Species species;
  Sprites sprites;
  List<Stat> stats;
  List<Type> types;
  int weight;
  String img;

  Pokemon({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.gameIndices,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    this.name,
    this.order,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
    this.img,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => new Pokemon(
    abilities: new List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
    baseExperience: json["base_experience"],
    forms: new List<Species>.from(json["forms"].map((x) => Species.fromJson(x))),
    gameIndices: new List<GameIndex>.from(json["game_indices"].map((x) => GameIndex.fromJson(x))),
    height: json["height"],
    heldItems: new List<dynamic>.from(json["held_items"].map((x) => x)),
    id: json["id"],
    isDefault: json["is_default"],
    locationAreaEncounters: json["location_area_encounters"],
    moves: new List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
    name: json["name"],
    order: json["order"],
    species: Species.fromJson(json["species"]),
    sprites: Sprites.fromJson(json["sprites"]),
    stats: new List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
    types: new List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    weight: json["weight"],
    img: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['id']}.png'
  );

  Map<String, dynamic> toJson() => {
    "abilities": new List<dynamic>.from(abilities.map((x) => x.toJson())),
    "base_experience": baseExperience,
    "forms": new List<dynamic>.from(forms.map((x) => x.toJson())),
    "game_indices": new List<dynamic>.from(gameIndices.map((x) => x.toJson())),
    "height": height,
    "held_items": new List<dynamic>.from(heldItems.map((x) => x)),
    "id": id,
    "is_default": isDefault,
    "location_area_encounters": locationAreaEncounters,
    "moves": new List<dynamic>.from(moves.map((x) => x.toJson())),
    "name": name,
    "order": order,
    "species": species.toJson(),
    "sprites": sprites.toJson(),
    "stats": new List<dynamic>.from(stats.map((x) => x.toJson())),
    "types": new List<dynamic>.from(types.map((x) => x.toJson())),
    "weight": weight,
  };

  @override
  String toString() => 'Pokemon($name - $weight - $height)';
}

class Ability {
  Species ability;
  bool isHidden;
  int slot;

  Ability({
    this.ability,
    this.isHidden,
    this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => new Ability(
    ability: Species.fromJson(json["ability"]),
    isHidden: json["is_hidden"],
    slot: json["slot"],
  );

  Map<String, dynamic> toJson() => {
    "ability": ability.toJson(),
    "is_hidden": isHidden,
    "slot": slot,
  };
}

class Species {
  String name;
  String url;

  Species({
    this.name,
    this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) => new Species(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class GameIndex {
  int gameIndex;
  Species version;

  GameIndex({
    this.gameIndex,
    this.version,
  });

  factory GameIndex.fromJson(Map<String, dynamic> json) => new GameIndex(
    gameIndex: json["game_index"],
    version: Species.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "game_index": gameIndex,
    "version": version.toJson(),
  };
}

class Move {
  Species move;
  List<VersionGroupDetail> versionGroupDetails;

  Move({
    this.move,
    this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) => new Move(
    move: Species.fromJson(json["move"]),
    versionGroupDetails: new List<VersionGroupDetail>.from(json["version_group_details"].map((x) => VersionGroupDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "move": move.toJson(),
    "version_group_details": new List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
  };
}

class VersionGroupDetail {
  int levelLearnedAt;
  Species moveLearnMethod;
  Species versionGroup;

  VersionGroupDetail({
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) => new VersionGroupDetail(
    levelLearnedAt: json["level_learned_at"],
    moveLearnMethod: Species.fromJson(json["move_learn_method"]),
    versionGroup: Species.fromJson(json["version_group"]),
  );

  Map<String, dynamic> toJson() => {
    "level_learned_at": levelLearnedAt,
    "move_learn_method": moveLearnMethod.toJson(),
    "version_group": versionGroup.toJson(),
  };
}

class Sprites {
  String backDefault;
  dynamic backFemale;
  String backShiny;
  dynamic backShinyFemale;
  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;

  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) => new Sprites(
    backDefault: json["back_default"],
    backFemale: json["back_female"],
    backShiny: json["back_shiny"],
    backShinyFemale: json["back_shiny_female"],
    frontDefault: json["front_default"],
    frontFemale: json["front_female"],
    frontShiny: json["front_shiny"],
    frontShinyFemale: json["front_shiny_female"],
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_female": backFemale,
    "back_shiny": backShiny,
    "back_shiny_female": backShinyFemale,
    "front_default": frontDefault,
    "front_female": frontFemale,
    "front_shiny": frontShiny,
    "front_shiny_female": frontShinyFemale,
  };
}

class Stat {
  int baseStat;
  int effort;
  Species stat;

  Stat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => new Stat(
    baseStat: json["base_stat"],
    effort: json["effort"],
    stat: Species.fromJson(json["stat"]),
  );

  Map<String, dynamic> toJson() => {
    "base_stat": baseStat,
    "effort": effort,
    "stat": stat.toJson(),
  };
}

class Type {
  int slot;
  Species type;

  Type({
    this.slot,
    this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => new Type(
    slot: json["slot"],
    type: Species.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}
