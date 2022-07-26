import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';

import 'package:scrapper_filmaffinity/models/section.dart';
import 'package:scrapper_filmaffinity/services/homepage_service.dart';

import '../models/movie.dart';

class HomepageProvider extends ChangeNotifier {
  List<Section> sections = [];
  bool existsError = false;
  Map<String, Movie> openedMovies = {};
  final logger = Logger();

  HomepageProvider() {
    getHomepageMovies();
  }

  getHomepageMovies() async {
    try {
      sections = await HomepageService().getHomepageMovies();
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

  Future<void> refresh() async {
    sections.clear();
    notifyListeners();
    getHomepageMovies();
  }
}
