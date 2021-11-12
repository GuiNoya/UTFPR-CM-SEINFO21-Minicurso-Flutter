import 'package:flutter/painting.dart';
import 'package:pokedex/app_colors.dart';

enum PokemonType {
  grass,
  poison,
  fire,
  flying,
  water,
  bug,
  normal,
  electric,
  ground,
  fairy,
  fighting,
  psychic,
  rock,
  steel,
  ice,
  ghost,
  dragon,
  dark,
  monster,
  unknown,
}

extension PokemonTypeX on PokemonType {
  String get value => toString().split('.').last;

  static PokemonType parse(String rawValue) {
    return PokemonType.values.firstWhere(
      (element) => element.value == rawValue.toLowerCase(),
      orElse: () => PokemonType.unknown,
    );
  }

  Color get color {
    switch (this) {
      case PokemonType.grass:
        return AppColors.lightGreen;

      case PokemonType.bug:
        return AppColors.lightTeal;

      case PokemonType.fire:
        return AppColors.lightRed;

      case PokemonType.water:
        return AppColors.lightBlue;

      case PokemonType.fighting:
        return AppColors.red;

      case PokemonType.normal:
        return AppColors.beige;

      case PokemonType.electric:
        return AppColors.lightYellow;

      case PokemonType.psychic:
        return AppColors.lightPink;

      case PokemonType.poison:
        return AppColors.lightPurple;

      case PokemonType.ghost:
        return AppColors.purple;

      case PokemonType.ground:
        return AppColors.darkBrown;

      case PokemonType.rock:
        return AppColors.lightBrown;

      case PokemonType.dark:
        return AppColors.black;

      case PokemonType.dragon:
        return AppColors.violet;

      case PokemonType.fairy:
        return AppColors.pink;

      case PokemonType.flying:
        return AppColors.lilac;

      case PokemonType.ice:
        return AppColors.lightCyan;

      case PokemonType.steel:
        return AppColors.grey;

      default:
        return AppColors.lightBlue;
    }
  }
}
