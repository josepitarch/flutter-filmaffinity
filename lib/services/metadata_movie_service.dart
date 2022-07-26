import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:scrapper_filmaffinity/models/movie.dart';

class MetadataMovieService {
  final url = dotenv.env['URL']!;
  final timeout = dotenv.env['TIMEOUT']!;

  Future<Movie> getMetadataMovie(String id) async {
    var request = Uri.http(url, '/api/metadata/film', {'id': id});
    var response = await http.get(request);

    return Movie.fromJson(response.body);
  }
}
