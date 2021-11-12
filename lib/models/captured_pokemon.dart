import 'dart:convert';

class CapturedPokemon {
  CapturedPokemon({
    required this.id,
    required this.pokemonId,
    required this.xp,
    required this.hp,
  });

  factory CapturedPokemon.fromMap(Map<String, dynamic> map) {
    return CapturedPokemon(
      id: map['id'] as int,
      pokemonId: map['pokemon_id'] as int,
      xp: map['xp'] as int,
      hp: map['hp'] as int,
    );
  }

  factory CapturedPokemon.fromJson(String source) =>
      CapturedPokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  final int id;
  final int pokemonId;
  final int xp;
  final int hp;

  CapturedPokemon copyWith({
    int? id,
    int? pokemonId,
    int? xp,
    int? hp,
  }) {
    return CapturedPokemon(
      id: id ?? this.id,
      pokemonId: pokemonId ?? this.pokemonId,
      xp: xp ?? this.xp,
      hp: hp ?? this.hp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pokemon_id': pokemonId,
      'xp': xp,
      'hp': hp,
    };
  }

  String toJson() => json.encode(toMap());
}
