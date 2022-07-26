import 'package:scrapper_filmaffinity/models/movie.dart';

class FavoriteMovie {
  FavoriteMovie(
      {required this.id,
      required this.poster,
      required this.title,
      required this.director});

  String id;
  String poster;
  String title;
  String director;

  Map<String, String> toMap() {
    return {
      'id': id,
      'poster': poster,
      'title': title,
      'director': director,
    };
  }

  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      year: '',
      country: '',
      cast: '',
      genres: [],
      synopsis: '',
      poster: poster,
      justwatch: Justwatch(buy: [], rent: [], flatrate: []),
      director: director,
      average: '',
      reviews: []
    );
  }
}
