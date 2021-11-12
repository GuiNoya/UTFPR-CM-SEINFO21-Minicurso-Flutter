import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_type.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.type,
    this.fontSize = 6,
  }) : super(key: key);

  final PokemonType type;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fontSize / 2,
        vertical: fontSize / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withAlpha(80),
      ),
      child: Text(
        type.value.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
