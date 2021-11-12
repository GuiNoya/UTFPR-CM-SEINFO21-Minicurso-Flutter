import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/models/captured_pokemon.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonProvider with ChangeNotifier {
  PokemonProvider() {
    loadPokemons();
  }

  List<Pokemon> _pokemons = [];
  final List<CapturedPokemon> _capturedPokemons = [];

  UnmodifiableListView<Pokemon> get pokemons {
    return UnmodifiableListView(_pokemons);
  }

  Pokemon getPokemonById(int id) {
    return _pokemons.firstWhere((pokemon) => pokemon.id == id);
  }

  UnmodifiableListView<CapturedPokemon> get capturedPokemons {
    return UnmodifiableListView(_capturedPokemons);
  }

  CapturedPokemon getCapturedPokemonById(int id) {
    return _capturedPokemons.firstWhere((pokemon) => pokemon.id == id);
  }

  Future<void> loadPokemons() {
    return rootBundle.loadString('assets/pokemons.json').then((jsonString) {
      final json = jsonDecode(jsonString) as List;
      _pokemons = json
          .map((pokemon) => Pokemon.fromMap(pokemon as Map<String, dynamic>))
          .toList();
      notifyListeners();
    });
  }

  void capturePokemon(CapturedPokemon capturedPokemon) {
    _capturedPokemons.add(capturedPokemon);
    notifyListeners();
  }

  void evolvePokemon(CapturedPokemon capturedPokemon) {
    final pokemon = getPokemonById(capturedPokemon.pokemonId);
    final capturedIndex = _capturedPokemons.indexOf(capturedPokemon);
    if (pokemon.evolvesTo == null || capturedIndex == -1) return;
    _capturedPokemons[capturedIndex] =
        capturedPokemon.copyWith(pokemonId: pokemon.evolvesTo);
    notifyListeners();
  }
}
