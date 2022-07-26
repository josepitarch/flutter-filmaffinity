import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:diacritic/diacritic.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'package:scrapper_filmaffinity/database/favorite_movie_database.dart';

import 'package:scrapper_filmaffinity/models/movie.dart';
import 'package:scrapper_filmaffinity/providers/favorite_movies_provider.dart';
import 'package:scrapper_filmaffinity/providers/homepage_provider.dart';
import 'package:scrapper_filmaffinity/services/metadata_movie_service.dart';
import 'package:scrapper_filmaffinity/ui/box_decoration.dart';
import 'package:scrapper_filmaffinity/ui/custom_icons.dart';
import 'package:scrapper_filmaffinity/utils/flags.dart';
import 'package:scrapper_filmaffinity/utils/justwatch.dart';
import 'package:scrapper_filmaffinity/widgets/justwatch_item.dart';
import 'package:scrapper_filmaffinity/widgets/review_item.dart';
import 'package:scrapper_filmaffinity/widgets/shimmer/metadata_shimmer.dart';
import 'package:scrapper_filmaffinity/widgets/title_section.dart';

class MetadataMovieScreen extends StatelessWidget {
  const MetadataMovieScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    try {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final bool isOpened = arguments['isOpened'] ?? false;
      final String id = arguments['id'];

      return FutureBuilder(
          future: !isOpened
              ? MetadataMovieService().getMetadataMovie(id)
              : Future<Movie>.value(arguments['movie'] as Movie),
          builder: (_, AsyncSnapshot<Movie> snapshot) {
            if (!snapshot.hasData) {
              return const MetadataShimmer();
            }

            Movie movie = snapshot.data!;

            if (!isOpened) {
              final HomepageProvider homepageProvider =
                  Provider.of<HomepageProvider>(context);
              homepageProvider.openedMovies.addAll({movie.id: movie});
            }

            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: Column(
                      children: [
                        _Header(movie: movie),
                        _Genres(movie.genres),
                        _Cast(cast: movie.cast),
                        _Synopsis(overview: movie.synopsis),
                        _Justwatch(justwatch: movie.justwatch),
                        movie.reviews.isNotEmpty
                            ? _Reviews(movie.reviews)
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } catch (e) {
      return Center(child: Text(e.toString()));
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.movie}) : super(key: key);

  final Movie movie;
  final double _height = 220;

  @override
  Widget build(BuildContext context) {
    final String director = movie.director ?? '';
    String flag = '';
    String aux = removeDiacritics(movie.country.trim().toLowerCase());
    double sizeDirector = director.length > 20 ? 14 : 16;
    FlagsAssets.flags.forEach((key, value) {
      if (value.contains(aux)) {
        flag = key;
      }
    });
    return SizedBox(
      height: _height,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
          flex: 60,
          child: Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.poster),
                  height: _height),
            ),
          ),
        ),
        Flexible(flex: 5, child: Container()),
        Flexible(
          flex: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(movie.title,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2),
              ),
              if (director.isNotEmpty)
                Text(director,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: sizeDirector)),
              if (director.isNotEmpty)
                const SizedBox(
                  height: 10,
                ),
              Row(
                children: [
                  if (flag.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/flags/$flag.png',
                        width: 30,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.error),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    movie.country,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('${movie.year}  ·  ${movie.duration ?? '---'}',
                  style: const TextStyle(fontSize: 17)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          movie.average.isNotEmpty ? movie.average : '---',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ]),
                      _FavoriteMovie(movie: movie)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _FavoriteMovie extends StatefulWidget {
  const _FavoriteMovie({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  State<_FavoriteMovie> createState() => _FavoriteMovieState();
}

class _FavoriteMovieState extends State<_FavoriteMovie> {
  bool? isFavorite;

  @override
  void initState() {
    FavoriteMovieDatabase.retrieveFavoriteMovies().then((value) => setState(() {
          isFavorite = value.any((element) => element.id == widget.movie.id);
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isFavorite == null) {
      return const SizedBox();
    }

    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
              onPressed: () async {
                bool canVibrate = await Vibrate.canVibrate;

                if (canVibrate) {
                  Vibrate.feedback(FeedbackType.medium);
                }

                bool isSuccess;

                if (!isFavorite!) {
                  isSuccess = await FavoriteMovieProvider()
                      .addFavoriteMovie(widget.movie);
                } else {
                  isSuccess = await FavoriteMovieDatabase.deleteFavoriteMovie(
                      widget.movie.id);
                }

                if (isSuccess) {
                  setState(() {
                    isFavorite = !isFavorite!;
                  });
                }
              },
              icon: Icon(
                isFavorite! ? Icons.save : MyIcons.heartEmpty,
                size: 25,
              )),
        ));
  }
}

class _Genres extends StatelessWidget {
  const _Genres(this.genres, {Key? key}) : super(key: key);

  final List<String> genres;
  final int maxGenres = 4;

  @override
  Widget build(BuildContext context) {
    int end = genres.length >= maxGenres ? maxGenres : genres.length;
    List<String> subGenres = genres.sublist(0, end);
    //subGenres.sort((a, b) => a.length.compareTo(b.length));

    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(spacing: 10, runSpacing: 10, children: [
          for (final genre in subGenres)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  color: Colors.blue,
                  width: genre.length > 15 ? 110 : 80,
                  height: 30,
                  child: Center(
                      child: Text(
                    genre,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: genre.length > 15 ? 11 : 12,
                        fontWeight: FontWeight.w500),
                  ))),
            )
        ]),
      ),
    );
  }
}

