import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class PlacesDB {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, "places.db"),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, location_lat REAL, location_lng REAL, address TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final sqlDB = await PlacesDB.database();

    sqlDB.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDB = await PlacesDB.database();
    return sqlDB.query(table);
  }
}
