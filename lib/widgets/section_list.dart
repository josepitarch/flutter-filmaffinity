import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrapper_filmaffinity/models/movie.dart';
import 'package:scrapper_filmaffinity/models/section.dart';
import 'package:scrapper_filmaffinity/providers/homepage_provider.dart';
import 'package:scrapper_filmaffinity/widgets/shimmer/homepage_shimmer.dart';

class SectionList extends StatelessWidget {
  const SectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomepageProvider provider = Provider.of<HomepageProvider>(context);

    final List<Section> sections = provider.sections;

    if (provider.existsError) {
      return const Center(child: Text('Error'));
    }

    return sections.isNotEmpty
        ? SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                provider.refresh();
              },
              child: SingleChildScrollView(
                  child: Column(children: [
                ...sections
                    .map((section) => _Section(section: section))
                    .toList(),
                const SizedBox(height: 30),
              ])),
            ),
          )
        : const ShimmerHomepage();
  }
}

class _Section extends StatelessWidget {
  final Section section;

  const _Section({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(section.titleSection,
              style: const TextStyle(fontSize: 20.0)),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: section.films.length,
            itemBuilder: (_, int index) {
              return _SectionMovie(
                film: section.films[index],
              );
            },
          ),
        )
      ],
    );
  }
}

class _SectionMovie extends StatelessWidget {
  final Film film;
  const _SectionMovie({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomepageProvider homepageProvider =
        Provider.of<HomepageProvider>(context);

    const double width = 120;
    const double height = 190;

    return GestureDetector(
      onTap: () {
        Map<String, Movie> openedMovies = homepageProvider.openedMovies;

        Map<String, dynamic> arguments = {
          'isOpened': openedMovies.containsKey(film.id),
          'movie': openedMovies[film.id],
          'id': film.id
        };
        Navigator.pushNamed(context, 'details', arguments: arguments);
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: width,
          height: height,
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Hero(
                    tag: film.id,
                    child: FadeInImage(
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: NetworkImage(film.image),
                        width: width,
                        height: height - 30,
                        fit: BoxFit.cover),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Colors.orange.withOpacity(0.8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        film.premiereDay,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(
              film.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ])),
    );
  }
}
