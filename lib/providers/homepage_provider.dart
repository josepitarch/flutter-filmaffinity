import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';

import 'package:scrapper_filmaffinity/models/section.dart';
import 'package:scrapper_filmaffinity/services/homepageService.dart';

import '../models/movie.dart';

class HomepageProvider extends ChangeNotifier {
  List<Section> homepage = [];
  bool existsError = false;
  Map<String, Movie> openedMovies = {};
  final logger = Logger();

  HomepageProvider() {
    getHomepageMovies();
  }

  getHomepageMovies() async {
    try {
      homepage = await HomepageService().getHomepageMovies();
    } on SocketException catch (e) {
      existsError = true;
      logger.e(e.toString());
    } on TimeoutException catch (e) {
      existsError = true;
      logger.e(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
