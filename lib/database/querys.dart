String createTableFavoriteMovie = """
    CREATE TABLE favorite_movies (
      id TEXT PRIMARY KEY,
      poster TEXT NOT NULL,
      title TEXT NOT NULL,
      director TEXT NOT NULL
    );
  """;

String createTableGroups = """
    CREATE TABLE groups (
      id INTEGER PRIMARY KEY AUTO INCREMENT,
      name TEXT NOT NULL
    );
  """;

String createTableJustwatch = """
    CREATE TABLE justwatch (
      id INTEGER PRIMARY KEY AUTO INCREMENT,
      id_movie INTEGER NOT NULL REFERENCES favorite_movies(id),
      flatrate TEXT NOT NULL,
      rent TEXT NOT NULL,
      buy TEXT NOT NULL
      """;

String createTableReviews = """
    CREATE TABLE reviews (
      id INTEGER PRIMARY KEY AUTO INCREMENT,
      id_movie INTEGER NOT NULL REFERENCES favorite_movies(id),
      author TEXT NOT NULL,
      content TEXT NOT NULL,
      rating TEXT NOT NULL,
      date TEXT NOT NULL
    );
    """;

String createTableHistorySearch = """
    CREATE TABLE history_search (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      search TEXT NOT NULL UNIQUE
    );
    """;

String deleteTableFavoriteMovie = "DROP TABLE favorite_movies";
String deleteTableGroups = "DROP TABLE groups";
String deleteTableJustwatch = "DROP TABLE justwatch";
String deleteTableReviews = "DROP TABLE reviews";
String deleteTableHistorySearch = "DROP TABLE history_search";
