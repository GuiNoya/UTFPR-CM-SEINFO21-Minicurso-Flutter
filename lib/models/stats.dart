import 'dart:convert';

class Stats {
  Stats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory Stats.fromMap(Map<String, dynamic> map) {
    return Stats(
      hp: map['hp'] as int,
      attack: map['attack'] as int,
      defense: map['defense'] as int,
      specialAttack: map['special-attack'] as int,
      specialDefense: map['special-defense'] as int,
      speed: map['speed'] as int,
    );
  }

  factory Stats.fromJson(String source) =>
      Stats.fromMap(json.decode(source) as Map<String, dynamic>);

  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  Stats copyWith({
    int? hp,
    int? attack,
    int? defense,
    int? specialAttack,
    int? specialDefense,
    int? speed,
  }) {
    return Stats(
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      specialAttack: specialAttack ?? this.specialAttack,
      specialDefense: specialDefense ?? this.specialDefense,
      speed: speed ?? this.speed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'special-attack': specialAttack,
      'special-defense': specialDefense,
      'speed': speed,
    };
  }

  String toJson() => json.encode(toMap());
}
