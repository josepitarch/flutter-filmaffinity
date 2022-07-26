import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:scrapper_filmaffinity/database/favorite_movie_database.dart';
import 'package:scrapper_filmaffinity/database/history_search_database.dart';
import 'package:scrapper_filmaffinity/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:scrapper_filmaffinity/pages/homepage_screen.dart';
import 'package:scrapper_filmaffinity/pages/metadata_movie_screen.dart';
import 'package:scrapper_filmaffinity/providers/favorite_movies_provider.dart';
import 'package:scrapper_filmaffinity/providers/homepage_provider.dart';
import 'package:scrapper_filmaffinity/providers/search_movie_provider.dart';
import 'package:scrapper_filmaffinity/providers/top_movies_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  FavoriteMovieDatabase.initDatabase();
  HistorySearchDatabase.initDatabase();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomepageProvider(), lazy: false),
      ChangeNotifierProvider(create: (_) => SearchMovieProvider(), lazy: false),
      ChangeNotifierProvider(
          create: (_) => FavoriteMovieProvider(), lazy: false),
      ChangeNotifierProvider(create: (_) => TopMoviesProvider(), lazy: false)
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Películas',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.l10n,
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'details': (_) => const MetadataMovieScreen()
        },
        theme: ThemeData.dark().copyWith(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(color: Colors.green, elevation: 0)));
  }
}
