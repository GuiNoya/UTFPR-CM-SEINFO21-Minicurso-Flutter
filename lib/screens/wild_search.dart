import 'package:flutter/material.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class WildSearchScreen extends StatefulWidget {
  const WildSearchScreen({Key? key}) : super(key: key);

  static const routeName = '/wild-search';

  @override
  _WildSearchScreenState createState() => _WildSearchScreenState();
}

class _WildSearchScreenState extends State<WildSearchScreen> {
  String _currentSearch = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();
    final pokemonList = provider.pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(_currentSearch.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 10),
                decoration: const InputDecoration(
                  hintText: 'Pesquisar pokédex',
                ),
                onChanged: (value) => setState(() => _currentSearch = value),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 90,
                ),
                itemBuilder: (context, index) =>
                    PokemonCard(pokemon: pokemonList[index]),
                itemCount: pokemonList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
