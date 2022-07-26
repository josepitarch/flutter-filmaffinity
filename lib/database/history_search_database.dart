import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:scrapper_filmaffinity/database/querys.dart';
import 'package:logger/logger.dart';

class HistorySearchDatabase {
  static initDatabase() async {
    openDatabase(join(await getDatabasesPath(), 'history_search.db'),
        onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(createTableHistorySearch);
    }, onUpgrade: (db, oldVersion, newVersion) {
      db.execute(deleteTableHistorySearch);
      db.execute(createTableHistorySearch);
    }, version: 3);
  }

  static Future<bool> insertSearch(String search) async {
    final logger = Logger();

    final db =
        await openDatabase(join(await getDatabasesPath(), 'history_search.db'));

    try {
      await db.insert(
        'history_search',
        {'search': search},
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return true;
    } on DatabaseException catch (e) {
      logger.i(e.toString());
      return false;
    }
  }

  static Future<bool> deleteAllSearchs() async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'history_search.db'));

    await db.delete(
      'history_search',
    );

    return true;
  }

  static Future<List<String>> retrieveSearchs() async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'history_search.db'));

    final List<Map<String, dynamic>> maps =
        await db.query('history_search', orderBy: 'id DESC', limit: 5);

    return List.generate(maps.length, (i) {
      return maps[i]['search'];
    });
  }
}
