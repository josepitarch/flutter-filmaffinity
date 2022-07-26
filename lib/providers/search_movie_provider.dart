import 'package:flutter/cupertino.dart';
import 'package:scrapper_filmaffinity/database/history_search_database.dart';
import 'package:scrapper_filmaffinity/services/search_movie_service.dart';

class SearchMovieProvider extends ChangeNotifier {
  String search = '';
  List<dynamic> movies = [];
  List<String> historySearchers = [];

  SearchMovieProvider() {
    getHistorySearchers();
  }

  setSearch(String value) {
    search = value;
    notifyListeners();
  }

  getHistorySearchers() {
    HistorySearchDatabase.retrieveSearchs().then((value) {
      historySearchers = value;
      notifyListeners();
    });
  }

  deleteAllSearchers() {
    HistorySearchDatabase.deleteAllSearchs().then((value) {
      historySearchers.clear();
      notifyListeners();
    });
  }

  getSearchMovie(String search) {
    this.search = search;
    SearchMovieService().getSuggestions(search).then((value) {
      movies = value;
      bool hasSearch = historySearchers.contains(search);
      if (!hasSearch) {
        historySearchers.add(search);
      }
      notifyListeners();
    });
  }
}
