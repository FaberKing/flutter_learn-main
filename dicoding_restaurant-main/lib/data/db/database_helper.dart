import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavotire = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantFav.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavotire (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavotire, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavotire);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<List<Restaurant>> getSearchFavorite(String query) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.rawQuery(
        'SELECT * FROM $_tblFavotire WHERE name LIKE ? OR description LIKE ? OR city LIKE ?',
        ['%$query%', '%$query%', '%$query%']);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoritekById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavotire,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tblFavotire,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
