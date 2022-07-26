import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:scrapper_filmaffinity/models/section.dart';
import 'package:scrapper_filmaffinity/providers/homepage_provider.dart';
import 'package:scrapper_filmaffinity/services/metadata_movie_service.dart';
import 'package:scrapper_filmaffinity/widgets/loading.dart';

import '../models/movie.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomepageProvider homepageProvider =
        Provider.of<HomepageProvider>(context);

    final List<Section> homepageModel = homepageProvider.sections;

    Widget body = homepageModel.isNotEmpty
        ? Center(child: _TitleSection(sections: homepageModel))
        : const Loading();

    if (homepageProvider.existsError) {
      body = const Center(child: Text('Error'));
    }

    return body;
  }
}

class _TitleSection extends StatefulWidget {
  const _TitleSection({
    Key? key,
    required this.sections,
  }) : super(key: key);

  final List<Section> sections;

  @override
  State<_TitleSection> createState() => _TitleSectionState();
}

class _TitleSectionState extends State<_TitleSection> {
  String currentTitle = '';
  final Map<String, List<Film>> data = {};

  @override
  void initState() {
    currentTitle = widget.sections.first.titleSection;
    for (var section in widget.sections) {
      data.addAll({section.titleSection: section.films});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
          value: currentTitle,
          underline: const Text(''),
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
          iconSize: 22,
          alignment: AlignmentDirectional.topCenter,
          items: widget.sections.map((item) {
            return DropdownMenuItem<String>(
              value: item.titleSection,
              child: Text(
                item.titleSection,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              currentTitle = value!;
            });
          },
        ),
        _MovieCard(films: [
          data[currentTitle]![0],
          ...data[currentTitle]!.sublist(1).reversed
        ])
      ],
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    Key? key,
    required this.films,
  }) : super(key: key);

  final List<Film> films;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final HomepageProvider homepageProvider =
        Provider.of<HomepageProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.55,
      child: Swiper(
        curve: Curves.linear,
        itemCount: films.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.5,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              Map<String, Movie> openedMovies = homepageProvider.openedMovies;

              if (openedMovies.containsKey(films.elementAt(index).id)) {
                Navigator.pushNamed(context, 'details',
                    arguments: openedMovies[films.elementAt(index).id]);
              } else {
                MetadataMovieService()
                    .getMetadataMovie(films.elementAt(index).id)
                    .then((value) {
                  homepageProvider.openedMovies
                      .addAll({films.elementAt(index).id: value});
                  Map<String, dynamic> arguments = {
                    'movie': value,
                    'isFavorite': false,
                  };
                  Navigator.pushNamed(context, 'details', arguments: arguments);
                });
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(films[index].image),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
