import 'package:flutter/material.dart';
import 'package:pokedex/models/captured_pokemon.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/screens/wild_search.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentSearch = '';

  List<CapturedPokemon> getCapturedPokemonList(PokemonProvider provider) {
    if (_currentSearch.isEmpty) {
      return provider.capturedPokemons;
    }

    final filteredPokemonIds = provider.pokemons
        .where(
          (pokemon) =>
              pokemon.name.toLowerCase().contains(_currentSearch.toLowerCase()),
        )
        .map((e) => e.id)
        .toList();

    return provider.capturedPokemons
        .where((pokemon) => filteredPokemonIds.contains(pokemon.pokemonId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();
    final capturedPokemonList = getCapturedPokemonList(provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pokemons'),
      ),
      floatingActionButton: const _WildPokemonFab(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 10),
                decoration: const InputDecoration(
                  hintText: 'Pesquisar meus pokemons',
                ),
                onChanged: (value) {
                  setState(() {
                    _currentSearch = value;
                  });
                },
              ),
            ),
            Expanded(
              child: _WildPokemonList(
                capturedPokemonList: capturedPokemonList,
                provider: provider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WildPokemonList extends StatelessWidget {
  const _WildPokemonList({
    Key? key,
    required this.capturedPokemonList,
    required this.provider,
  }) : super(key: key);

  final List<CapturedPokemon> capturedPokemonList;
  final PokemonProvider provider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox.square(
            dimension: 200,
            child: Image.asset(
              'assets/pokeball.png',
              color: Colors.black.withAlpha(50),
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            final capturedPokemon = capturedPokemonList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: PokemonCard(
                pokemon: provider.getPokemonById(capturedPokemon.pokemonId),
                capturedPokemon: capturedPokemon,
              ),
            );
          },
          itemCount: capturedPokemonList.length,
        ),
      ],
    );
  }
}

class _WildPokemonFab extends StatelessWidget {
  const _WildPokemonFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, WildSearchScreen.routeName);
      },
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.cyan, width: 3),
      ),
      icon: const Icon(
        Icons.search,
        color: Colors.cyan,
      ),
      label: const Text(
        'Pokemons\nselvagens',
        style: TextStyle(fontSize: 8, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
