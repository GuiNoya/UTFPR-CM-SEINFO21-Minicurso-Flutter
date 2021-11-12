import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app_colors.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/screens/details.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/wild_search.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = GoogleFonts.pressStart2pTextTheme(theme.textTheme);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
          ),
          primarySwatch: Colors.red,
          brightness: Brightness.light,
          textTheme: textTheme,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: textTheme.headline6,
            iconTheme: const IconThemeData(color: Colors.red),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.softGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48),
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.square(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          WildSearchScreen.routeName: (context) => const WildSearchScreen(),
          DetailsScreen.routeName: (context) => const DetailsScreen(),
        },
      ),
    );
  }
}
