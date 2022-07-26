import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrapper_filmaffinity/models/favorite_movie.dart';
import 'package:scrapper_filmaffinity/providers/favorite_movies_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scrapper_filmaffinity/widgets/movie_item.dart';
import 'package:scrapper_filmaffinity/widgets/title_page.dart';

class FavouritesMovies extends StatelessWidget {
  const FavouritesMovies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Consumer(builder: (context, FavoriteMovieProvider provider, _) {
      provider.getFavoriteMovies();
      return provider.favoriteMovies.isEmpty
          ? Center(child: Text(localization.no_favorites))
          : FavoriteMoviesList(provider.favoriteMovies);
    });
  }
}

class FavoriteMoviesList extends StatelessWidget {
  final List<FavoriteMovie> favoriteMovies;

  const FavoriteMoviesList(this.favoriteMovies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitlePage(localization.title_favorite_movies_page),
          Expanded(
            child: ListView.builder(
                itemCount: favoriteMovies.length,
                itemBuilder: (_, index) {
                  return MovieItem(
                    movie: favoriteMovies[index].toMovie(),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
