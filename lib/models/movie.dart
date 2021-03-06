import 'dart:convert' as json;

class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.year,
    this.duration,
    required this.country,
    required this.director,
    this.screenwriter,
    this.music,
    this.cinematography,
    required this.cast,
    this.producer,
    required this.genres,
    this.groups,
    required this.synopsis,
    required this.poster,
    required this.average,
    required this.justwatch,
    required this.reviews,
  });

  String id;
  String title;
  String year;
  String? duration;
  String country;
  String director;
  String? screenwriter;
  String? music;
  String? cinematography;
  String cast;
  String? producer;
  List<String> genres;
  List<dynamic>? groups;
  String synopsis;
  String poster;
  String average;
  Justwatch justwatch;
  List<Review> reviews;

  factory Movie.fromJson(String str) => Movie.fromMap(json.jsonDecode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        id: json['id'],
        title: json['title'],
        year: json['year'],
        duration: json['duration'],
        country: json['country'],
        director: json['director'],
        screenwriter: json['screenwriter'],
        music: json['music'],
        cinematography: json['cinematography'],
        cast: json['cast'],
        producer: json['producer'],
        genres: List<String>.from(json['genres'].map((x) => x)),
        groups: json['groups'],
        synopsis: json['synopsis'],
        poster: json['poster'],
        average: json['average'],
        justwatch: Justwatch.fromMap(json['justwatch']),
        reviews:
            List<Review>.from(json['reviews'].map((x) => Review.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'year': year,
        'duration': duration,
        'country': country,
        'director': director,
        'screenwriter': screenwriter,
        'music': music,
        'cinematography': cinematography,
        'cast': cast,
        'producer': producer,
        'genres': genres,
        'synopsis': synopsis,
        'poster': poster,
        'average': average,
        'justwatch': justwatch,
        'reviews': List<dynamic>.from(reviews.map((x) => x.toMap())),
      };
}

class Justwatch {
  Justwatch({
    required this.flatrate,
    required this.rent,
    required this.buy,
  });

  List<Platform> flatrate = [];
  List<Platform> rent = [];
  List<Platform> buy = [];

  factory Justwatch.fromMap(Map<String, dynamic> json) {
    return Justwatch(
      flatrate:
          List<Platform>.from(json['flatrate'].map((x) => Platform.fromMap(x))),
      rent: List<Platform>.from(json['rent'].map((x) => Platform.fromMap(x))),
      buy: List<Platform>.from(json['buy'].map((x) => Platform.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        'flatrate': List<dynamic>.from(flatrate.map((x) => x.toMap())),
        'rent': List<dynamic>.from(rent.map((x) => x.toMap())),
        'buy': List<dynamic>.from(buy.map((x) => x.toMap())),
      };
}

class Platform {
  Platform({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Platform.fromMap(Map<String, dynamic> json) => Platform(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };
}

class Review {
  Review({
    required this.body,
    required this.author,
    required this.inclination,
    this.reference,
  });

  String body;
  String author;
  String inclination;
  String? reference;

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        body: json['body'],
        author: json['author'],
        inclination: json['inclination'],
        reference: json['reference'],
      );

  Map<String, dynamic> toMap() => {
        'body': body,
        'author': author,
        'inclination': inclination,
        'reference': reference,
      };
}
