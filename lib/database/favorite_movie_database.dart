import 'package:path/path.dart';
import 'package:scrapper_filmaffinity/database/querys.dart';
import 'package:scrapper_filmaffinity/models/favorite_movie.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteMovieDatabase {
  
  static initDatabase() async {
    openDatabase(join(await getDatabasesPath(), 'favorite_movies.db'),
        onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(createTableFavoriteMovie);
    }, onUpgrade: (db, oldVersion, newVersion) {
      db.execute(deleteTableFavoriteMovie);
      db.execute(createTableFavoriteMovie);
    }, version: 8);
  }

  static Future<bool> insertFavoriteMovie(FavoriteMovie favoriteMovie) async {
    final db = await openDatabase(
        join(await getDatabasesPath(), 'favorite_movies.db'));

    int response = await db.insert(
      'favorite_movies',
      favoriteMovie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );

    return response == 0 ? false : true;
  }

  static Future<bool> deleteFavoriteMovie(String id) async {
    final db = await openDatabase(
        join(await getDatabasesPath(), 'favorite_movies.db'));

    await db.delete(
      'favorite_movies',
      where: 'id = ?',
      whereArgs: [id],
    );

    return true;
  }

  static Future<List<FavoriteMovie>> retrieveFavoriteMovies() async {
    final db = await openDatabase(
        join(await getDatabasesPath(), 'favorite_movies.db'));

    final List<Map<String, dynamic>> maps = await db.query('favorite_movies');

    return List.generate(maps.length, (i) {
      return FavoriteMovie(
          id: maps[i]['id'],
          poster: maps[i]['poster'],
          title: maps[i]['title'],
          director: maps[i]['director']);
    });
  }
}