class _Cast extends StatelessWidget {
  const _Cast({Key? key, required this.cast}) : super(key: key);

  final String cast;
  final int _maxLines = 3;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TitleSection(title: localization!.cast),
        Text(cast,
            textAlign: TextAlign.start,
            maxLines: _maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 17, height: 1.3)),
      ],
    );
  }
}

class _Synopsis extends StatefulWidget {
  const _Synopsis({Key? key, required this.overview}) : super(key: key);

  final String overview;
  final int minLines = 5;

  @override
  State<_Synopsis> createState() => _SynopsisState();
}

class _SynopsisState extends State<_Synopsis> {
  int showMore = 0;
  int maxLines = 5;
  final int delimiterLines = 420;

  @override
  void initState() {
    widget.overview.length > delimiterLines
        ? maxLines = widget.minLines
        : maxLines = widget.overview.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    Map<int, String> textButton = {
      0: localization!.see_more,
      1: localization.see_less,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSection(title: localization.synopsis),
        Text(widget.overview,
            style: const TextStyle(fontSize: 17, height: 1.3),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines),
        if (widget.overview.length > delimiterLines)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () => updateState(),
                  child: Text(textButton[showMore]!)),
            ),
          )
      ],
    );
  }

  updateState() {
    if (maxLines == widget.minLines) {
      maxLines = widget.overview.length;
      showMore = 1;
    } else {
      maxLines = widget.minLines;
      showMore = 0;
    }
    setState(() {});
  }
}

class _Justwatch extends StatefulWidget {
  const _Justwatch({Key? key, required this.justwatch}) : super(key: key);

  final Justwatch justwatch;

  @override
  State<_Justwatch> createState() => _JustwatchState();
}

class _JustwatchState extends State<_Justwatch> {
  late List<Platform> platforms;
  bool isFlatrateSelected = false;
  bool isRentSelected = false;
  bool isBuySelected = false;

  @override
  void initState() {
    if (widget.justwatch.flatrate.isNotEmpty) {
      isFlatrateSelected = true;
      platforms = widget.justwatch.flatrate;
    } else if (widget.justwatch.rent.isNotEmpty) {
      isRentSelected = true;
      platforms = widget.justwatch.rent;
    } else {
      isBuySelected = true;
      platforms = widget.justwatch.buy;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    const double height = 75;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSection(title: localization!.watch_now),
        Row(
          children: [
            if (widget.justwatch.flatrate.isEmpty &&
                widget.justwatch.rent.isEmpty &&
                widget.justwatch.buy.isEmpty)
              Expanded(
                  child: Text(
                localization.no_platforms,
                textAlign: TextAlign.center,
              )),
            if (widget.justwatch.flatrate.isNotEmpty)
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 40,
                  decoration: isFlatrateSelected
                      ? BoxDecorators.decoratorSelectedButton()
                      : BoxDecorators.decoratorUnselectedButton(),
                  child: TextButton(
                      onPressed: () {
                        setPlatforms('flatrate');
                      },
                      child: Text(localization.flatrate))),
            if (widget.justwatch.rent.isNotEmpty)
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 40,
                  decoration: isRentSelected
                      ? BoxDecorators.decoratorSelectedButton()
                      : BoxDecorators.decoratorUnselectedButton(),
                  child: TextButton(
                      onPressed: () {
                        setPlatforms('rent');
                      },
                      child: Text(localization.rent))),
            if (widget.justwatch.buy.isNotEmpty)
              Container(
                height: 40,
                decoration: isBuySelected
                    ? BoxDecorators.decoratorSelectedButton()
                    : BoxDecorators.decoratorUnselectedButton(),
                child: TextButton(
                    onPressed: () {
                      setPlatforms('buy');
                    },
                    child: Text(localization.buy)),
              ),
          ],
        ),
        if (widget.justwatch.flatrate.isNotEmpty ||
            widget.justwatch.rent.isNotEmpty ||
            widget.justwatch.buy.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: height,
            child: ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemCount: platforms.length,
                itemBuilder: (BuildContext context, int index) {
                  String name = platforms[index].name;
                  String asset = '';
                  JustwatchAssets.justwatchAssets.forEach((key, value) {
                    if (value.contains(name.toLowerCase())) {
                      asset = key;
                    }
                  });

                  return JustwatchItem(asset: asset);
                }),
          ),
      ],
    );
  }

  setPlatforms(String platform) {
    if (platform == 'flatrate') {
      platforms = widget.justwatch.flatrate;
      isFlatrateSelected = true;
      isRentSelected = false;
      isBuySelected = false;
    } else if (platform == 'rent') {
      platforms = widget.justwatch.rent;
      isRentSelected = true;
      isFlatrateSelected = false;
      isBuySelected = false;
    } else if (platform == 'buy') {
      platforms = widget.justwatch.buy;
      isBuySelected = true;
      isRentSelected = false;
      isFlatrateSelected = false;
    }

    setState(() {});
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews(this.reviews, {Key? key}) : super(key: key);

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 70.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSection(title: localization!.reviews),
          for (final review in reviews)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ReviewItem(review: review),
            )
        ],
      ),
    );
  }
}
