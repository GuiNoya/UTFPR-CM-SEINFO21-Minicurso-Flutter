import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/captured_pokemon.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/widgets/custom_chip.dart';
import 'package:pokedex/widgets/custom_tabbar.dart';
import 'package:pokedex/widgets/stats_bar.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments! as DetailsScreenArguments;
    final provider = context.watch<PokemonProvider>();

    final capturedPokemon = args.capturedPokemonId != null
        ? provider.getCapturedPokemonById(args.capturedPokemonId!)
        : null;
    final pokemon =
        provider.getPokemonById(capturedPokemon?.pokemonId ?? args.pokemonId!);

    return Scaffold(
      backgroundColor: pokemon.types.first.color,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 40,
            right: 25,
            child: SizedBox.square(
              dimension: 180,
              child: Image.asset(
                'assets/pokeball.png',
                color: Colors.white.withAlpha(70),
              ),
            ),
          ),
          Column(
            children: [
              _PokemonHead(
                pokemon: pokemon,
                capturedPokemon: capturedPokemon,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _PokemonStats(
                  pokemon: pokemon,
                  capturedPokemon: capturedPokemon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PokemonHead extends StatelessWidget {
  const _PokemonHead({
    Key? key,
    required this.pokemon,
    required this.capturedPokemon,
  }) : super(key: key);

  final Pokemon pokemon;
  final CapturedPokemon? capturedPokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(pokemon.name, style: Theme.of(context).textTheme.headline6),
              const Expanded(child: SizedBox()),
              Text('#${pokemon.id.toString().padLeft(3, '0')}')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final type in pokemon.types)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CustomChip(
                    type: type,
                    fontSize: 9,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 150,
              width: 150,
              child: Hero(
                tag: 'pkm_img_${capturedPokemon?.id ?? pokemon.id}',
                child: CachedNetworkImage(
                  imageUrl: pokemon.sprites[0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          if (capturedPokemon != null && pokemon.evolvesTo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final provider = context.read<PokemonProvider>();
                    provider.evolvePokemon(capturedPokemon!);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                  child: const Text('Evoluir'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PokemonStats extends StatelessWidget {
  const _PokemonStats({
    Key? key,
    required this.pokemon,
    required this.capturedPokemon,
  }) : super(key: key);

  final Pokemon pokemon;
  final CapturedPokemon? capturedPokemon;

  Widget _getPanel(index) {
    switch (index) {
      case 0:
        return _PokemonAbout(pokemon: pokemon);
      case 1:
        return _PokemonStatus(pokemon: pokemon);
      default:
        return Container();
    }
  }

  void _capturePokemon(BuildContext context) {
    final provider = context.read<PokemonProvider>();
    final random = Random();
    provider.capturePokemon(
      CapturedPokemon(
        id: DateTime.now().millisecondsSinceEpoch,
        pokemonId: pokemon.id,
        xp: random.nextInt(pokemon.baseXp),
        hp: random.nextInt(pokemon.stats.hp),
      ),
    );
    Navigator.popUntil(
      context,
      ModalRoute.withName(HomeScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        children: [
          Expanded(
            child: CustomTabBar(
              labels: const [Text('Sobre'), Text('Status')],
              getContent: _getPanel,
            ),
          ),
          if (capturedPokemon == null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _capturePokemon(context),
                child: const Text('Capturar'),
              ),
            ),
        ],
      ),
    );
  }
}

class _PokemonAbout extends StatelessWidget {
  const _PokemonAbout({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.caption!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Altura: ${pokemon.height / 10}m'),
            const SizedBox(height: 8),
            Text('Peso: ${pokemon.weight / 10}kg'),
          ],
        ),
      ),
    );
  }
}

class _PokemonStatus extends StatelessWidget {
  const _PokemonStatus({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 9),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView(
          children: <Widget>[
            _StatusItem(label: 'HP', value: pokemon.stats.hp),
            const SizedBox(height: 6),
            _StatusItem(label: 'Attack', value: pokemon.stats.attack),
            const SizedBox(height: 6),
            _StatusItem(label: 'Defense', value: pokemon.stats.defense),
            const SizedBox(height: 6),
            _StatusItem(label: 'Sp. Atk', value: pokemon.stats.specialAttack),
            const SizedBox(height: 6),
            _StatusItem(label: 'Sp. Def', value: pokemon.stats.specialDefense),
            const SizedBox(height: 6),
            _StatusItem(label: 'Speed', value: pokemon.stats.speed),
          ],
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  const _StatusItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Expanded(
          flex: 4,
          child: StatsBar(
            value: value,
            maxValue: 255,
            size: 10,
          ),
        ),
      ],
    );
  }
}

class DetailsScreenArguments {
  const DetailsScreenArguments({this.pokemonId, this.capturedPokemonId});

  final int? pokemonId;
  final int? capturedPokemonId;
}
