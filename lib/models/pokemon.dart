import 'dart:convert';

import 'package:pokedex/models/pokemon_type.dart';

import 'stats.dart';

class Pokemon {
  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseXp,
    required this.types,
    required this.stats,
    required this.sprites,
    required this.evolvesFrom,
    required this.evolvesTo,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] as int,
      name: "${map['name'][0].toUpperCase()}${map['name'].substring(1)}",
      height: map['height'] as int,
      weight: map['weight'] as int,
      baseXp: map['base_xp'] as int,
      types: (map['types'] as List)
          .map((e) => PokemonTypeX.parse(e as String))
          .toList(),
      stats: Stats.fromMap(map['stats'] as Map<String, dynamic>),
      sprites: List<String>.from(map['sprites'] as List),
      evolvesFrom: map['evolvesFrom'] as int?,
      evolvesTo: map['evolvesTo'] as int?,
    );
  }

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  final int id;
  final String name;
  final int height;
  final int weight;
  final int baseXp;
  final List<PokemonType> types;
  final Stats stats;
  final List<String> sprites;
  final int? evolvesFrom;
  final int? evolvesTo;

  Pokemon copyWith({
    int? id,
    String? name,
    int? height,
    int? weight,
    int? baseXp,
    List<PokemonType>? types,
    Stats? stats,
    List<String>? sprites,
    int? evolvesFrom,
    int? evolvesTo,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      baseXp: baseXp ?? this.baseXp,
      types: types ?? this.types,
      stats: stats ?? this.stats,
      sprites: sprites ?? this.sprites,
      evolvesFrom: evolvesFrom ?? this.evolvesFrom,
      evolvesTo: evolvesTo ?? this.evolvesTo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'base_xp': baseXp,
      'types': types,
      'stats': stats.toMap(),
      'sprites': sprites,
      'evolvesFrom': evolvesFrom,
      'evolvesTo': evolvesTo,
    };
  }

  String toJson() => json.encode(toMap());
}
